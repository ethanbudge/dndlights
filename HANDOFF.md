# Handoff: dndlights Python app

This branch replaces the R/RStudio package with a Python web app (FastAPI +
a plain HTML/JS frontend) covering everything in the task except a few
pieces that need something only you can provide: real credentials, your
existing sound files, and (for live voice recognition) a downloaded speech
model. Everything else is built, wired together, and tested with mocks.

## What's already done

- Every scene/spell/effect ported faithfully from `R/*.R` into
  `dndlights/cues_data.py` (same colors, timings, revert behavior), plus
  ~20 new generic ttrpg cues (`critical_hit`, `level_up`, `boss_intro`,
  `ambush`, `puzzle_solved`, etc.) not tied to any specific spell list.
- English primary trigger + French (original) + first-pass Latin/Arabic/
  Mandarin triggers for every spell/PC-combat effect.
- A FastAPI web app (`dndlights/cli.py` to run it) with a full button grid,
  a Custom-buttons tab (pick a light color + paste a Spotify playlist
  link, no code), a Settings tab, and a voice-trigger toggle -- reachable
  from any phone/computer browser on the same network, no install beyond
  Python.
- LIFX + Spotify clients ported to plain Python/`requests` (no R
  dependency). Both **no-op safely with a logged warning** when
  unconfigured, so the whole app runs and its 47 tests pass with zero
  credentials.
- An offline, open-source (Vosk, Apache-2.0) voice-trigger listener,
  fully wired into the web app's `/ws/voice` WebSocket -- see the gap
  below for what's needed to actually turn it on.
- `pytest` suite (`tests/`) -- 47 tests, all passing, all against mocked
  HTTP/audio, runnable with zero setup: `pip install -e ".[dev]" && pytest`.

## 1. LIFX personal access token

1. Sign in at <https://cloud.lifx.com/settings> and create a personal
   access token.
2. Paste it into the app's **Settings** tab, or put it in
   `~/.dndlights/config.json` as `"lifx_token"` (copy
   `config.example.json` there first), or set the `LIFX_TOKEN` environment
   variable.
3. That's it -- every scene/spell/effect button will start actually
   changing your lights.

## 2. Spotify Developer app

The scene playlist URIs from your original `R/scenes.R` were carried over
as-is into `dndlights/cues_data.py` (`SCENES[...]["playlist"]`) -- **you
don't need to re-enter those**, they're your real playlists already.
What's missing is the app credentials to authenticate as you:

1. Create (or reuse) an app at the
   [Spotify Developer Dashboard](https://developer.spotify.com/dashboard).
2. Edit Settings → Redirect URIs → add exactly `http://127.0.0.1:1410/`
   (Spotify blocked bare `localhost` redirect URIs in April 2025 -- this
   loopback IP literal is still allowed, same fix the R version already
   used).
3. Copy the Client ID and Client Secret into the Settings tab (or
   `config.json` as `spotify_client_id` / `spotify_client_secret`).
4. Run `python3 -c "from dndlights.config import load_config; from dndlights.spotify import SpotifyClient; c=load_config(); SpotifyClient(c['spotify_client_id'], c['spotify_client_secret']).authorize()"`
   once -- a browser tab opens for the consent screen; after you approve,
   the token is cached in `~/.dndlights/spotify_token.json` and every
   later call is silent (including across restarts).
5. Playback control requires **Spotify Premium** and an **active device**
   (have Spotify open and playing on your phone or desktop first).

## 3. Sound effect files

Point `sounds_dir` (Settings tab, or `config.json`) at the same folder of
`.wav` files you were already using with the R package -- filenames are
unchanged (`fireball.wav`, `eldritch_blast.wav`, etc; the ~20 new generic
cues expect their own new filenames, e.g. `critical_hit.wav`, listed in
each entry's `sound` field in `cues_data.py` -- you'll need to source or
record those separately, they didn't exist in the original package).
Missing files don't crash anything -- the light sequence still runs, just
silently.

## 4. Voice recognition models (Vosk) -- the one real capability gap

Live voice triggering needs two things this sandboxed build environment
could not obtain:

1. **`pip install vosk`** (not installed by default -- `pip install -e ".[voice]"`).
2. **A downloaded language model**, from
   <https://alphacephei.com/vosk/models> (small models are ~50MB):
   - English: `vosk-model-small-en-us-0.15`
   - French: `vosk-model-small-fr-0.22`
   - Mandarin: `vosk-model-small-cn-0.22`
   - Arabic: `vosk-model-ar-mgb2-0.4` (no small model as of this writing;
     it's larger, budget accordingly)

   Unzip whichever model(s) you want, and point `vosk_model_dir` (Settings
   tab or `config.json`) at the unzipped folder for your chosen language.
   Switching languages in the app currently expects you to point
   `vosk_model_dir` at the matching model yourself (a future pass could
   auto-select a model directory per language if you keep one folder per
   language, named by language code).

3. **Latin has no entry above on purpose**: there is currently no
   mainstream open-source offline ASR model for Latin (it isn't a
   language any major speech project targets, unlike the other four).
   Latin triggers in `cues_data.py` still work as on-screen buttons or
   bound hotkeys -- they just can't be *spoken* and auto-recognized today.
   If that changes (e.g. a community Vosk-compatible Latin model appears),
   wiring it in is the same one-line `vosk_model_dir` change as any other
   language.

None of this blocks the rest of the app: every button, custom button, and
scene/spell/effect works over HTTP/click immediately; voice is additive.

## 5. Local Desktop repo

The task asked for "a local repo... on my Desktop, from which changes are
committed and pushed" -- that's specifically your machine, which this
sandboxed agent has no access to. Once this PR is merged (or even before,
to keep testing it locally), just:

```bash
git clone https://github.com/ethanbudge/dndlights.git ~/Desktop/dndlights
cd ~/Desktop/dndlights && git checkout main   # or this branch, pre-merge
```

from there it's a normal local git repo you can commit and push from like
any other.

## What I'll do once unblocked

Nothing further is needed from me to make the app work end-to-end once you
supply the above -- it already runs, and the whole button grid/custom
buttons/settings/scene-revert behavior is exercised by the test suite.
"Once unblocked" here just means: you'll see real light and music changes
instead of the "not configured" log warnings, and voice triggering will
start responding to speech instead of closing the WebSocket with an
explanatory error.
