"""
Offline, open-source voice triggering via Vosk (https://alphacephei.com/vosk/,
Apache-2.0). Runs entirely on-device -- no cloud speech API, no account, no
per-request network call -- which is what makes it safe to leave listening
at a table all night: nothing overheard is ever sent anywhere.

Vosk ships small (~50MB) offline models for many languages, including
English, French, and Mandarin, and larger community models for Arabic.
**There is currently no offline open-source ASR model for Latin** (it isn't
a language any mainstream speech-recognition project targets), so Latin
triggers in cues_data.py are button/hotkey-only -- see HANDOFF.md. This is a
real capability gap, not a stand-in for something easy to add later.

This module is intentionally decoupled from the `vosk` package import: model
loading happens lazily in `load_model()`, and `VoiceListener` takes any
object satisfying the `Recognizer` protocol below, so the matching/firing
logic can be fully unit-tested with a fake recognizer -- no model download,
no microphone, no audio hardware required.
"""

from __future__ import annotations

import json
import logging
from typing import Callable, Optional, Protocol

from ..triggers import TriggerMatch, build_index, match_text

logger = logging.getLogger("dndlights.voice")


class Recognizer(Protocol):
    """Duck-types vosk.KaldiRecognizer's streaming API."""

    def AcceptWaveform(self, data: bytes) -> bool: ...  # noqa: N802
    def Result(self) -> str: ...  # noqa: N802
    def PartialResult(self) -> str: ...  # noqa: N802


def load_model(model_dir: str):
    """Loads a Vosk model directory. Requires `pip install vosk` and a model
    downloaded per HANDOFF.md -- neither is available in this build
    environment, so this path is untested here; exercised by the owner."""
    import vosk  # local import: only required if voice listening is used

    return vosk.Model(model_dir)


def make_recognizer(model, sample_rate: int = 16000) -> Recognizer:
    import vosk

    return vosk.KaldiRecognizer(model, sample_rate)


class VoiceListener:
    """Feed raw 16-bit PCM audio chunks in; get a callback out whenever a
    finalized utterance matches a known trigger phrase for `language`."""

    def __init__(self, recognizer: Recognizer, language: str,
                 on_match: Callable[[TriggerMatch], None]):
        self.recognizer = recognizer
        self.language = language
        self.on_match = on_match
        self._index = build_index(language)

    def feed(self, chunk: bytes) -> Optional[TriggerMatch]:
        """Process one audio chunk. Returns the TriggerMatch if this chunk
        completed an utterance that matched a trigger, else None."""
        if not self.recognizer.AcceptWaveform(chunk):
            return None
        try:
            text = json.loads(self.recognizer.Result()).get("text", "")
        except json.JSONDecodeError:
            return None
        if not text:
            return None
        trig = match_text(text, self.language, index=self._index)
        if trig:
            self.on_match(trig)
        return trig
