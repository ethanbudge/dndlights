# dndlights

An R package for triggering synchronized **D&D sound effects and LIFX smart light animations** — designed to be bound to hotkeys or French voice commands at the table. Covers spells, creature attacks, environmental effects, and full scene control with Spotify playlist integration.

---

## What it does

Call an R function when something happens at the table. Each function plays a themed sound effect and drives your LIFX lights through a colour sequence that matches the flavour of the event. Call `cue_scene()` first to set the ambient lighting and music for wherever the party is — spell effects will automatically revert to that scene's lighting when they finish.

```r
cue_scene("tavern")   # warm amber lantern light + tavern playlist
fireball()            # flash orange → revert to tavern amber
cue_scene("mine")     # near-dark purple mushroom glow + mine playlist
spider_bite()         # green venom flash → revert to mine darkness
```

---

## Installation

```r
install.packages("devtools")
devtools::install_github("YOUR_USERNAME/dndlights")
```

---

## Setup

### 1. LIFX token

1. Go to <https://cloud.lifx.com/settings> and generate a personal access token.
2. Set it for the session:

```r
library(dndlights)
dnd_set_token("your_lifx_token_here")
```

To persist across sessions, add to `.Renviron` (open with `usethis::edit_r_environ()`):

```
LIFX_TOKEN=your_lifx_token_here
```

### 2. Spotify credentials

Playback control requires the **Authorization Code** OAuth flow (not Client Credentials — those tokens lack the `user-modify-playback-state` scope and will be silently rejected by Spotify's player endpoints).

Add your app credentials to `.Renviron` (open with `usethis::edit_r_environ()`):

```
SPOTIFY_CLIENT_ID=your_client_id
SPOTIFY_CLIENT_SECRET=your_client_secret
```

The first time `cue_scene()` is called it will open a browser tab for Spotify's consent screen. After you approve, the token is cached in `~/.httr-oauth` and all subsequent calls — including across R sessions — are silent. No manual token-passing is needed.

### 3. Sound effects

Upload your `.wav` files to a GitHub Release (or any public host), then:

```r
dnd_download_sounds(
  base_url = "https://github.com/YOUR_USERNAME/dndlights/releases/download/v1.0/"
)
```

Or point to an existing folder:

```r
dnd_set_sounds_dir("~/path/to/sounds")
```

### 4. Playlist URIs

Open `R/scenes.R` and replace each `PLACEHOLDER_*` string with the real Spotify URI for that scene. Right-click any playlist in Spotify → Share → Copy Spotify URI.

---

## RStudio Control Panel

Install `shiny` and `miniUI`, then open the addin from the **Addins** menu → *dndlights Control Panel* (or bind it to a keyboard shortcut via Tools → Modify Keyboard Shortcuts).

```r
install.packages(c("shiny", "miniUI"))
```

The panel opens in the Viewer pane with three tabs — **Scenes**, **Spells**, and **Effects** — and a status bar showing the currently active scene colour. Clicking any button calls the corresponding function directly in your R session.

---

## Scene control

`cue_scene()` sets the room lighting and starts a Spotify playlist. All subsequent spell and effect functions will revert to that scene's colour when they finish.

```r
cue_scene("ballroom")    # elegant candlelit gold
cue_scene("combat_1")    # same lighting, combat playlist
cue_scene("ironbottom_neutral")  # harsh desert midday sun
```

| Scene | Description | Colour |
|---|---|---|
| `dueling_club` | Abandoned warehouse arena | Amber gas-lamp `#C87820` @ 30% |
| `noble_house` | Estate office | Oil-lamp gold `#D4961E` @ 28% |
| `detective_office` | Noir detective's office | Single lamp amber `#E8A000` @ 12% |
| `curio_shop` | Magical antique shop | Aged-gold `#BFA030` @ 22% |
| `newspaper` | Newspaper press room | Bright work-lamp `#FFDA80` @ 70% |
| `ironbottom_riots` | Canyon floor at dawn | Desert orange `#E88C14` @ 50% |
| `ironbottom_neutral` | Canyon floor at noon | Blinding desert sun `#FFE060` @ 85% |
| `ironbottom_night` | Canyon floor at night | Torch fire `#B04808` @ 18% |
| `tavern` | Working-class tavern | Warm amber `#CC7820` @ 40% |
| `ballroom` | Aristocratic ballroom | Golden candlelight `#E8C030` @ 38% |
| `combat_1` | Ballroom — combat | Same as `ballroom` |
| `mine` | Mine with glowing mushrooms | Purple bioluminescence `#7800CC` @ 8% |
| `combat_2` | Mine — combat | Same as `mine` |
| `factory` | Molten-metal factory | Orange-red `#E84A00` @ 60% |
| `combat_3` | Factory — combat | Same as `factory` |
| `combat_4` | Bridge over canyon at noon | Same as `ironbottom_neutral` |
| `victory` | Canyon bridge — victory | Same as `combat_4` |
| `dream_sequence` | Fire, ash, blood-red sun | Deep crimson `#C01800` @ 22% |
| `base_1` | Neutral outdoor desert | Warm afternoon `#FFB040` @ 55% |
| `base_2` | Neutral indoor | Warm lamp `#D49020` @ 35% |
| `base_3` | Same as `base_1` — alt playlist | |
| `base_4` | Same as `base_2` — alt playlist | |

---

## Spells

Each spell plays a sound file and runs a light sequence. French voice-command triggers are noted — they are chosen to be uncommon in casual English table conversation.

### Original spells

| Function | Spell | French trigger |
|---|---|---|
| `fireball()` | Fireball | *Boule de feu* |
| `eldritch_blast()` | Eldritch Blast | *Arcane* |
| `ice_knife()` | Ice Knife | *Givre* |
| `shield()` | Shield | *Bouclier* |
| `lightning_bolt()` | Lightning Bolt | *Foudre* |
| `cure_wounds()` | Cure Wounds | *Guérison* |
| `firebolt()` | Firebolt | *Étincelle* |
| `prestidigitation()` | Prestidigitation | *Prestidigitation* |
| `water_whip()` | Water Whip | *Fouet* |
| `magic_missile()` | Magic Missile | *Missile* |

### Expanded spells

| Function | Spell | French trigger |
|---|---|---|
| `light()` | Light | *Lueur* |
| `mage_armor()` | Mage Armor | *Égide* |
| `misty_step()` | Misty Step | *Brume* |
| `private_sanctum()` | Mordenkainen's Private Sanctum | *Citadelle* |
| `booming_blade()` | Booming Blade | *Grondement* |
| `disguise_self()` | Disguise Self | *Mascarade* |
| `haste()` | Haste | *Véloce* |
| `acid_splash()` | Acid Splash | *Vitriol* |
| `heat_metal()` | Heat Metal | *Brasier* |
| `faerie_fire()` | Faerie Fire | *Féerie* |
| `ray_of_frost()` | Ray of Frost | *Verglas* |
| `wall_of_fire()` | Wall of Fire | *Fournaise* |
| `finger_of_death()` | Finger of Death | *Trépas* |
| `disintegrate()` | Disintegrate | *Néant* |
| `blight()` | Blight | *Flétrissure* |
| `mass_healing_word()` | Mass Healing Word | *Cantique* |

---

## Non-spell effects

Environmental and creature events. No voice-command trigger words — call these directly from a hotkey or script.

| Function | Effect |
|---|---|
| `hammer_slam()` | Magical electric-blue hammer impact |
| `arcane_shot()` | Arcane rifle firing |
| `ignite()` | Small combustion burst |
| `gust()` | Rush of wind |
| `wild_shape()` | Druidic Wildshape transformation |
| `spider_bite()` | Spider bite with green poison flash |
| `worm_surge()` | Giant worm erupting from the ground |
| `spore_burst()` | Release of bright purple spores |
| `flask_shatter()` | Alchemical flask shattering |
| `steam_blast()` | Pressurised steam blast |
| `crystal_breath()` | Dragon crystal breath weapon |
| `dragon_bite()` | Dragon bite |
| `arcane_surge()` | Massive metallic arcane energy release |
| `sand_blast()` | Blast of sand |
| `bludgeon()` | Bludgeoning damage impact |
| `slash()` | Slashing damage impact |
| `pierce()` | Piercing damage impact |

---

## Sound file reference

All expected filenames for `dnd_download_sounds()`:

**Spells (original)**
`fireball.wav` · `eldritch_blast.wav` · `ice_knife.wav` · `shield.wav` · `lightning_bolt.wav` · `cure_wounds.wav` · `firebolt.wav` · `prestidigitation.wav` · `water_whip.wav` · `magic_missile.wav`

**Spells (expanded)**
`light.wav` · `mage_armor.wav` · `misty_step.wav` · `private_sanctum.wav` · `booming_blade.wav` · `disguise_self.wav` · `haste.wav` · `acid_splash.wav` · `heat_metal.wav` · `faerie_fire.wav` · `ray_of_frost.wav` · `wall_of_fire.wav` · `finger_of_death.wav` · `disintegrate.wav` · `blight.wav` · `mass_healing_word.wav`

**Non-spell effects**
`hammer_slam.wav` · `arcane_shot.wav` · `ignite.wav` · `gust.wav` · `wild_shape.wav` · `spider_bite.wav` · `worm_surge.wav` · `spore_burst.wav` · `flask_shatter.wav` · `steam_blast.wav` · `crystal_breath.wav` · `dragon_bite.wav` · `arcane_surge.wav` · `sand_blast.wav` · `bludgeon.wav` · `slash.wav` · `pierce.wav`

---

## Voice control setup

Bind French trigger words to R function calls using a hotword engine (e.g. Whisper, any push-to-talk macro tool). Non-spell effects have no trigger words and are intended for direct hotkey binding.

---

## Adding your own effects

1. Add a `.wav` file to your sounds directory.
2. Copy any existing function from `R/spells.R` or `R/effects.R` as a template.
3. Adjust the colour sequence and durations.
4. Re-run `devtools::document()` to update `NAMESPACE`, or add the export manually.

---

## Dependencies

- [`lifx`](https://cran.r-project.org/package=lifx) — LIFX API wrapper
- [`httr`](https://cran.r-project.org/package=httr) — Spotify API calls
- [`jsonlite`](https://cran.r-project.org/package=jsonlite) — JSON serialisation
- `tools` — base R, for the user data directory

Suggested:
- [`spotifyr`](https://cran.r-project.org/package=spotifyr) — recommended for Spotify OAuth token management

Audio playback uses:
- **macOS**: `afplay` (built-in)
- **Linux**: `paplay` / `aplay`
- **Windows**: PowerShell `System.Media.SoundPlayer`

---

## License

MIT
