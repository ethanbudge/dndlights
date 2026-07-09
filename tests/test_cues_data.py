import re

from dndlights.config import SUPPORTED_LANGUAGES
from dndlights.cues_data import EFFECTS, SCENES, SPELLS

HEX_RE = re.compile(r"^#[0-9A-Fa-f]{6}$")


def test_scenes_have_required_fields():
    for scene_id, scene in SCENES.items():
        assert HEX_RE.match(scene["color"]), scene_id
        assert 0 <= scene["brightness"] <= 1, scene_id
        assert scene["playlist"].startswith("spotify:playlist:"), scene_id
        assert scene["group"], scene_id


def test_spell_and_effect_sequences_are_valid():
    for table_name, table in (("spells", SPELLS), ("effects", EFFECTS)):
        for cue_id, cue in table.items():
            assert cue["sound"].endswith(".wav"), f"{table_name}.{cue_id}"
            assert cue["sequence"], f"{table_name}.{cue_id} has an empty sequence"
            for step in cue["sequence"]:
                assert HEX_RE.match(step["color"]), f"{table_name}.{cue_id}"
                assert 0 <= step["brightness"] <= 1, f"{table_name}.{cue_id}"
                assert step["duration"] > 0, f"{table_name}.{cue_id}"
            assert cue["revert_duration"] > 0, f"{table_name}.{cue_id}"


def test_triggers_only_use_supported_languages():
    for table in (SPELLS, EFFECTS):
        for cue_id, cue in table.items():
            triggers = cue.get("triggers")
            if triggers is None:
                continue
            for lang in triggers:
                assert lang in SUPPORTED_LANGUAGES, f"{cue_id} has unsupported language {lang!r}"


def test_no_duplicate_trigger_phrase_within_a_language():
    for lang in SUPPORTED_LANGUAGES:
        seen = {}
        for table_name, table in (("spells", SPELLS), ("effects", EFFECTS)):
            for cue_id, cue in table.items():
                triggers = cue.get("triggers") or {}
                phrase = triggers.get(lang)
                if not phrase:
                    continue
                key = phrase.strip().lower()
                assert key not in seen, (
                    f"Duplicate {lang!r} trigger {phrase!r}: "
                    f"{seen.get(key)} and {table_name}.{cue_id}"
                )
                seen[key] = f"{table_name}.{cue_id}"


def test_ids_dont_collide_across_tables():
    assert not (set(SCENES) & set(SPELLS))
    assert not (set(SCENES) & set(EFFECTS))
    assert not (set(SPELLS) & set(EFFECTS))
