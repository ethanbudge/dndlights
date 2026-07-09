"""
FastAPI app: a small local web server exposing every scene/spell/effect as a
button, a settings page, and a WebSocket for streaming microphone audio in
for voice triggering.

Deliberately browser-first rather than a native app: any phone or computer
on the same network can open http://<dm's-laptop-ip>:8420/ and get the full
button grid with zero install -- which is what "put the phone on the table"
actually needs (see README's "Why a local web app" note). No app-store
distribution, no per-platform build.
"""

from __future__ import annotations

import logging
import threading
from pathlib import Path
from typing import Optional

from fastapi import FastAPI, HTTPException, WebSocket, WebSocketDisconnect
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel

from .. import custom_buttons
from ..config import SUPPORTED_LANGUAGES, load_config, save_config
from ..cues_data import EFFECTS, SCENES, SPELLS
from ..engine import Engine, UnknownCueError
from ..lifx import LifxClient
from ..spotify import SpotifyClient
from ..triggers import build_index, match_text

logger = logging.getLogger("dndlights.web")

STATIC_DIR = Path(__file__).parent / "static"


class LanguageBody(BaseModel):
    language: str


class SettingsBody(BaseModel):
    lifx_token: Optional[str] = None
    spotify_client_id: Optional[str] = None
    spotify_client_secret: Optional[str] = None
    sounds_dir: Optional[str] = None
    vosk_model_dir: Optional[str] = None
    language: Optional[str] = None


class CustomButtonBody(BaseModel):
    id: str
    label: str
    color: Optional[str] = None
    brightness: Optional[float] = None
    transition: float = 2.0
    playlist_uri: Optional[str] = None


class TranscriptBody(BaseModel):
    text: str


def _catalog_entry(cue_id: str, cue: dict, language: str) -> dict:
    triggers = cue.get("triggers") or {}
    return {
        "id": cue_id,
        "group": cue.get("group"),
        "description": cue.get("description", ""),
        "trigger": triggers.get(language),
        "has_voice_trigger": bool(triggers.get(language)),
    }


def _scene_entry(scene_id: str, scene: dict) -> dict:
    return {
        "id": scene_id,
        "group": scene.get("group"),
        "description": scene.get("description", ""),
        "color": scene.get("color"),
    }


def create_app(cfg: Optional[dict] = None, lifx: Optional[LifxClient] = None,
               spotify: Optional[SpotifyClient] = None) -> FastAPI:
    cfg = cfg or load_config()
    lifx = lifx or LifxClient(token=cfg["lifx_token"])
    spotify = spotify or SpotifyClient(
        client_id=cfg["spotify_client_id"],
        client_secret=cfg["spotify_client_secret"],
        redirect_uri=cfg["spotify_redirect_uri"],
        token_cache_path=Path(cfg.get("data_dir", Path.home() / ".dndlights")) / "spotify_token.json",
    )
    engine = Engine(lifx=lifx, spotify=spotify, sounds_dir=cfg["sounds_dir"])

    app = FastAPI(title="dndlights")
    app.state.cfg = cfg
    app.state.engine = engine
    app.state.language = cfg.get("language", "en")
    app.state.custom_buttons_path = cfg["custom_buttons_path"]
    app.state.voice_lock = threading.Lock()

    @app.get("/api/health")
    def health():
        return {"status": "ok", "version": "0.2.0"}

    @app.get("/api/cues")
    def get_cues():
        language = app.state.language
        return {
            "language": language,
            "supported_languages": list(SUPPORTED_LANGUAGES),
            "scenes": [_scene_entry(i, c) for i, c in SCENES.items()],
            "spells": [_catalog_entry(i, c, language) for i, c in SPELLS.items()],
            "effects": [_catalog_entry(i, c, language) for i, c in EFFECTS.items()],
        }

    @app.get("/api/state")
    def get_state():
        return {
            "active_scene": engine.active_scene,
            "language": app.state.language,
            "lifx_configured": lifx.configured,
            "spotify_configured": spotify.configured,
        }

    @app.post("/api/language")
    def set_language(body: LanguageBody):
        if body.language not in SUPPORTED_LANGUAGES:
            raise HTTPException(400, f"Unsupported language: {body.language!r}")
        app.state.language = body.language
        return {"language": app.state.language}

    @app.post("/api/fire/{cue_id}")
    def fire(cue_id: str):
        try:
            engine.fire_any(cue_id)
        except UnknownCueError as exc:
            raise HTTPException(404, str(exc)) from exc
        return {"fired": cue_id}

    @app.get("/api/settings")
    def get_settings():
        c = app.state.cfg
        return {
            "lifx_configured": bool(c["lifx_token"]),
            "spotify_configured": bool(c["spotify_client_id"] and c["spotify_client_secret"]),
            "sounds_dir": c["sounds_dir"],
            "vosk_model_dir": c["vosk_model_dir"],
            "language": app.state.language,
        }

    @app.post("/api/settings")
    def update_settings(body: SettingsBody):
        c = dict(app.state.cfg)
        updates = body.model_dump(exclude_none=True)
        c.update(updates)
        save_config(c)
        app.state.cfg = c

        if "lifx_token" in updates:
            lifx.token = updates["lifx_token"]
            lifx._warned = False
        if "spotify_client_id" in updates:
            spotify.client_id = updates["spotify_client_id"]
            spotify._warned = False
        if "spotify_client_secret" in updates:
            spotify.client_secret = updates["spotify_client_secret"]
        if "sounds_dir" in updates:
            engine.sounds_dir = updates["sounds_dir"]
        if "language" in updates:
            app.state.language = updates["language"]

        return get_settings()

    @app.get("/api/custom-buttons")
    def list_custom_buttons():
        return custom_buttons.load(app.state.custom_buttons_path)

    @app.post("/api/custom-buttons")
    def upsert_custom_button(body: CustomButtonBody):
        try:
            buttons = custom_buttons.upsert(app.state.custom_buttons_path, body.model_dump(exclude_none=True))
        except ValueError as exc:
            raise HTTPException(400, str(exc)) from exc
        return buttons

    @app.delete("/api/custom-buttons/{button_id}")
    def delete_custom_button(button_id: str):
        if not custom_buttons.delete(app.state.custom_buttons_path, button_id):
            raise HTTPException(404, f"No such custom button: {button_id!r}")
        return {"deleted": button_id}

    @app.post("/api/custom-buttons/{button_id}/fire")
    def fire_custom_button(button_id: str):
        buttons = custom_buttons.load(app.state.custom_buttons_path)
        if button_id not in buttons:
            raise HTTPException(404, f"No such custom button: {button_id!r}")
        custom_buttons.fire(buttons[button_id], lifx, spotify)
        return {"fired": button_id}

    @app.post("/api/voice/transcript")
    def submit_transcript(body: TranscriptBody):
        """Fallback path for any external speech-to-text (e.g. the browser's
        own Web Speech API, or a phone shortcut) that already has recognized
        text and just wants to fire whatever it matches -- no Vosk/model
        dependency on this path at all."""
        trig = match_text(body.text, app.state.language)
        if not trig:
            return {"matched": None}
        engine.fire_any(trig.cue_id)
        return {"matched": trig.cue_id, "category": trig.category}

    @app.websocket("/ws/voice")
    async def voice_stream(ws: WebSocket):
        """Streams raw 16kHz mono 16-bit PCM audio in; fires a cue and sends
        back {"matched": ...} whenever an utterance matches a trigger for the
        active language. Requires vosk_model_dir configured with a model for
        that language (see HANDOFF.md) -- closes immediately with a reason if
        not available."""
        await ws.accept()
        model_dir = app.state.cfg.get("vosk_model_dir")
        if not model_dir:
            await ws.send_json({"error": "no vosk_model_dir configured -- see HANDOFF.md"})
            await ws.close()
            return
        try:
            from ..voice.listener import VoiceListener, load_model, make_recognizer
            model = load_model(model_dir)
        except Exception as exc:  # pragma: no cover -- exercised only with a real model
            await ws.send_json({"error": f"could not load voice model: {exc}"})
            await ws.close()
            return

        recognizer = make_recognizer(model)
        matched_holder: dict = {}

        def on_match(trig):
            matched_holder["trig"] = trig

        listener = VoiceListener(recognizer, app.state.language, on_match)
        try:
            while True:
                chunk = await ws.receive_bytes()
                with app.state.voice_lock:
                    listener.feed(chunk)
                if "trig" in matched_holder:
                    trig = matched_holder.pop("trig")
                    engine.fire_any(trig.cue_id)
                    await ws.send_json({"matched": trig.cue_id, "category": trig.category})
        except WebSocketDisconnect:
            pass

    if STATIC_DIR.exists():
        app.mount("/", StaticFiles(directory=str(STATIC_DIR), html=True), name="static")

    return app
