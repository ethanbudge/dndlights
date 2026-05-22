# dndlights

An R package that synchronises **D&D sound effects, LIFX smart-light animations, and Spotify playlists** for live tabletop play. Each spell, creature attack, combat action, and environmental cue is a single R function — bind it to a hotkey, a voice command, or click it in the RStudio dashboard.

```r
cue_scene("tavern")    # warm amber lantern light + tavern playlist starts
fireball()             # orange explosion flashes → lights revert to tavern amber
cue_scene("mine")      # deep mushroom-purple ambience + mine playlist
spider_bite()          # green venom flash → lights revert to mine darkness
```

---

## Quick start

```r
# 1. Install
install.packages("devtools")
devtools::install_github("YOUR_USERNAME/dndlights")

# 2. LIFX
library(dndlights)
dnd_set_token("your_lifx_personal_access_token")

# 3. Spotify (see Setup §2 for the one-time browser auth)
Sys.setenv(SPOTIFY_CLIENT_ID     = "your_client_id",
           SPOTIFY_CLIENT_SECRET = "your_client_secret")

# 4. Sounds (see Setup §3)
dnd_set_sounds_dir("~/path/to/sounds")

# 5. Open the dashboard
dnd_addin()
```

---

## How it works

Three layers stack:

1. **Scene** (`cue_scene()`) — sets ambient lighting *and* starts a looping Spotify playlist for wherever the party is.
2. **Spells** (`fireball()`, `cure_wounds()`, …) — play a sound and run a light sequence, then **fade the lights back to the active scene** so the table isn't left in spell colours.
3. **Effects** (`spider_bite()`, `bludgeon()`, …) — same as spells, for non-spell events: PC attacks, creature actions, environmental cues.

Every function reverts to the scene colour automatically — you never have to clean up.

---

## Setup

### 1. LIFX token

1. Sign in at <https://cloud.lifx.com/settings> and create a **personal access token**.
2. Either set it in your R session:
   ```r
   dnd_set_token("your_token")
   ```
3. Or persist it across sessions — add to `.Renviron` (open with `usethis::edit_r_environ()`):
   ```
   LIFX_TOKEN=your_token
   ```

### 2. Spotify credentials

> **Important**: Spotify blocked `localhost` in redirect URIs in April 2025. You must register `http://127.0.0.1:1410/` instead.

**2a.** In the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard):

1. Open (or create) your app → **Edit Settings → Redirect URIs**.
2. Add exactly: `http://127.0.0.1:1410/` — with the trailing slash.
3. Save.

**2b.** In your R session, set your Client ID and Secret — either via `Sys.setenv()` or in `.Renviron`:

```
SPOTIFY_CLIENT_ID=your_client_id
SPOTIFY_CLIENT_SECRET=your_client_secret
```

**2c.** The first time you call `cue_scene()`, a browser tab opens for Spotify's consent screen. After you approve, the token (plus its refresh token) is cached in `~/.httr-oauth`. Every later call — including across R sessions — is silent and automatic.

Playback control requires a **Spotify Premium** account and an **active device** (open Spotify on your phone or desktop first).

### 3. Sound effects

You need a folder of `.wav` files matching the names in [§ Sound files](#sound-files). Either:

```r
# A. Download from a public host (e.g. a GitHub release you've uploaded)
dnd_download_sounds(
  base_url = "https://github.com/YOUR_USERNAME/dndlights/releases/download/v1.0/"
)

# B. Point at an existing folder
dnd_set_sounds_dir("~/Music/dnd_sounds")
```

### 4. Playlist URIs

Open `R/scenes.R` and replace each `"spotify:playlist:PLACEHOLDER_*"` with the URI of your actual playlist. To get a URI: right-click any playlist in Spotify → Share → Copy Spotify URI.

---

## The dashboard

`dnd_addin()` opens an interactive panel in the RStudio Viewer pane. Three tabs, organised by category, with one-click buttons for every function.

```r
install.packages(c("shiny", "miniUI"))
```

Launch it from the RStudio **Addins** menu → *dndlights Control Panel*, or bind it to a keyboard shortcut (Tools → Modify Keyboard Shortcuts → Keyboard Shortcuts).

A status bar at the top shows which scene is currently active.

---

## Scenes

`cue_scene()` sets the room lighting and starts a Spotify playlist. The scene's colour becomes the new "home" — all subsequent spells and effects revert to it.

```r
cue_scene("ballroom")           # elegant candlelit gold
cue_scene("combat_1")           # same lighting, combat playlist
cue_scene("ironbottom_neutral") # harsh desert midday sun
```

### Indoor locations

| Scene | Description | Colour |
|---|---|---|
| `dueling_club` | Abandoned warehouse arena | Amber gas-lamp `#C87820` @ 30% |
| `noble_house` | Estate office | Oil-lamp gold `#D4961E` @ 28% |
| `detective_office` | Noir detective's office | Single lamp amber `#E8A000` @ 12% |
| `curio_shop` | Magical antique shop | Aged green-gold `#A8B040` @ 30% |
| `newspaper` | Newspaper press room | Bright work-lamp `#FFDA80` @ 70% |
| `tavern` | Working-class tavern | Warm amber `#CC7820` @ 40% |
| `ballroom` | Aristocratic ballroom | Golden candlelight `#E8C030` @ 38% |

### Outdoor & depths

| Scene | Description | Colour |
|---|---|---|
| `ironbottom_riots` | Canyon at dawn | Desert orange `#E88C14` @ 50% |
| `ironbottom_neutral` | Canyon at noon | Blinding desert sun `#FFE060` @ 85% |
| `ironbottom_night` | Canyon at night | Torch fire `#B04808` @ 18% |
| `mine` | Mine with glowing mushrooms | Purple bioluminescence `#7800CC` @ 8% |
| `factory` | Molten-metal factory | Orange-red `#E84A00` @ 60% |
| `dream_sequence` | Fire, ash, blood-red sun | Deep crimson `#C01800` @ 22% |

### Combat & outcome

| Scene | Description | Colour |
|---|---|---|
| `combat_1` | Ballroom — combat | Same as `ballroom` |
| `combat_2` | Mine — combat | Same as `mine` |
| `combat_3` | Factory — combat | Same as `factory` |
| `combat_4` | Bridge over canyon at noon | Same as `ironbottom_neutral` |
| `victory` | Canyon bridge — victory | Same as `combat_4` |

### Ambient

| Scene | Description | Colour |
|---|---|---|
| `base_1` | Neutral outdoor desert | Warm afternoon `#FFB040` @ 55% |
| `base_2` | Neutral indoor | Warm lamp `#D49020` @ 35% |
| `base_3` | Same as `base_1`, alt playlist | |
| `base_4` | Same as `base_2`, alt playlist | |

---

## Spells

Each spell plays a sound, runs a smooth light sequence, then reverts to the active scene. French voice triggers are chosen to be **phonetically distinct from English D&D table chatter** — see [§ Voice control](#voice-control) below for why this matters.

### Offensive

| Function | Spell | French trigger | Panel shortcut |
|---|---|---|---|
| `fireball()` | Fireball | *Boule de feu* | ⌘⌥1 |
| `eldritch_blast()` | Eldritch Blast | *Funeste* | ⌘⌥2 |
| `ice_knife()` | Ice Knife | *Givre* | ⌘⌥3 |
| `lightning_bolt()` | Lightning Bolt | *Foudre* | ⌘⌥4 |
| `firebolt()` | Firebolt | *Étincelle* | ⌘⌥5 |
| `magic_missile()` | Magic Missile | *Carreau* | ⌘⌥6 |
| `acid_splash()` | Acid Splash | *Acerbe* | ⌘⌥7 |
| `ray_of_frost()` | Ray of Frost | *Verglas* | ⌘⌥8 |
| `booming_blade()` | Booming Blade | *Grondement* | ⌘⌥9 |

### Elemental

| Function | Spell | French trigger | Panel shortcut |
|---|---|---|---|
| `water_whip()` | Water Whip | *Fouet* | ⌘⌃1 |
| `heat_metal()` | Heat Metal | *Brasier* | ⌘⌃2 |
| `wall_of_fire()` | Wall of Fire | *Fournaise* | ⌘⌃3 |
| `faerie_fire()` | Faerie Fire | *Féerie* | ⌘⌃4 |

### Necrotic

| Function | Spell | French trigger | Panel shortcut |
|---|---|---|---|
| `blight()` | Blight | *Flétrissure* | ⌘⌃5 |
| `finger_of_death()` | Finger of Death | *Trépas* | ⌘⌃6 |
| `disintegrate()` | Disintegrate | *Néant* | ⌘⌃7 |

### Healing & support

| Function | Spell | French trigger | Panel shortcut |
|---|---|---|---|
| `cure_wounds()` | Cure Wounds | *Guérison* | ⌘⌃8 |
| `mass_healing_word()` | Mass Healing Word | *Cantique* | ⌘⌃9 |
| `haste()` | Haste | *Véloce* | ⌃⌥1 |
| `light()` | Light | *Lueur* | ⌃⌥2 |

### Defense

| Function | Spell | French trigger | Panel shortcut |
|---|---|---|---|
| `shield()` | Shield | *Bouclier* | ⌃⌥3 |
| `mage_armor()` | Mage Armor | *Égide* | ⌃⌥4 |
| `private_sanctum()` | Mordenkainen's Private Sanctum | *Citadelle* | ⌃⌥5 |

### Utility

| Function | Spell | French trigger | Panel shortcut |
|---|---|---|---|
| `prestidigitation()` | Prestidigitation | *Sortilège* | ⌃⌥6 |
| `disguise_self()` | Disguise Self | *Frimousse* | ⌃⌥7 |
| `misty_step()` | Misty Step | *Brume* | ⌃⌥8 |

---

## Effects

### PC combat

| Function | Effect | French trigger | Panel shortcut |
|---|---|---|---|
| `arcane_shot()` | Arcane rifle firing | *Décharge* | ⌃⇧1 |
| `wild_shape()` | Druidic transformation into a beast | *Sauvagine* | ⌃⇧2 |
| `bludgeon()` | Bludgeoning impact frame | *Boutez* | ⌃⇧3 |
| `slash()` | Slashing impact frame | *Taillade* | ⌃⇧4 |
| `pierce()` | Piercing impact frame | *Estoc* | ⌃⇧5 |

### Creatures

No voice triggers — bind to hotkeys or call manually as the DM.

| Function | Effect |
|---|---|
| `spider_bite()` | Spider bite with green poison flash |
| `worm_surge()` | Giant worm erupting from the ground |
| `crystal_breath()` | Dragon crystal breath weapon |
| `dragon_bite()` | Dragon bite |

### Magical & environmental

| Function | Effect |
|---|---|
| `hammer_slam()` | Magical electric-blue hammer impact |
| `arcane_surge()` | Massive metallic arcane energy release |
| `ignite()` | Small combustion burst |
| `gust()` | Rush of wind |
| `sand_blast()` | Blast of sand |
| `steam_blast()` | Pressurised steam blast |
| `spore_burst()` | Release of bright spores |
| `flask_shatter()` | Alchemical flask shattering |

---

## Voice control

French voice triggers solve a real problem at the table: if you bind hotwords to English spell names ("fireball", "lightning"), they fire constantly during normal play. The French triggers are deliberately chosen so that **nothing said in English at a D&D table will phonetically trigger them**.

### Setup (macOS Voice Control → RStudio shortcut path)

Every spell and PC-combat effect is registered as an RStudio addin, so each one can be bound to a keyboard shortcut and then triggered by a voice phrase that types that shortcut.

1. **Install / reinstall** the package so RStudio picks up the addin registry: `devtools::install_github("ethanbudge/dndlights")` then restart RStudio.
2. **Bind shortcuts**: Tools → Modify Keyboard Shortcuts → search for the spell or effect (e.g. `Fireball` or `Boule de feu`) → assign the key combo from the Panel shortcut column above (e.g. ⌘⌥1 for Fireball, ⌃⇧3 for Bludgeon).
3. **Map voice → keystroke**: System Settings → Accessibility → Voice Control → Commands → `+` → set the phrase (e.g. `Boule de feu`) to "Press keyboard shortcut" → record ⌘⌥1.

Now speaking the French phrase will press the shortcut, which fires the spell.

**Two ways to play:**

- **Panel open** — the panel captures ⌘⌥, ⌘⌃, ⌃⌥, and ⌃⇧ shortcuts directly via JavaScript and dispatches the spell or effect without involving RStudio's addin system. Voice Control presses the key combo → the Shiny webview intercepts it → the function fires. A brief on-screen flash confirms which spell triggered.
- **Panel closed** — RStudio's addin system handles the shortcut normally, calling the function directly in the console.

> **Note:** RStudio keyboard shortcuts bound to individual spell addins **do not fire while the panel is open** — the R session is inside Shiny's event loop. The panel's built-in JS shortcuts (⌘⌥, ⌘⌃, ⌃⌥, ⌃⇧) are the workaround for this.

You can also use any other hotword engine (Whisper, Picovoice, push-to-talk macros, etc.) — just have it call the R function directly or press the bound shortcut.

---

## Adding your own effects

1. Add a `.wav` file to your sounds directory.
2. Copy any existing function from `R/spells.R` or `R/effects.R` as a template.
3. Adjust the colour sequence and durations. (Tip: keep brightness/hue jumps gradual — see existing spells for tuning.)
4. Add a voice trigger comment if you want one.
5. Re-run `devtools::document()` to update `NAMESPACE`, or add the export manually.
6. Add a button by appending the function name to the appropriate group in `R/addin.R`.

---

## Sound files

All expected filenames for `dnd_download_sounds()`. Group order matches the dashboard.

**Spells**
`fireball.wav` · `eldritch_blast.wav` · `ice_knife.wav` · `lightning_bolt.wav` · `firebolt.wav` · `magic_missile.wav` · `acid_splash.wav` · `ray_of_frost.wav` · `booming_blade.wav` · `water_whip.wav` · `heat_metal.wav` · `wall_of_fire.wav` · `faerie_fire.wav` · `blight.wav` · `finger_of_death.wav` · `disintegrate.wav` · `cure_wounds.wav` · `mass_healing_word.wav` · `haste.wav` · `light.wav` · `shield.wav` · `mage_armor.wav` · `private_sanctum.wav` · `prestidigitation.wav` · `disguise_self.wav` · `misty_step.wav`

**Effects — PC combat**
`arcane_shot.wav` · `wild_shape.wav` · `bludgeon.wav` · `slash.wav` · `pierce.wav`

**Effects — creatures**
`spider_bite.wav` · `worm_surge.wav` · `crystal_breath.wav` · `dragon_bite.wav`

**Effects — magical & environmental**
`hammer_slam.wav` · `arcane_surge.wav` · `ignite.wav` · `gust.wav` · `sand_blast.wav` · `steam_blast.wav` · `spore_burst.wav` · `flask_shatter.wav`

---

## Dependencies

**Imports** (required):
- [`lifx`](https://cran.r-project.org/package=lifx) — LIFX API wrapper
- [`httr`](https://cran.r-project.org/package=httr) — Spotify OAuth + playback API calls
- `tools` — base R, for the user data directory

**Suggests** (only if you use specific features):
- [`shiny`](https://cran.r-project.org/package=shiny) + [`miniUI`](https://cran.r-project.org/package=miniUI) — the RStudio dashboard
- [`spotifyr`](https://cran.r-project.org/package=spotifyr) — optional helper for inspecting Spotify data outside the package
- [`usethis`](https://cran.r-project.org/package=usethis) — `edit_r_environ()` helper

Audio playback uses your OS's built-in player:
- **macOS** — `afplay`
- **Linux** — `paplay` (falls back to `aplay`)
- **Windows** — PowerShell `System.Media.SoundPlayer`

---

## License

MIT
