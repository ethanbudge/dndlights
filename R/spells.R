# ==============================================================================
# dndlights — Spell Functions
# ==============================================================================
# All light sequences use only change_light() and revert_state() so that every
# colour transition is explicit and individually tunable. Tweak durations to
# match your sound files; the colour story is already set.
#
# French voice-command trigger words are noted above each function.
# ==============================================================================


# ------------------------------------------------------------------------------
#  FIREBALL
#  Voice command (French): "Boule de feu"
# ------------------------------------------------------------------------------

#' Fireball spell effect
#'
#' A slow ignition spark that blooms into a blinding explosion, rolls through
#' deep orange, then settles to a long red ember glow.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
fireball <- function() {
  # FIREBALL — Sound
  play_sound(.get_sound_path("fireball.wav"))
  Sys.sleep(0.15)

  # FIREBALL — Light
  change_light(color_name = "#FF8C00", brightness = 0.20, duration = 0.05) # ignition spark
  change_light(color_name = "#F18805", brightness = 0.50, duration = 0.08) # fireball forming
  change_light(color_name = "#FDBE49", brightness = 0.95, duration = 0.15) # explosion bloom — peak brightness
  change_light(color_name = "#FF6600", brightness = 0.70, duration = 0.10) # rolling fire
  change_light(color_name = "#E84500", brightness = 0.50, duration = 0.20) # deep orange burn
  change_light(color_name = "#db461d", brightness = 0.30, duration = 2.00) # long ember glow holds

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  ELDRITCH BLAST
#  Voice command (French): "Arcane"
# ------------------------------------------------------------------------------

#' Eldritch Blast spell effect
#'
#' Darkness briefly deepens before a cold otherworldly cyan beam fires and
#' fades into void-teal silence.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
eldritch_blast <- function() {
  # ELDRITCH BLAST — Sound
  play_sound(.get_sound_path("eldritch_blast.wav"))

  # ELDRITCH BLAST — Light
  change_light(color_name = "#001F2E", brightness = 0.03, duration = 0.20) # void darkens before the blast
  change_light(color_name = "#84D6EB", brightness = 0.40, duration = 0.15) # cold cyan energy emerges
  change_light(color_name = "#00E5FF", brightness = 0.75, duration = 0.10) # beam fires — peak brightness
  change_light(color_name = "#0097A7", brightness = 0.40, duration = 0.15) # impact
  change_light(color_name = "#0F4C5C", brightness = 0.30, duration = 0.30) # void energy settling
  change_light(color_name = "#003344", brightness = 0.10, duration = 1.50) # deep teal fade to silence

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  ICE KNIFE
#  Voice command (French): "Givre"
# ------------------------------------------------------------------------------

#' Ice Knife spell effect
#'
#' A cold mist rises, ice crystallises in a blinding white flash, the knife
#' hurtles forward in vivid blue and shatters on impact, leaving a lingering
#' frost.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
ice_knife <- function() {
  # ICE KNIFE — Sound
  play_sound(.get_sound_path("ice_knife.wav"))

  # ICE KNIFE — Light
  change_light(color_name = "#E1F5FE", brightness = 0.30, duration = 0.15) # cold mist rising
  change_light(color_name = "#FFFFFF", brightness = 0.95, duration = 0.05) # ice crystallises — blinding white flash
  change_light(color_name = "#B3E5FC", brightness = 0.65, duration = 0.08) # formed ice glimmers pale blue
  change_light(color_name = "#29B6F6", brightness = 0.85, duration = 0.10) # knife in flight — vivid blue
  change_light(color_name = "#0288D1", brightness = 0.55, duration = 0.08) # impact
  change_light(color_name = "#E1F5FE", brightness = 0.25, duration = 0.50) # shatter — frost spray mist
  change_light(color_name = "#01579B", brightness = 0.10, duration = 1.00) # lingering cold

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  SHIELD
#  Voice command (French): "Bouclier"
# ------------------------------------------------------------------------------

#' Shield spell effect
#'
#' A reactive golden flash blooms into brilliant white-gold as the barrier
#' snaps into place, then holds as a steady warm glow before fading.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
shield <- function() {
  # SHIELD — Sound
  play_sound(.get_sound_path("shield.wav"))

  # SHIELD — Light
  change_light(color_name = "#FFFDE7", brightness = 0.40, duration = 0.05) # reactive flash — first instinct
  change_light(color_name = "#FFD700", brightness = 0.80, duration = 0.10) # golden barrier manifests
  change_light(color_name = "#FFFFFF", brightness = 0.95, duration = 0.08) # brilliant white-gold peak
  change_light(color_name = "#FFD700", brightness = 0.60, duration = 0.20) # gold shimmers along barrier
  change_light(color_name = "#FFF8DC", brightness = 0.35, duration = 0.50) # warm protective glow settles
  change_light(color_name = "#FFD700", brightness = 0.20, duration = 2.00) # barrier holds steady, fading

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  LIGHTNING BOLT
#  Voice command (French): "Foudre"
# ------------------------------------------------------------------------------

#' Lightning Bolt spell effect
#'
#' Three rapid blinding white strobes represent the bolt tearing through the
#' air; an electric yellow surge and amber afterburn follow before the ozone
#' dissipates.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
lightning_bolt <- function() {
  # LIGHTNING BOLT — Sound
  play_sound(.get_sound_path("lightning_bolt.wav"))

  # LIGHTNING BOLT — Light
  change_light(color_name = "#FFFFFF", brightness = 1.00, duration = 0.03) # crack 1 — blinding
  change_light(color_name = "#FFFFFF", brightness = 0.02, duration = 0.02) # dark between flashes
  change_light(color_name = "#FFFFFF", brightness = 1.00, duration = 0.03) # crack 2
  change_light(color_name = "#FFFFFF", brightness = 0.02, duration = 0.02) # dark between
  change_light(color_name = "#FFFFFF", brightness = 1.00, duration = 0.04) # crack 3 — sustained
  change_light(color_name = "#FFF176", brightness = 0.90, duration = 0.06) # electric yellow surge
  change_light(color_name = "#F9A825", brightness = 0.55, duration = 0.15) # amber afterburn
  change_light(color_name = "#B0A000", brightness = 0.15, duration = 1.00) # ozone / smolder fade

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  CURE WOUNDS
#  Voice command (French): "Guérison"
# ------------------------------------------------------------------------------

#' Cure Wounds spell effect
#'
#' Healing energy gently rises from nothing — a slow, warm green bloom that
#' peaks and subsides like a breath, leaving the room calm.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
cure_wounds <- function() {
  # CURE WOUNDS — Sound
  play_sound(.get_sound_path("cure_wounds.wav"))

  # CURE WOUNDS — Light
  change_light(color_name = "#E8F5E9", brightness = 0.10, duration = 0.50) # first whisper of healing light
  change_light(color_name = "#A5D6A7", brightness = 0.25, duration = 0.80) # soft green rises
  change_light(color_name = "#66BB6A", brightness = 0.45, duration = 1.00) # healing green brightens
  change_light(color_name = "#81C784", brightness = 0.60, duration = 1.20) # warm healing peak
  change_light(color_name = "#A5D6A7", brightness = 0.30, duration = 1.50) # warmth gently settling
  change_light(color_name = "#C8E6C9", brightness = 0.10, duration = 2.00) # pale green glow fades

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  FIREBOLT
#  Voice command (French): "Étincelle"
# ------------------------------------------------------------------------------

#' Firebolt spell effect
#'
#' Sharper and faster than Fireball — a focused pinpoint ignition that launches
#' as a searing orange bolt and smolders out quickly with no sustained flame.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
firebolt <- function() {
  # FIREBOLT — Sound
  play_sound(.get_sound_path("firebolt.wav"))

  # FIREBOLT — Light
  change_light(color_name = "#FF8C00", brightness = 0.30, duration = 0.05) # ignition
  change_light(color_name = "#FF6200", brightness = 0.95, duration = 0.08) # bolt launches — hot bright orange
  change_light(color_name = "#FF4500", brightness = 0.70, duration = 0.10) # impact — red-orange
  change_light(color_name = "#E83000", brightness = 0.40, duration = 0.15) # deep burn
  change_light(color_name = "#8B1A00", brightness = 0.10, duration = 0.70) # smoldering out

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  PRESTIDIGITATION
#  Voice command (French): "Prestidigitation"
# ------------------------------------------------------------------------------

#' Prestidigitation spell effect
#'
#' A rapid, chaotic rainbow flicker of colours — whimsical and unpredictable,
#' reflecting the minor-trick nature of the cantrip — before settling to a
#' soft orchid shimmer.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
prestidigitation <- function() {
  # PRESTIDIGITATION — Sound
  play_sound(.get_sound_path("prestidigitation.wav"))

  # PRESTIDIGITATION — Light
  change_light(color_name = "#FF00FF", brightness = 0.55, duration = 0.12) # magenta spark
  change_light(color_name = "#00FFFF", brightness = 0.65, duration = 0.10) # cyan flash
  change_light(color_name = "#FFFF00", brightness = 0.55, duration = 0.10) # yellow pop
  change_light(color_name = "#FF6600", brightness = 0.45, duration = 0.10) # orange burst
  change_light(color_name = "#00FF88", brightness = 0.55, duration = 0.10) # green flash
  change_light(color_name = "#FF69B4", brightness = 0.45, duration = 0.12) # hot pink
  change_light(color_name = "#C39BD3", brightness = 0.30, duration = 0.25) # soft lavender settling
  change_light(color_name = "#DA70D6", brightness = 0.15, duration = 0.80) # orchid fade

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  WATER WHIP
#  Voice command (French): "Fouet"
# ------------------------------------------------------------------------------

#' Water Whip spell effect
#'
#' Water gathers in light aqua hues and builds in intensity through deep blues
#' until the whip cracks in a blinding aquamarine flash, then plunges to a
#' dark ocean residue.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
water_whip <- function() {
  # WATER WHIP — Sound
  play_sound(.get_sound_path("water_whip.wav"))

  # WATER WHIP — Light
  change_light(color_name = "#CAF0F8", brightness = 0.20, duration = 0.30) # water gathering — pale aqua
  change_light(color_name = "#90E0EF", brightness = 0.35, duration = 0.25) # building flow
  change_light(color_name = "#00B4D8", brightness = 0.55, duration = 0.20) # whip forming
  change_light(color_name = "#0096C7", brightness = 0.65, duration = 0.15) # coiling, building force
  change_light(color_name = "#48CAE4", brightness = 0.95, duration = 0.10) # the CRACK — blinding aqua flash
  change_light(color_name = "#0077B6", brightness = 0.45, duration = 0.15) # impact
  change_light(color_name = "#023E8A", brightness = 0.20, duration = 0.80) # deep blue residual
  change_light(color_name = "#03045E", brightness = 0.07, duration = 1.20) # dark ocean settling

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  MAGIC MISSILE
#  Voice command (French): "Missile"
# ------------------------------------------------------------------------------

#' Magic Missile spell effect
#'
#' Three auto-hitting darts of arcane force — each represented by a distinct
#' violet pulse separated by near-total void darkness — before settling to a
#' deep arcane purple glow.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
magic_missile <- function() {
  # MAGIC MISSILE — Sound
  play_sound(.get_sound_path("magic_missile.wav"))

  # MAGIC MISSILE — Light
  # — Dart 1 —
  change_light(color_name = "#CC00FF", brightness = 0.85, duration = 0.07) # dart fires — bright violet
  change_light(color_name = "#1A0033", brightness = 0.02, duration = 0.12) # void between darts
  # — Dart 2 —
  change_light(color_name = "#CC00FF", brightness = 0.85, duration = 0.07) # dart 2
  change_light(color_name = "#1A0033", brightness = 0.02, duration = 0.12) # void between
  # — Dart 3 —
  change_light(color_name = "#CC00FF", brightness = 0.85, duration = 0.07) # dart 3
  change_light(color_name = "#9B59B6", brightness = 0.50, duration = 0.15) # arcane afterglow
  change_light(color_name = "#6A0080", brightness = 0.25, duration = 0.50) # deep purple settling
  change_light(color_name = "#3D0066", brightness = 0.08, duration = 1.00) # fade to dark violet

  revert_state(duration = 2)
}
