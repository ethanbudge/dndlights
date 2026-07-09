"""Shared test doubles: no real LIFX/Spotify credentials or network calls."""

from __future__ import annotations

import pytest


class FakeLifx:
    """Minimal stand-in for LifxClient -- just records calls."""

    def __init__(self):
        self.calls = []
        self.configured = True

    def set_color(self, color, brightness, duration, fast=True, wait=True):
        self.calls.append({"color": color, "brightness": brightness, "duration": duration})
        return {"ok": True}


class FakeSpotify:
    """Minimal stand-in for SpotifyClient -- just records calls."""

    def __init__(self):
        self.played = []
        self.configured = True

    def play_playlist(self, playlist_uri):
        self.played.append(playlist_uri)
        return True


@pytest.fixture
def fake_lifx():
    return FakeLifx()


@pytest.fixture
def fake_spotify():
    return FakeSpotify()


class FakeHTTPResponse:
    def __init__(self, status_code=200, json_body=None, text=""):
        self.status_code = status_code
        self._json = json_body if json_body is not None else {}
        self.text = text or str(self._json)

    def json(self):
        return self._json


class FakeSession:
    """Records every call made through it; `responses` is a queue of
    FakeHTTPResponse to return in order (defaults to a 200 empty JSON)."""

    def __init__(self, responses=None):
        self.calls = []
        self._responses = list(responses) if responses else None

    def _respond(self):
        if self._responses:
            return self._responses.pop(0)
        return FakeHTTPResponse(200, {})

    def put(self, url, headers=None, json=None, params=None, timeout=None):
        self.calls.append({"method": "PUT", "url": url, "headers": headers, "json": json, "params": params})
        return self._respond()

    def post(self, url, data=None, json=None, timeout=None):
        self.calls.append({"method": "POST", "url": url, "data": data, "json": json})
        return self._respond()
