import pytest

from dndlights.cues_data import EFFECTS, SCENES, SPELLS
from dndlights.engine import Engine, UnknownCueError


@pytest.fixture
def engine(fake_lifx, fake_spotify, tmp_path):
    return Engine(lifx=fake_lifx, spotify=fake_spotify, sounds_dir=str(tmp_path))


def test_cue_scene_sets_state_and_starts_playlist(engine, fake_lifx, fake_spotify):
    engine.cue_scene("tavern")
    scene = SCENES["tavern"]
    assert engine.active_scene == "tavern"
    assert engine.state_color == scene["color"]
    assert engine.state_brightness == scene["brightness"]
    assert fake_spotify.played == [scene["playlist"]]
    assert fake_lifx.calls[0]["color"] == scene["color"]


def test_unknown_scene_raises(engine):
    with pytest.raises(UnknownCueError):
        engine.cue_scene("nonexistent_scene")


def test_fire_spell_runs_full_sequence_then_reverts(engine, fake_lifx):
    engine.cue_scene("mine")
    calls_before = len(fake_lifx.calls)
    engine.fire_spell("fireball")
    seq_len = len(SPELLS["fireball"]["sequence"])
    # one call per light step, plus a final revert-to-scene call
    assert len(fake_lifx.calls) - calls_before == seq_len + 1
    last_call = fake_lifx.calls[-1]
    assert last_call["color"] == SCENES["mine"]["color"]


def test_fire_effect_works_for_no_trigger_cue(engine):
    engine.fire_effect("spider_bite")  # no exception


def test_unknown_spell_and_effect_raise(engine):
    with pytest.raises(UnknownCueError):
        engine.fire_spell("not_a_spell")
    with pytest.raises(UnknownCueError):
        engine.fire_effect("not_an_effect")


def test_fire_any_dispatches_by_id(engine, fake_spotify):
    engine.fire_any("ballroom")
    assert engine.active_scene == "ballroom"
    engine.fire_any("cure_wounds")  # a spell
    engine.fire_any("ignite")  # an effect
    with pytest.raises(UnknownCueError):
        engine.fire_any("totally_unknown")


def test_all_spells_and_effects_are_fireable(engine):
    for spell_id in SPELLS:
        engine.fire_spell(spell_id)
    for effect_id in EFFECTS:
        engine.fire_effect(effect_id)
