"""
Core playback engine (port of R/helpers.R + R/scenes.R state machine).

Tracks the "ambient" scene color/brightness so spells and effects can fade
back to wherever the scene left off, exactly like the R package's
`.dnd_env` + `revert_state()`.
"""

from __future__ import annotations

import logging
import threading
import time
from typing import Optional

from . import audio
from .cues_data import EFFECTS, SCENES, SPELLS
from .lifx import LifxClient
from .spotify import SpotifyClient

logger = logging.getLogger("dndlights.engine")

DEFAULT_COLOR = "#E0D4CC"
DEFAULT_BRIGHTNESS = 0.10


class UnknownCueError(KeyError):
    pass


class Engine:
    def __init__(self, lifx: LifxClient, spotify: SpotifyClient, sounds_dir: str,
                 sleep_fn=time.sleep):
        self.lifx = lifx
        self.spotify = spotify
        self.sounds_dir = sounds_dir
        self._sleep = sleep_fn
        self.state_color = DEFAULT_COLOR
        self.state_brightness = DEFAULT_BRIGHTNESS
        self.active_scene: Optional[str] = None
        # Serializes light sequences so a manual button press and a voice
        # trigger can't interleave their change_light() calls mid-sequence.
        self.lock = threading.Lock()

    def cue_scene(self, scene_id: str) -> None:
        if scene_id not in SCENES:
            raise UnknownCueError(f"Unknown scene: {scene_id!r}. "
                                   f"Available: {', '.join(sorted(SCENES))}")
        scene = SCENES[scene_id]
        with self.lock:
            self.lifx.set_color(scene["color"], scene["brightness"],
                                 scene.get("transition", 3))
            self.state_color = scene["color"]
            self.state_brightness = scene["brightness"]
            self.active_scene = scene_id
            self.spotify.play_playlist(scene["playlist"])

    def revert(self, duration: float = 4) -> None:
        self.lifx.set_color(self.state_color, self.state_brightness, duration, wait=False)

    def _fire(self, table: dict, cue_id: str, kind: str) -> None:
        if cue_id not in table:
            raise UnknownCueError(f"Unknown {kind}: {cue_id!r}. "
                                   f"Available: {', '.join(sorted(table))}")
        cue = table[cue_id]
        with self.lock:
            if cue.get("sound"):
                path = audio.sound_path(self.sounds_dir, cue["sound"])
                if not audio.play_sound(path):
                    logger.info("Sound not found (continuing without it): %s", path)
            for step in cue["sequence"]:
                self.lifx.set_color(step["color"], step["brightness"], step["duration"])
            self.revert(cue.get("revert_duration", 4))

    def fire_spell(self, spell_id: str) -> None:
        self._fire(SPELLS, spell_id, "spell")

    def fire_effect(self, effect_id: str) -> None:
        self._fire(EFFECTS, effect_id, "effect")

    def fire_any(self, cue_id: str) -> None:
        """Fire a scene, spell, or effect by id, whichever it is."""
        if cue_id in SCENES:
            self.cue_scene(cue_id)
        elif cue_id in SPELLS:
            self.fire_spell(cue_id)
        elif cue_id in EFFECTS:
            self.fire_effect(cue_id)
        else:
            raise UnknownCueError(f"Unknown cue id: {cue_id!r}")
