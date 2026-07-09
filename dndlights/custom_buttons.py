"""
User-defined buttons: a DM can create a button that sets a specific LIFX
color/brightness and/or starts a specific Spotify playlist (by URI or plain
playlist ID, pasted from Spotify's "Share -> Copy Spotify URI" /
"Copy link to playlist"), without editing any code. Persisted as a small
JSON file (see config.custom_buttons_path).
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Optional, TypedDict

from .lifx import LifxClient
from .spotify import SpotifyClient

_PLAYLIST_ID_RE = re.compile(r"^[A-Za-z0-9]{22}$")
_HEX_RE = re.compile(r"^#[0-9A-Fa-f]{6}$")


class CustomButton(TypedDict, total=False):
    id: str
    label: str
    color: Optional[str]
    brightness: Optional[float]
    transition: float
    playlist_uri: Optional[str]


def normalize_playlist_uri(value: str) -> str:
    """Accepts a full spotify:playlist:<id> URI, an open.spotify.com URL, or
    a bare 22-character playlist id, and returns a canonical URI."""
    value = value.strip()
    if not value:
        return value
    if value.startswith("spotify:playlist:"):
        return value.split("?", 1)[0]
    if "open.spotify.com/playlist/" in value:
        playlist_id = value.split("open.spotify.com/playlist/", 1)[1].split("?", 1)[0].split("/", 1)[0]
        return f"spotify:playlist:{playlist_id}"
    if _PLAYLIST_ID_RE.match(value):
        return f"spotify:playlist:{value}"
    raise ValueError(f"Doesn't look like a Spotify playlist URI/URL/ID: {value!r}")


def load(path: str | Path) -> dict[str, CustomButton]:
    p = Path(path)
    if not p.exists():
        return {}
    try:
        return json.loads(p.read_text(encoding="utf-8"))
    except (json.JSONDecodeError, OSError):
        return {}


def save(path: str | Path, buttons: dict[str, CustomButton]) -> None:
    p = Path(path)
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(buttons, indent=2), encoding="utf-8")


def upsert(path: str | Path, button: CustomButton) -> dict[str, CustomButton]:
    if not button.get("id"):
        raise ValueError("Custom button requires a non-empty 'id'.")
    if not button.get("label"):
        raise ValueError("Custom button requires a non-empty 'label'.")
    color = button.get("color")
    if color and not _HEX_RE.match(color):
        raise ValueError(f"Color must be a #rrggbb hex string, got {color!r}")
    brightness = button.get("brightness")
    if brightness is not None and not (0 <= brightness <= 1):
        raise ValueError(f"Brightness must be between 0 and 1, got {brightness!r}")
    playlist_uri = button.get("playlist_uri")
    if playlist_uri:
        button["playlist_uri"] = normalize_playlist_uri(playlist_uri)

    buttons = load(path)
    buttons[button["id"]] = button
    save(path, buttons)
    return buttons


def delete(path: str | Path, button_id: str) -> bool:
    buttons = load(path)
    if button_id not in buttons:
        return False
    del buttons[button_id]
    save(path, buttons)
    return True


def fire(button: CustomButton, lifx: LifxClient, spotify: SpotifyClient) -> None:
    color = button.get("color")
    if color:
        lifx.set_color(color, button.get("brightness", 0.5),
                        button.get("transition", 2), wait=False)
    playlist_uri = button.get("playlist_uri")
    if playlist_uri:
        spotify.play_playlist(playlist_uri)
