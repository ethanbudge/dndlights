import pytest
from fastapi.testclient import TestClient

from dndlights.web.app import create_app


@pytest.fixture
def client(fake_lifx, fake_spotify, tmp_path, monkeypatch):
    monkeypatch.setenv("DNDLIGHTS_CONFIG_PATH", str(tmp_path / "config.json"))
    cfg = {
        "lifx_token": "", "spotify_client_id": "", "spotify_client_secret": "",
        "spotify_redirect_uri": "http://127.0.0.1:1410/",
        "sounds_dir": str(tmp_path / "sounds"),
        "vosk_model_dir": "",
        "language": "en",
        "custom_buttons_path": str(tmp_path / "custom_buttons.json"),
    }
    app = create_app(cfg=cfg, lifx=fake_lifx, spotify=fake_spotify)
    return TestClient(app)


def test_health(client):
    assert client.get("/api/health").json()["status"] == "ok"


def test_cues_catalog_shape(client):
    data = client.get("/api/cues").json()
    assert data["language"] == "en"
    assert len(data["scenes"]) > 0
    assert len(data["spells"]) > 0
    assert len(data["effects"]) > 0
    fireball = next(s for s in data["spells"] if s["id"] == "fireball")
    assert fireball["trigger"] == "fireball"


def test_fire_known_and_unknown_cue(client):
    resp = client.post("/api/fire/fireball")
    assert resp.status_code == 200
    assert resp.json() == {"fired": "fireball"}

    resp = client.post("/api/fire/does_not_exist")
    assert resp.status_code == 404


def test_state_reflects_fired_scene(client):
    client.post("/api/fire/tavern")
    state = client.get("/api/state").json()
    assert state["active_scene"] == "tavern"


def test_set_language_valid_and_invalid(client):
    resp = client.post("/api/language", json={"language": "fr"})
    assert resp.status_code == 200
    assert resp.json()["language"] == "fr"
    assert client.get("/api/cues").json()["language"] == "fr"

    resp = client.post("/api/language", json={"language": "klingon"})
    assert resp.status_code == 400


def test_custom_buttons_crud(client):
    resp = client.post("/api/custom-buttons", json={
        "id": "brawl", "label": "Brawl", "color": "#ff0000", "brightness": 0.5,
    })
    assert resp.status_code == 200
    assert "brawl" in client.get("/api/custom-buttons").json()

    resp = client.post("/api/custom-buttons/brawl/fire")
    assert resp.status_code == 200

    resp = client.delete("/api/custom-buttons/brawl")
    assert resp.status_code == 200
    assert "brawl" not in client.get("/api/custom-buttons").json()

    resp = client.delete("/api/custom-buttons/brawl")
    assert resp.status_code == 404


def test_settings_get_and_update(client):
    resp = client.get("/api/settings").json()
    assert resp["lifx_configured"] is False

    resp = client.post("/api/settings", json={"lifx_token": "newtoken"})
    assert resp.status_code == 200
    assert resp.json()["lifx_configured"] is True


def test_voice_transcript_fallback(client):
    resp = client.post("/api/voice/transcript", json={"text": "cast fireball now"})
    assert resp.status_code == 200
    assert resp.json()["matched"] == "fireball"

    resp = client.post("/api/voice/transcript", json={"text": "nothing relevant"})
    assert resp.json()["matched"] is None
