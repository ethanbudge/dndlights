"""
LIFX HTTP API client (port of R's `lifx` package calls in R/helpers.R).

Talks to https://api.lifx.com/v1/lights/<selector>/state directly over HTTPS
-- no LIFX-specific SDK dependency, just `requests`. Get a personal access
token at https://cloud.lifx.com/settings (see HANDOFF.md).

Without a token configured, every call is a documented no-op (logged once)
rather than an error -- this lets the rest of the app run, and its tests
pass, with no physical lights or LIFX account present.
"""

from __future__ import annotations

import logging
import time

import requests

logger = logging.getLogger("dndlights.lifx")

API_BASE = "https://api.lifx.com/v1"


class LifxClient:
    def __init__(self, token: str = "", selector: str = "all",
                 session: requests.Session | None = None, sleep_fn=time.sleep):
        self.token = token
        self.selector = selector
        self.session = session or requests.Session()
        self._sleep = sleep_fn
        self._warned = False

    @property
    def configured(self) -> bool:
        return bool(self.token)

    def _warn_unconfigured(self) -> None:
        if not self._warned:
            logger.warning("LIFX_TOKEN not set -- light calls are no-ops. See HANDOFF.md.")
            self._warned = True

    def set_color(self, color: str, brightness: float, duration: float,
                   fast: bool = True, wait: bool = True) -> dict | None:
        """Set color/brightness on the configured selector. If `wait`, sleeps
        `duration` seconds afterward so sequential calls chain smoothly, same
        as R's change_light()."""
        if not self.configured:
            self._warn_unconfigured()
            if wait:
                self._sleep(duration)
            return None

        resp = self.session.put(
            f"{API_BASE}/lights/{self.selector}/state",
            headers={"Authorization": f"Bearer {self.token}"},
            json={"color": color, "brightness": brightness,
                  "duration": duration, "fast": fast},
            timeout=10,
        )
        if wait:
            self._sleep(duration)
        if resp.status_code >= 400:
            logger.warning("LIFX API error %s: %s", resp.status_code, resp.text[:200])
            return None
        try:
            return resp.json()
        except ValueError:
            return None
