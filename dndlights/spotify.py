"""
Spotify Web API client (port of R/scenes.R's `.spotify_token()` /
`.spotify_cue_playlist()`).

Uses the OAuth2 Authorization Code flow with PKCE-free client-secret auth
(same as the original R implementation), listening on the loopback redirect
URI Spotify requires since April 2025 (http://127.0.0.1:<port>/ -- "localhost"
is blocked). The token (with its refresh token) is cached to disk so the
interactive browser consent step only happens once per machine.

Requires a Spotify Developer app: see HANDOFF.md for exact setup steps
(client ID/secret, redirect URI registration, Premium account + active
device for playback).

Without credentials configured, every call is a documented no-op so the rest
of the app -- and its tests -- run without a real Spotify account.
"""

from __future__ import annotations

import http.server
import json
import logging
import threading
import time
import urllib.parse
import webbrowser
from pathlib import Path
from typing import Optional

import requests

logger = logging.getLogger("dndlights.spotify")

AUTHORIZE_URL = "https://accounts.spotify.com/authorize"
TOKEN_URL = "https://accounts.spotify.com/api/token"
API_BASE = "https://api.spotify.com/v1"
SCOPE = "user-modify-playback-state"


class SpotifyClient:
    def __init__(self, client_id: str = "", client_secret: str = "",
                 redirect_uri: str = "http://127.0.0.1:1410/",
                 token_cache_path: str | Path = "",
                 session: Optional[requests.Session] = None,
                 sleep_fn=time.sleep):
        self.client_id = client_id
        self.client_secret = client_secret
        self.redirect_uri = redirect_uri
        self.token_cache_path = Path(token_cache_path) if token_cache_path else None
        self.session = session or requests.Session()
        self._sleep = sleep_fn
        self._warned = False

    @property
    def configured(self) -> bool:
        return bool(self.client_id and self.client_secret)

    def _warn_unconfigured(self, reason: str) -> None:
        if not self._warned:
            logger.warning("Spotify %s -- playback calls are no-ops. See HANDOFF.md.", reason)
            self._warned = True

    # -- token cache ----------------------------------------------------

    def _load_cache(self) -> dict:
        if self.token_cache_path and self.token_cache_path.exists():
            try:
                return json.loads(self.token_cache_path.read_text(encoding="utf-8"))
            except (json.JSONDecodeError, OSError):
                return {}
        return {}

    def _save_cache(self, token: dict) -> None:
        if not self.token_cache_path:
            return
        self.token_cache_path.parent.mkdir(parents=True, exist_ok=True)
        self.token_cache_path.write_text(json.dumps(token), encoding="utf-8")

    def _refresh(self, refresh_token: str) -> Optional[dict]:
        resp = self.session.post(TOKEN_URL, data={
            "grant_type": "refresh_token",
            "refresh_token": refresh_token,
            "client_id": self.client_id,
            "client_secret": self.client_secret,
        }, timeout=10)
        if resp.status_code >= 400:
            logger.warning("Spotify token refresh failed: %s", resp.text[:200])
            return None
        token = resp.json()
        token.setdefault("refresh_token", refresh_token)
        token["obtained_at"] = time.time()
        self._save_cache(token)
        return token

    def get_access_token(self) -> Optional[str]:
        if not self.configured:
            self._warn_unconfigured("client ID/secret not set")
            return None
        cache = self._load_cache()
        if not cache:
            self._warn_unconfigured("not yet authorized -- call authorize() once")
            return None
        expires_in = cache.get("expires_in", 3600)
        obtained_at = cache.get("obtained_at", 0)
        if time.time() >= obtained_at + expires_in - 60:
            refreshed = self._refresh(cache["refresh_token"])
            if not refreshed:
                return None
            cache = refreshed
        return cache.get("access_token")

    # -- one-time interactive authorization -------------------------------

    def authorize(self, open_browser: bool = True, timeout: float = 120.0) -> bool:
        """Runs the one-time browser consent flow. Requires a real browser
        and network access to accounts.spotify.com -- not runnable in this
        sandbox; exercised manually by the owner per HANDOFF.md."""
        if not self.configured:
            self._warn_unconfigured("client ID/secret not set")
            return False

        parsed = urllib.parse.urlparse(self.redirect_uri)
        port = parsed.port or 1410
        code_holder: dict[str, str] = {}

        class Handler(http.server.BaseHTTPRequestHandler):
            def do_GET(self):  # noqa: N802
                qs = urllib.parse.urlparse(self.path).query
                params = urllib.parse.parse_qs(qs)
                if "code" in params:
                    code_holder["code"] = params["code"][0]
                self.send_response(200)
                self.send_header("Content-Type", "text/plain")
                self.end_headers()
                self.wfile.write(b"dndlights: authorized, you can close this tab.")

            def log_message(self, *args):  # silence
                pass

        server = http.server.HTTPServer(("127.0.0.1", port), Handler)
        thread = threading.Thread(target=server.handle_request, daemon=True)
        thread.start()

        auth_url = AUTHORIZE_URL + "?" + urllib.parse.urlencode({
            "client_id": self.client_id,
            "response_type": "code",
            "redirect_uri": self.redirect_uri,
            "scope": SCOPE,
        })
        if open_browser:
            webbrowser.open(auth_url)
        else:
            logger.info("Open this URL to authorize Spotify: %s", auth_url)

        thread.join(timeout=timeout)
        if "code" not in code_holder:
            logger.warning("Spotify authorization timed out waiting for redirect.")
            return False

        resp = self.session.post(TOKEN_URL, data={
            "grant_type": "authorization_code",
            "code": code_holder["code"],
            "redirect_uri": self.redirect_uri,
            "client_id": self.client_id,
            "client_secret": self.client_secret,
        }, timeout=10)
        if resp.status_code >= 400:
            logger.warning("Spotify token exchange failed: %s", resp.text[:200])
            return False
        token = resp.json()
        token["obtained_at"] = time.time()
        self._save_cache(token)
        return True

    # -- playback ---------------------------------------------------------

    def play_playlist(self, playlist_uri: str) -> bool:
        token = self.get_access_token()
        if not token:
            return False
        headers = {"Authorization": f"Bearer {token}"}
        self.session.put(f"{API_BASE}/me/player/play", headers=headers,
                          json={"context_uri": playlist_uri}, timeout=10)
        self.session.put(f"{API_BASE}/me/player/shuffle", headers=headers,
                          params={"state": "false"}, timeout=10)
        self.session.put(f"{API_BASE}/me/player/repeat", headers=headers,
                          params={"state": "context"}, timeout=10)
        return True
