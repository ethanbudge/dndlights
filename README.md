# dndlights

Synchronised **sound effects, LIFX smart-light animations, and Spotify
playlists** for live tabletop play — triggered from a button in any browser,
a bound hotkey, or your own voice, in English, French, Latin, Arabic, or
Mandarin. Rewritten from the original R/RStudio package into a small local
Python web app so it runs from a phone or laptop with no IDE, no
accessibility-tool dependency, and no cloud speech API.

```
cue_scene("tavern")     -> warm amber lantern light + tavern playlist starts
fireball                -> orange explosion flashes, lights revert to tavern amber
cue_scene("mine")       -> deep mushroom-purple ambience + mine playlist
spider_bite             -> green venom flash, lights revert to mine darkness
```

## Why a local web app, not a native mobile app

The brief asked for something "usable on any computer or phone" that a DM
could put on the table. A small local web server, opened from any browser on
the same network, gets there with zero install and zero per-platform build:
point any phone or laptop at `http://<dm's-computer>:8420/` and the full
button grid, settings, and voice toggle are right there. A native iOS/Android
app would mean app-store accounts, per-platform builds, and review delays for
something one table uses — this scoping call is explained further in
`HANDOFF.md`.

## Quick start

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -e .
cp config.example.json ~/.dndlights/config.json   # then edit it, see below
python3 -m dndlights.cli
# -> open http://localhost:8420/ (or http://<your LAN IP>:8420/ from a phone)
```

Everything works immediately in "manual button" mode with no credentials at
all -- LIFX/Spotify calls just log a warning and no-op until configured, so
you can try the whole button grid, custom buttons, and language switching
before wiring up real hardware/accounts. See **`HANDOFF.md`** for exactly what
to set up (LIFX token, Spotify app + playlists, sound files, voice-model
download) and where each value goes -- either the Settings tab in the app, or
`~/.dndlights/config.json` directly (`config.example.json` is a template).

## How it works

Three layers stack, same as the original R package:

1. **Scenes** (`cue_scene`) — set ambient lighting *and* start a looping
   Spotify playlist for wherever the party is.
2. **Spells** — play a sound and run a light sequence, then fade back to the
   active scene automatically.
3. **Effects** — same as spells, for non-spell events: PC attacks, creature
   actions, environmental cues.

The full catalog (22 scenes, 26 spells, 38 effects — including ~20 new
generic ttrpg cues like `critical_hit`, `level_up`, `boss_intro`, `ambush`,
not tied to any specific spell list) lives as plain data in
`dndlights/cues_data.py`. Adding your own is copy-paste-and-edit; see
"Adding your own cues" below.

## The control panel

Open the app in a browser (any device, same network) for a tabbed panel:
**Scenes / Spells / Effects / Custom / Settings**. Every button fires
immediately over HTTP; a status bar shows the active scene. The **Custom**
tab lets you define your own buttons -- pick a light color/brightness and
paste in a Spotify playlist link/URI/ID, no code required.

## Voice control

Pick a language from the dropdown (English, French, Latin, Arabic,
Mandarin) and toggle **Listen** -- the browser streams microphone audio to
the server, which runs an **offline, open-source** speech recognizer
([Vosk](https://alphacephei.com/vosk/), Apache-2.0) entirely on-device. Say a
trigger phrase (e.g. "fireball", or French *"boule de feu"*) and the
matching cue fires automatically. Nothing is ever sent to a cloud speech API
-- that's what makes it safe to leave listening at the table all night.

**Latin is button/hotkey-triggerable only** -- there is currently no offline
open-source ASR model for Latin (see `HANDOFF.md` for why, and what to do if
that changes). Live voice recognition needs a downloaded Vosk model per
language; requires `pip install vosk` and a one-time model download (both
skipped in this build environment -- see HANDOFF.md for the exact steps).

Trigger phrases for French come from the original package (chosen to be
phonetically distinct from ordinary English D&D table chatter). The Latin,
Arabic, and Mandarin phrases are a first-pass translation by the agent that
built this port, not a native speaker of any of the three -- worth a
sanity-check from a fluent speaker before relying on them at the table, and
trivial to edit (they're just strings in `cues_data.py`).

## Adding your own cues

1. Add a `.wav` file to your sounds directory (set via Settings or
   `sounds_dir` in config).
2. Copy any existing entry in `dndlights/cues_data.py`'s `SPELLS` or
   `EFFECTS` dict as a template -- `group`, `description`, `sound`,
   `sequence` (list of `{color, brightness, duration}` steps),
   `revert_duration`, and optional `triggers` per language.
3. Keep brightness/hue jumps gradual except for the one "impact" frame (see
   existing entries for tuning) -- and avoid rapid repeated flashing
   (fast strobing can trigger photosensitive seizures); every cue here uses
   at most one bright peak frame, never a repeated strobe.
4. It shows up in the web app automatically -- no registration step.

## Setup

See **`HANDOFF.md`** for exact, step-by-step instructions for:
- LIFX personal access token
- Spotify Developer app (client ID/secret, redirect URI, playlist IDs)
- Sound effect files
- Vosk voice-recognition models (per language)

## Dependencies

- [`fastapi`](https://fastapi.tiangolo.com/) + [`uvicorn`](https://www.uvicorn.org/) -- the web app
- [`requests`](https://requests.readthedocs.io/) -- LIFX + Spotify HTTP calls
- [`vosk`](https://pypi.org/project/vosk/) (optional, `pip install -e ".[voice]"`) -- offline speech recognition

Audio playback uses your OS's built-in player: `afplay` (macOS), `paplay`/`aplay`
(Linux), PowerShell `SoundPlayer` (Windows) -- same as the original package.

## Tests

```bash
pip install -e ".[dev]"
pytest
```

All tests run against mocked LIFX/Spotify HTTP clients and a fake speech
recognizer -- no real credentials, network access, microphone, or lights
required.

## License

MIT
