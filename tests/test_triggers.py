import pytest

from dndlights.config import SUPPORTED_LANGUAGES
from dndlights.triggers import build_index, match_text


def test_build_index_nonempty_for_every_supported_language():
    for lang in SUPPORTED_LANGUAGES:
        index = build_index(lang)
        assert index, f"no triggers found for language {lang!r}"


def test_build_index_rejects_unsupported_language():
    with pytest.raises(ValueError):
        build_index("de")


def test_match_text_finds_exact_phrase():
    match = match_text("fireball", "en")
    assert match is not None
    assert match.cue_id == "fireball"
    assert match.category == "spell"


def test_match_text_finds_phrase_within_sentence():
    match = match_text("did you hear that, someone just cast fireball at the door", "en")
    assert match is not None
    assert match.cue_id == "fireball"


def test_match_text_no_match_returns_none():
    assert match_text("the weather is nice today", "en") is None
    assert match_text("", "en") is None


def test_longest_trigger_phrase_wins():
    # "wall of fire" should not be shadowed by any shorter unrelated match.
    match = match_text("casting wall of fire now", "en")
    assert match is not None
    assert match.cue_id == "wall_of_fire"


def test_match_uses_active_language_only():
    # The French trigger for fireball shouldn't match under English.
    assert match_text("boule de feu", "en") is None
    match = match_text("boule de feu", "fr")
    assert match is not None
    assert match.cue_id == "fireball"
