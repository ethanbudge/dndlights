# dndlights 🎲🔮

An R package for triggering synchronized **D&D spell sound effects and LIFX smart light animations** — designed to be bound to hotkeys or French voice commands at the table.

---

## What it does

When you (or a party member) casts a spell, call the corresponding R function:

```r
fireball()        # Boule de feu
eldritch_blast()  # Arcane
ice_knife()       # Givre
shield()          # Bouclier
lightning_bolt()  # Foudre
cure_wounds()     # Guérison
firebolt()        # Étincelle
prestidigitation()# Prestidigitation
water_whip()      # Fouet
magic_missile()   # Missile
```

Each function simultaneously plays a themed sound effect and drives your LIFX lights through a colour sequence matching the spell's flavour.

---

## Installation

```r
# Install devtools if needed
install.packages("devtools")

# Install dndlights from GitHub
devtools::install_github("YOUR_USERNAME/dndlights")
```

---

## Setup (one-time)

### 1. Get a LIFX API token

1. Go to <https://cloud.lifx.com/settings> and sign in.
2. Generate a personal access token.

### 2. Set your token

```r
library(dndlights)
dnd_set_token("your_lifx_token_here")
```

To persist across R sessions, add this line to your `.Renviron`:

```
LIFX_TOKEN=your_lifx_token_here
```

Open `.Renviron` quickly with:

```r
usethis::edit_r_environ()
```

### 3. Download the sound effects

Upload your `.wav` sound files to a GitHub Release on this repository (or any public host), then run:

```r
dnd_download_sounds(
  base_url = "https://github.com/YOUR_USERNAME/dndlights/releases/download/v1.0/"
)
```

Expected filenames (place these in your release assets):

| Spell             | Filename                  |
|-------------------|---------------------------|
| Fireball          | `fireball.wav`            |
| Eldritch Blast    | `eldritch_blast.wav`      |
| Ice Knife         | `ice_knife.wav`           |
| Shield            | `shield.wav`              |
| Lightning Bolt    | `lightning_bolt.wav`      |
| Cure Wounds       | `cure_wounds.wav`         |
| Firebolt          | `firebolt.wav`            |
| Prestidigitation  | `prestidigitation.wav`    |
| Water Whip        | `water_whip.wav`          |
| Magic Missile     | `magic_missile.wav`       |

### 4. (Optional) Point to an existing sounds folder

If you already have sounds saved locally under different names, copy/rename them to match the table above, then:

```r
dnd_set_sounds_dir("~/path/to/your/sounds/folder")
```

---

## Voice control setup

Each spell has a French trigger word commented at the top of its function definition. These are designed for use with a voice-recognition tool (e.g. Whisper, Speeko, or any hotword engine) that maps a spoken phrase to an R function call or shell command.

| Spell             | French trigger word   |
|-------------------|-----------------------|
| Fireball          | *Boule de feu*        |
| Eldritch Blast    | *Arcane*              |
| Ice Knife         | *Givre*               |
| Shield            | *Bouclier*            |
| Lightning Bolt    | *Foudre*              |
| Cure Wounds       | *Guérison*            |
| Firebolt          | *Étincelle*           |
| Prestidigitation  | *Prestidigitation*    |
| Water Whip        | *Fouet*               |
| Magic Missile     | *Missile*             |

---

## Notes on `prestidigitation()`

`lx_effect_morph()` works best on LIFX Beam or Tile products. If your bulbs don't support it, edit `prestidigitation()` in `R/spells.R` and replace the morph call with `lx_effect_breathe()`.

---

## Adding your own spells

1. Add a new `wav` file to your sounds directory.
2. Copy any existing spell function from `R/spells.R` as a template.
3. Adjust the colours and effect sequence.
4. Add the function name to `NAMESPACE` (or re-run `devtools::document()`).

---

## Dependencies

- [`lifx`](https://cran.r-project.org/package=lifx) — LIFX API wrapper
- `tools` — base R, for the user data directory

Audio playback uses:
- **macOS**: `afplay` (built-in)
- **Linux**: `paplay` / `aplay`
- **Windows**: PowerShell `System.Media.SoundPlayer`

---

## License

MIT
