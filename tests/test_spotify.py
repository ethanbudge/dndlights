import json
import time

from dndlights.spotify import SpotifyClient
from tests.conftest import FakeHTTPResponse, FakeSession


def make_client(tmp_path, session=None):
    return SpotifyClient(
        client_id="cid", client_secret="csecret",
        redirect_uri="http://127.0.0.1:1410/",
        token_cache_path=tmp_path / "token.json",
        session=session or FakeSession(),
    )


def test_unconfigured_client_get_token_returns_none(tmp_path):
    client = SpotifyClient(client_id="", client_secret="", token_cache_path=tmp_path / "t.json")
    assert client.get_access_token() is None


def test_no_cache_yet_returns_none_and_warns(tmp_path):
    client = make_client(tmp_path)
    assert client.get_access_token() is None


def test_cached_valid_token_is_returned(tmp_path):
    client = make_client(tmp_path)
    client._save_cache({
        "access_token": "abc123",
        "refresh_token": "rtok",
        "expires_in": 3600,
        "obtained_at": time.time(),
    })
    assert client.get_access_token() == "abc123"


def test_expired_token_triggers_refresh(tmp_path):
    session = FakeSession(responses=[
        FakeHTTPResponse(200, {"access_token": "new_tok", "expires_in": 3600}),
    ])
    client = make_client(tmp_path, session=session)
    client._save_cache({
        "access_token": "old_tok",
        "refresh_token": "rtok",
        "expires_in": 3600,
        "obtained_at": time.time() - 4000,
    })
    token = client.get_access_token()
    assert token == "new_tok"
    call = session.calls[0]
    assert call["data"]["grant_type"] == "refresh_token"
    cached = json.loads((tmp_path / "token.json").read_text())
    assert cached["refresh_token"] == "rtok"  # preserved across refresh


def test_play_playlist_calls_all_three_endpoints(tmp_path):
    session = FakeSession()
    client = make_client(tmp_path, session=session)
    client._save_cache({
        "access_token": "tok",
        "refresh_token": "rtok",
        "expires_in": 3600,
        "obtained_at": time.time(),
    })
    assert client.play_playlist("spotify:playlist:abc") is True
    urls = [c["url"] for c in session.calls]
    assert any("/me/player/play" in u for u in urls)
    assert any("/me/player/shuffle" in u for u in urls)
    assert any("/me/player/repeat" in u for u in urls)


def test_play_playlist_noop_when_unconfigured(tmp_path):
    client = SpotifyClient(client_id="", client_secret="", token_cache_path=tmp_path / "t.json")
    assert client.play_playlist("spotify:playlist:abc") is False
