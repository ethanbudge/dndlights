"""
Voice-trigger matching: map a chunk of recognized speech text to a spell or
effect id for the active language.

This is deliberately simple substring matching (not fuzzy) -- the same
design the original R package relied on (a hotkey-per-phrase mapped from
macOS Voice Control). Longer phrases are checked first so e.g. "wall of
fire" doesn't get shadowed by a shorter unrelated match.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional

from .config import SUPPORTED_LANGUAGES
from .cues_data import EFFECTS, SPELLS


@dataclass(frozen=True)
class TriggerMatch:
    category: str  # "spell" or "effect"
    cue_id: str
    phrase: str


def _normalize(text: str) -> str:
    return " ".join(text.strip().lower().split())


def build_index(language: str) -> list[tuple[str, TriggerMatch]]:
    if language not in SUPPORTED_LANGUAGES:
        raise ValueError(f"Unsupported language: {language!r}. "
                          f"Supported: {', '.join(SUPPORTED_LANGUAGES)}")

    entries: list[tuple[str, TriggerMatch]] = []
    for table, category in ((SPELLS, "spell"), (EFFECTS, "effect")):
        for cue_id, cue in table.items():
            triggers = cue.get("triggers")
            if not triggers:
                continue
            phrase = triggers.get(language)
            if not phrase:
                continue
            entries.append((_normalize(phrase), TriggerMatch(category, cue_id, phrase)))

    # Longest phrase first so multi-word triggers win over any shorter
    # phrase that happens to be a substring of them.
    entries.sort(key=lambda pair: len(pair[0]), reverse=True)
    return entries


def match_text(text: str, language: str,
               index: Optional[list[tuple[str, TriggerMatch]]] = None) -> Optional[TriggerMatch]:
    haystack = _normalize(text)
    if not haystack:
        return None
    for phrase, trig in (index if index is not None else build_index(language)):
        if phrase and phrase in haystack:
            return trig
    return None
