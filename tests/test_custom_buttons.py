import pytest

from dndlights import custom_buttons
from dndlights.custom_buttons import normalize_playlist_uri


def test_upsert_and_load_round_trip(tmp_path):
    path = tmp_path / "buttons.json"
    custom_buttons.upsert(path, {"id": "tavern_brawl", "label": "Tavern Brawl",
                                  "color": "#ff8800", "brightness": 0.6})
    buttons = custom_buttons.load(path)
    assert "tavern_brawl" in buttons
    assert buttons["tavern_brawl"]["label"] == "Tavern Brawl"


def test_upsert_requires_id_and_label(tmp_path):
    path = tmp_path / "buttons.json"
    with pytest.raises(ValueError):
        custom_buttons.upsert(path, {"label": "No ID"})
    with pytest.raises(ValueError):
        custom_buttons.upsert(path, {"id": "no_label"})


def test_upsert_validates_color_and_brightness(tmp_path):
    path = tmp_path / "buttons.json"
    with pytest.raises(ValueError):
        custom_buttons.upsert(path, {"id": "x", "label": "X", "color": "not-a-color"})
    with pytest.raises(ValueError):
        custom_buttons.upsert(path, {"id": "x", "label": "X", "brightness": 2.0})


def test_delete(tmp_path):
    path = tmp_path / "buttons.json"
    custom_buttons.upsert(path, {"id": "x", "label": "X"})
    assert custom_buttons.delete(path, "x") is True
    assert custom_buttons.delete(path, "x") is False
    assert custom_buttons.load(path) == {}


def test_normalize_playlist_uri_variants():
    assert normalize_playlist_uri("spotify:playlist:37i9dQZF1DXcBWIGoYBM5M") == "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M"
    assert normalize_playlist_uri("spotify:playlist:37i9dQZF1DXcBWIGoYBM5M?si=abc") == "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M"
    assert normalize_playlist_uri("https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M?si=abc") == "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M"
    assert normalize_playlist_uri("37i9dQZF1DXcBWIGoYBM5M") == "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M"
    with pytest.raises(ValueError):
        normalize_playlist_uri("not a playlist")


def test_upsert_normalizes_playlist_uri(tmp_path):
    path = tmp_path / "buttons.json"
    custom_buttons.upsert(path, {"id": "x", "label": "X",
                                  "playlist_uri": "https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M"})
    buttons = custom_buttons.load(path)
    assert buttons["x"]["playlist_uri"] == "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M"


def test_fire_calls_lifx_and_spotify(fake_lifx, fake_spotify):
    button = {"id": "x", "label": "X", "color": "#112233", "brightness": 0.4,
              "playlist_uri": "spotify:playlist:37i9dQZF1DXcBWIGoYBM5M"}
    custom_buttons.fire(button, fake_lifx, fake_spotify)
    assert fake_lifx.calls == [{"color": "#112233", "brightness": 0.4, "duration": 2}]
    assert fake_spotify.played == ["spotify:playlist:37i9dQZF1DXcBWIGoYBM5M"]
