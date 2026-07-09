"""
Runtime configuration for dndlights.

All settings are loaded from (in increasing priority):
1. Built-in defaults below.
2. A local ``config.json`` next to this file's working directory (gitignored
   -- copy ``config.example.json`` to ``config.json`` and fill in your own
   values; see HANDOFF.md).
3. Environment variables, which always win: LIFX_TOKEN, SPOTIFY_CLIENT_ID,
   SPOTIFY_CLIENT_SECRET, DNDLIGHTS_SOUNDS_DIR, DNDLIGHTS_VOSK_MODEL_DIR,
   DNDLIGHTS_LANGUAGE, DNDLIGHTS_CONFIG_PATH, DNDLIGHTS_DATA_DIR.

Nothing here requires real credentials to import or to run the web app in
"manual button" mode -- LIFX/Spotify calls simply no-op with a warning if
unconfigured (see lifx.py / spotify.py).
"""

from __future__ import annotations

import json
import os
from pathlib import Path
from typing import Any


DEFAULT_LANGUAGE = "en"
SUPPORTED_LANGUAGES = ("en", "fr", "la", "ar", "zh")

_DEFAULTS: dict[str, Any] = {
    "lifx_token": "",
    "spotify_client_id": "",
    "spotify_client_secret": "",
    "spotify_redirect_uri": "http://127.0.0.1:1410/",
    "sounds_dir": "",
    "vosk_model_dir": "",
    "language": DEFAULT_LANGUAGE,
    "custom_buttons_path": "",
}


def _data_dir() -> Path:
    override = os.environ.get("DNDLIGHTS_DATA_DIR")
    if override:
        return Path(override)
    return Path.home() / ".dndlights"


def _config_path() -> Path:
    override = os.environ.get("DNDLIGHTS_CONFIG_PATH")
    if override:
        return Path(override)
    return _data_dir() / "config.json"


def load_config() -> dict[str, Any]:
    cfg = dict(_DEFAULTS)

    path = _config_path()
    if path.exists():
        try:
            with open(path, encoding="utf-8") as fh:
                cfg.update(json.load(fh))
        except (json.JSONDecodeError, OSError):
            pass

    env_map = {
        "lifx_token": "LIFX_TOKEN",
        "spotify_client_id": "SPOTIFY_CLIENT_ID",
        "spotify_client_secret": "SPOTIFY_CLIENT_SECRET",
        "sounds_dir": "DNDLIGHTS_SOUNDS_DIR",
        "vosk_model_dir": "DNDLIGHTS_VOSK_MODEL_DIR",
        "language": "DNDLIGHTS_LANGUAGE",
    }
    for key, env_name in env_map.items():
        val = os.environ.get(env_name)
        if val:
            cfg[key] = val

    if not cfg["sounds_dir"]:
        cfg["sounds_dir"] = str(_data_dir() / "sounds")
    if not cfg["custom_buttons_path"]:
        cfg["custom_buttons_path"] = str(_data_dir() / "custom_buttons.json")

    return cfg


def save_config(cfg: dict[str, Any]) -> None:
    path = _config_path()
    path.parent.mkdir(parents=True, exist_ok=True)
    merged = dict(_DEFAULTS)
    merged.update(cfg)
    with open(path, "w", encoding="utf-8") as fh:
        json.dump(merged, fh, indent=2)
