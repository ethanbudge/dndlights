# ==============================================================================
# dndlights — Spell Functions
# ==============================================================================
# Light sequences are timed to the bundled .wav files: each buildup runs until
# the audio's peak amplitude, then a sudden bright "impact" frame fires on the
# hit, and the decay tracks the audio's envelope back down. Buildup colours sit
# in the same hue family as the impact (just muted), so the moment of the hit
# is a brightness/saturation jolt rather than a hue lurch from a dark frame.
#
# French voice-command trigger words are noted above each function. Triggers
# were chosen to be phonetically distinct from common English D&D table chatter
# so push-to-talk / hotword engines don't fire on conversation.
# ==============================================================================


# ------------------------------------------------------------------------------
#  FIREBALL
#  Voice command (French): "Boule de feu"
# ------------------------------------------------------------------------------

#' Fireball spell effect
#'
#' Heat warms in muted orange, the air thickens to near-impact amber, then a
#' sudden white-gold explosion blooms and rolls through rolling fire into a
#' long ember.  Timed to fireball.wav (peak ~1.76s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
fireball <- function() {
  play_sound(.get_sound_path("fireball.wav"))

  change_light(color_name = "#A04018", brightness = 0.35, duration = 0.50) # kindling warmth
  change_light(color_name = "#C8581C", brightness = 0.55, duration = 0.40) # fire gathering
  change_light(color_name = "#E07020", brightness = 0.75, duration = 0.86) # near-impact heat
  change_light(color_name = "#FDBE49", brightness = 0.98, duration = 0.10) # EXPLOSION
  change_light(color_name = "#FF7A00", brightness = 0.82, duration = 0.28) # rolling fire
  change_light(color_name = "#E84500", brightness = 0.58, duration = 0.55) # deep burn
  change_light(color_name = "#C03A14", brightness = 0.30, duration = 1.55) # ember glow

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  ELDRITCH BLAST
#  Voice command (French): "Funeste"
# ------------------------------------------------------------------------------

#' Eldritch Blast spell effect
#'
#' Teal stirs, charges through near-impact cyan, fires in a bright beam,
#' sustains through a second concussive pulse, and settles to void silence.
#' Timed to eldritch_blast.wav (peak ~1.00s, double sub-peak through 1.08s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
eldritch_blast <- function() {
  play_sound(.get_sound_path("eldritch_blast.wav"))

  change_light(color_name = "#0B4858", brightness = 0.25, duration = 0.45) # teal stirs
  change_light(color_name = "#1A7895", brightness = 0.55, duration = 0.30) # cyan charging
  change_light(color_name = "#4AB0CC", brightness = 0.75, duration = 0.25) # near-impact
  change_light(color_name = "#00E5FF", brightness = 0.95, duration = 0.08) # BEAM
  change_light(color_name = "#5BC6E3", brightness = 0.78, duration = 0.18) # sub-peak sustain
  change_light(color_name = "#0097A7", brightness = 0.45, duration = 0.30) # settling
  change_light(color_name = "#0F4C5C", brightness = 0.18, duration = 0.60) # void return
  change_light(color_name = "#001821", brightness = 0.06, duration = 0.40) # silence

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  ICE KNIFE
#  Voice command (French): "Givre"
# ------------------------------------------------------------------------------

#' Ice Knife spell effect
#'
#' Pale light blue snaps to vivid icy blue in a fast peak, then frost spreads
#' down through pale blue into lingering chill.  Timed to ice_knife.wav (peak
#' ~0.14s, end ~1.00s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
ice_knife <- function() {
  play_sound(.get_sound_path("ice_knife.wav"))

  change_light(color_name = "#C0E0F4", brightness = 0.40, duration = 0.06) # mist surge
  change_light(color_name = "#98D0E8", brightness = 0.65, duration = 0.08) # gathering
  change_light(color_name = "#5BB8E8", brightness = 0.95, duration = 0.08) # KNIFE STRIKE
  change_light(color_name = "#80C8E8", brightness = 0.62, duration = 0.18) # chill spread
  change_light(color_name = "#A0D0E8", brightness = 0.38, duration = 0.25) # mist drift
  change_light(color_name = "#80B0D0", brightness = 0.16, duration = 0.45) # lingering chill

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  SHIELD
#  Voice command (French): "Bouclier"
# ------------------------------------------------------------------------------

#' Shield spell effect
#'
#' Gold rises from pale cream through near-impact gold into a bright barrier
#' flash, sustains through several shimmer pulses, and fades to a steady warm
#' hold.  Timed to shield.wav (peak ~0.50s, multiple sustained shimmers).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
shield <- function() {
  play_sound(.get_sound_path("shield.wav"))

  change_light(color_name = "#FFE680", brightness = 0.40, duration = 0.24) # cream rises
  change_light(color_name = "#FFE680", brightness = 0.65, duration = 0.18) # gold brightens
  change_light(color_name = "#FFE680", brightness = 0.92, duration = 0.10) # BARRIER PEAK
  change_light(color_name = "#FFF1B0", brightness = 0.80, duration = 0.22) # shimmer 1
  change_light(color_name = "#FFD700", brightness = 0.62, duration = 0.30) # shimmer 2
  change_light(color_name = "#FFE680", brightness = 0.40, duration = 0.45) # warm settling
  change_light(color_name = "#E8B040", brightness = 0.18, duration = 0.95) # barrier holds

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  LIGHTNING BOLT
#  Voice command (French): "Foudre"
# ------------------------------------------------------------------------------

#' Lightning Bolt spell effect
#'
#' Pale near-white light blue charges, the strike alternates between near-white
#' light yellow and light blue across three thunder cracks, then fades through
#' pale blue — all colours kept close to white.  Timed to lightning_bolt.wav
#' (first crack ~0.16s, secondaries through 0.46s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
lightning_bolt <- function() {
  play_sound(.get_sound_path("lightning_bolt.wav"))

  change_light(color_name = "#DCE8FF", brightness = 0.55, duration = 0.10) # light-blue charge
  change_light(color_name = "#FFF8C8", brightness = 1.00, duration = 0.06) # YELLOW STRIKE
  change_light(color_name = "#DCE8FF", brightness = 0.60, duration = 0.04) # blue dim
  change_light(color_name = "#FFF8C8", brightness = 0.95, duration = 0.06) # yellow crack 2
  change_light(color_name = "#DCE8FF", brightness = 0.55, duration = 0.04) # blue dim
  change_light(color_name = "#FFF8C8", brightness = 0.90, duration = 0.06) # yellow crack 3
  change_light(color_name = "#DCE8FF", brightness = 0.55, duration = 0.20) # blue afterglow
  change_light(color_name = "#E8F0FF", brightness = 0.35, duration = 0.40) # cooling pale blue
  change_light(color_name = "#D8E0F0", brightness = 0.10, duration = 1.00) # last pale fade

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  CURE WOUNDS
#  Voice command (French): "Guérison"
# ------------------------------------------------------------------------------

#' Cure Wounds spell effect
#'
#' A slow warm golden bloom: pale gold whispers, brightens through warm tones,
#' peaks gently, and breathes out through pale gold.  Timed to cure_wounds.wav
#' (peak ~0.88s, sustained pulse through 1.12s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
cure_wounds <- function() {
  play_sound(.get_sound_path("cure_wounds.wav"))

  change_light(color_name = "#FFF0D0", brightness = 0.20, duration = 0.30) # first whisper
  change_light(color_name = "#FFE9A8", brightness = 0.40, duration = 0.30) # soft gold rises
  change_light(color_name = "#FFE08A", brightness = 0.65, duration = 0.28) # warming
  change_light(color_name = "#FFE08A", brightness = 0.90, duration = 0.10) # healing peak
  change_light(color_name = "#FFD46A", brightness = 0.72, duration = 0.30) # breath pulse
  change_light(color_name = "#FFE9A8", brightness = 0.50, duration = 0.40) # warmth settles
  change_light(color_name = "#FFF1C8", brightness = 0.28, duration = 0.70) # pale gold fades
  change_light(color_name = "#F0D098", brightness = 0.12, duration = 1.00) # last warmth

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  FIREBOLT
#  Voice command (French): "Étincelle"
# ------------------------------------------------------------------------------

#' Firebolt spell effect
#'
#' Muted orange gathers, the bolt fires bright orange at peak, holds briefly,
#' and smooths down through amber to a quick ember.  Timed to firebolt.wav
#' (peak ~0.34s, sustained sub-peak through 0.38s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
firebolt <- function() {
  play_sound(.get_sound_path("firebolt.wav"))

  change_light(color_name = "#B05010", brightness = 0.40, duration = 0.20) # gathering
  change_light(color_name = "#E06820", brightness = 0.65, duration = 0.14) # near-impact
  change_light(color_name = "#FF7A00", brightness = 0.95, duration = 0.08) # BOLT FIRES
  change_light(color_name = "#FF8A20", brightness = 0.72, duration = 0.10) # sustain
  change_light(color_name = "#E86A00", brightness = 0.45, duration = 0.20) # cooling amber
  change_light(color_name = "#A03800", brightness = 0.18, duration = 0.30) # smolder
  change_light(color_name = "#5A1A00", brightness = 0.06, duration = 0.50) # ember fade

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  PRESTIDIGITATION
#  Voice command (French): "Sortilège"
# ------------------------------------------------------------------------------

#' Prestidigitation spell effect
#'
#' A subtle whimsical lavender shimmer rises softly, breathes through pale
#' pink-mauve, and fades gently — no harsh peak, the cantrip is minor.  Timed
#' to prestidigitation.wav (peak ~0.96s, gentle).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
prestidigitation <- function() {
  play_sound(.get_sound_path("prestidigitation.wav"))

  change_light(color_name = "#F0E0F0", brightness = 0.18, duration = 0.42) # faint shimmer
  change_light(color_name = "#E0CCEC", brightness = 0.30, duration = 0.30) # soft lavender
  change_light(color_name = "#D8C0E8", brightness = 0.42, duration = 0.24) # gentle peak
  change_light(color_name = "#DCC8E5", brightness = 0.32, duration = 0.30) # settle
  change_light(color_name = "#C8B0D0", brightness = 0.18, duration = 0.45) # drift down
  change_light(color_name = "#A89AB8", brightness = 0.08, duration = 0.80) # quiet fade

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  WATER WHIP
#  Voice command (French): "Fouet"
# ------------------------------------------------------------------------------

#' Water Whip spell effect
#'
#' Muted aqua coils through deeper cyan as the whip winds, snaps in a bright
#' aquamarine crack, sustains through a second strike, and rolls down through
#' deep ocean blue.  Timed to water_whip.wav (peak ~0.94s, crack cluster
#' through 0.98s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
water_whip <- function() {
  play_sound(.get_sound_path("water_whip.wav"))

  change_light(color_name = "#6CC8E0", brightness = 0.30, duration = 0.30) # water gathers
  change_light(color_name = "#48BAD8", brightness = 0.50, duration = 0.30) # whip building
  change_light(color_name = "#38B8DC", brightness = 0.72, duration = 0.34) # near-impact coil
  change_light(color_name = "#48CAE4", brightness = 0.95, duration = 0.08) # CRACK
  change_light(color_name = "#00B4D8", brightness = 0.78, duration = 0.12) # second strike
  change_light(color_name = "#0096C7", brightness = 0.55, duration = 0.20) # impact wash
  change_light(color_name = "#0077B6", brightness = 0.32, duration = 0.30) # deep blue
  change_light(color_name = "#023E8A", brightness = 0.14, duration = 0.60) # ocean settle

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  MAGIC MISSILE
#  Voice command (French): "Carreau"
# ------------------------------------------------------------------------------

#' Magic Missile spell effect
#'
#' Silent void, faint pale-white gathering, then two distinct bright-white
#' dart impacts spaced 160 ms apart, followed by cool white afterglow.  All
#' tones pure white — no gold.  Timed to magic_missile.wav (dart 1 at 1.46s,
#' dart 2 at 1.62s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
magic_missile <- function() {
  play_sound(.get_sound_path("magic_missile.wav"))

  change_light(color_name = "#303040", brightness = 0.10, duration = 0.50) # silent void
  change_light(color_name = "#B0B0C0", brightness = 0.30, duration = 0.36) # energy gathers
  change_light(color_name = "#D0D0E0", brightness = 0.50, duration = 0.60) # near-impact
  change_light(color_name = "#FFFFFF", brightness = 0.98, duration = 0.08) # DART 1
  change_light(color_name = "#707080", brightness = 0.22, duration = 0.08) # brief dim
  change_light(color_name = "#FFFFFF", brightness = 0.95, duration = 0.08) # DART 2
  change_light(color_name = "#E0E0F0", brightness = 0.55, duration = 0.20) # afterglow
  change_light(color_name = "#B0B0C0", brightness = 0.25, duration = 0.40) # cooling
  change_light(color_name = "#606078", brightness = 0.08, duration = 0.70) # last trace

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  LIGHT
#  Voice command (French): "Lueur"
# ------------------------------------------------------------------------------

#' Light spell effect
#'
#' A mote kindles from pale gold, rises through warm white, peaks at full
#' radiance, sustains through pulses, and slowly fades.  Timed to light.wav
#' (peak ~1.02s, sustained through 1.30s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
light <- function() {
  play_sound(.get_sound_path("light.wav"))

  change_light(color_name = "#FFF8E0", brightness = 0.18, duration = 0.40) # faint mote
  change_light(color_name = "#FFFCEA", brightness = 0.40, duration = 0.36) # rising
  change_light(color_name = "#FFFFFA", brightness = 0.65, duration = 0.26) # brightening
  change_light(color_name = "#FFFFFF", brightness = 0.88, duration = 0.10) # FULL LIGHT
  change_light(color_name = "#FFFFF8", brightness = 0.78, duration = 0.28) # sustain pulses
  change_light(color_name = "#FFF8D6", brightness = 0.55, duration = 0.40) # warm hold
  change_light(color_name = "#FFE8A8", brightness = 0.20, duration = 1.20) # slow fade

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  MAGE ARMOR
#  Voice command (French): "Égide"
# ------------------------------------------------------------------------------

#' Mage Armor spell effect
#'
#' A long shimmer braids light blue with gold trim, peaks in a blue-gold
#' barrier flash, and settles to a steady ward.  Timed to mage_armor.wav
#' (peak ~2.10s, very short decay).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
mage_armor <- function() {
  play_sound(.get_sound_path("mage_armor.wav"))

  change_light(color_name = "#B8D8E8", brightness = 0.20, duration = 0.50) # cool shimmer
  change_light(color_name = "#C0D8E0", brightness = 0.36, duration = 0.50) # blue rises
  change_light(color_name = "#D8D8C0", brightness = 0.52, duration = 0.50) # gold trim weaves
  change_light(color_name = "#E8E0B0", brightness = 0.68, duration = 0.60) # near-impact
  change_light(color_name = "#F8E8A8", brightness = 0.88, duration = 0.30) # WARD SEALS
  change_light(color_name = "#C8D8D0", brightness = 0.55, duration = 0.20) # quick settle
  change_light(color_name = "#90B8D8", brightness = 0.32, duration = 0.50) # ward steadies
  change_light(color_name = "#6890B8", brightness = 0.15, duration = 1.20) # steady hold

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  MISTY STEP
#  Voice command (French): "Brume"
# ------------------------------------------------------------------------------

#' Misty Step spell effect
#'
#' Silver mist rises, the caster fades to a near-dark vanish, a soft teal
#' flash signals reappearance, and the mist dissipates.  Timed to
#' misty_step.wav (peak ~0.78s, decay through 1.60s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
misty_step <- function() {
  play_sound(.get_sound_path("misty_step.wav"))

  change_light(color_name = "#E0F7FA", brightness = 0.32, duration = 0.32) # mist rises
  change_light(color_name = "#A8C8D8", brightness = 0.20, duration = 0.30) # caster fading
  change_light(color_name = "#6088A0", brightness = 0.10, duration = 0.16) # vanish point
  change_light(color_name = "#C0E8F0", brightness = 0.70, duration = 0.08) # REAPPEARS
  change_light(color_name = "#80DEEA", brightness = 0.42, duration = 0.22) # mist settles
  change_light(color_name = "#4DD0E1", brightness = 0.22, duration = 0.30) # wisps
  change_light(color_name = "#2080A0", brightness = 0.06, duration = 0.60) # last fade

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  MORDENKAINEN'S PRIVATE SANCTUM
#  Voice command (French): "Citadelle"
# ------------------------------------------------------------------------------

#' Mordenkainen's Private Sanctum spell effect
#'
#' Muted purple wards stir, spread outward through deepening purple, peak as
#' the barrier seals, pulse twice with the sanctum's hum, and settle to a low
#' purple hold.  Timed to private_sanctum.wav (peak ~1.48s, pulse cluster
#' through 1.40s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
private_sanctum <- function() {
  play_sound(.get_sound_path("private_sanctum.wav"))

  change_light(color_name = "#B898C8", brightness = 0.18, duration = 0.45) # wards stir
  change_light(color_name = "#A878C0", brightness = 0.32, duration = 0.45) # spreading
  change_light(color_name = "#9460B8", brightness = 0.48, duration = 0.34) # walls forming
  change_light(color_name = "#8050B0", brightness = 0.62, duration = 0.24) # near-impact
  change_light(color_name = "#B070E0", brightness = 0.88, duration = 0.10) # SANCTUM SEALED
  change_light(color_name = "#7B68EE", brightness = 0.68, duration = 0.30) # pulses
  change_light(color_name = "#6B4A98", brightness = 0.42, duration = 0.30) # settling
  change_light(color_name = "#4A2A78", brightness = 0.25, duration = 0.80) # ward sustained
  change_light(color_name = "#28184A", brightness = 0.10, duration = 1.60) # deep hold

  revert_state(duration = 5)
}


# ------------------------------------------------------------------------------
#  BOOMING BLADE
#  Voice command (French): "Grondement"
# ------------------------------------------------------------------------------

#' Booming Blade spell effect
#'
#' Electric-blue charge gathers along the blade, the swing connects in a sharp
#' white-blue boom, and the thunder rolls through three diminishing pulses
#' before silence.  Timed to booming_blade.wav (peak ~0.26s, roll cluster
#' through 0.58s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
booming_blade <- function() {
  play_sound(.get_sound_path("booming_blade.wav"))

  change_light(color_name = "#4488DD", brightness = 0.42, duration = 0.10) # blade charges
  change_light(color_name = "#88BBFF", brightness = 0.68, duration = 0.16) # near-impact swing
  change_light(color_name = "#E8F4FF", brightness = 0.98, duration = 0.08) # BOOM
  change_light(color_name = "#B0D0FF", brightness = 0.78, duration = 0.10) # roll 1
  change_light(color_name = "#4488DD", brightness = 0.60, duration = 0.14) # roll 2
  change_light(color_name = "#1A52A0", brightness = 0.40, duration = 0.14) # roll 3
  change_light(color_name = "#0A2860", brightness = 0.20, duration = 0.30) # echoes
  change_light(color_name = "#061838", brightness = 0.08, duration = 0.50) # silence

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  DISGUISE SELF
#  Voice command (French): "Frimousse"
# ------------------------------------------------------------------------------

#' Disguise Self spell effect
#'
#' Light blue shimmer rises and weaves with violet as the illusion settles,
#' peaks in a vivid violet flash, and holds in a slow blue-violet fade.  Timed
#' to disguise_self.wav (peak ~1.78s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
disguise_self <- function() {
  play_sound(.get_sound_path("disguise_self.wav"))

  change_light(color_name = "#B8D0E8", brightness = 0.25, duration = 0.45) # cool shimmer
  change_light(color_name = "#A8B8D8", brightness = 0.38, duration = 0.40) # light blue rises
  change_light(color_name = "#9888C8", brightness = 0.52, duration = 0.40) # blue-violet weave
  change_light(color_name = "#8070C0", brightness = 0.65, duration = 0.53) # near-impact
  change_light(color_name = "#B898E8", brightness = 0.88, duration = 0.18) # ILLUSION SETTLES
  change_light(color_name = "#9080D0", brightness = 0.55, duration = 0.18) # settle
  change_light(color_name = "#A8B8D8", brightness = 0.32, duration = 0.40) # illusion holds
  change_light(color_name = "#888098", brightness = 0.12, duration = 1.20) # slow fade

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  HASTE
#  Voice command (French): "Véloce"
# ------------------------------------------------------------------------------

#' Haste spell effect
#'
#' A surge of warm gold accelerates the target — pale cream brightens through
#' vibrant gold, peaks in a bright burst, sustains through the speed-pulse
#' cluster, and breathes down to a long aura.  Timed to haste.wav (peak
#' ~1.36s, pulse cluster through 1.12s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
haste <- function() {
  play_sound(.get_sound_path("haste.wav"))

  change_light(color_name = "#FFE8A0", brightness = 0.30, duration = 0.40) # spark
  change_light(color_name = "#FFDA80", brightness = 0.52, duration = 0.50) # gold surges
  change_light(color_name = "#FFD040", brightness = 0.72, duration = 0.46) # near-impact
  change_light(color_name = "#FFE680", brightness = 0.94, duration = 0.10) # BURST PEAK
  change_light(color_name = "#FFD040", brightness = 0.78, duration = 0.20) # pulses sustain
  change_light(color_name = "#E8B020", brightness = 0.55, duration = 0.30) # settling
  change_light(color_name = "#C89010", brightness = 0.32, duration = 0.50) # aura holds
  change_light(color_name = "#8E6010", brightness = 0.15, duration = 1.00) # slow fade

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  ACID SPLASH
#  Voice command (French): "Acerbe"
# ------------------------------------------------------------------------------

#' Acid Splash spell effect
#'
#' Muted yellow-green hurled forward, building to caustic brightness, snapping
#' to a vivid splash peak, then spreading and corroding into dark fumes.
#' Timed to acid_splash.wav (peak ~0.92s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
acid_splash <- function() {
  play_sound(.get_sound_path("acid_splash.wav"))

  change_light(color_name = "#88AA20", brightness = 0.30, duration = 0.30) # orb hurled
  change_light(color_name = "#AABB30", brightness = 0.55, duration = 0.30) # building
  change_light(color_name = "#BBDD30", brightness = 0.75, duration = 0.32) # near-impact
  change_light(color_name = "#CCFF33", brightness = 0.92, duration = 0.08) # SPLASH
  change_light(color_name = "#99EE00", brightness = 0.65, duration = 0.18) # spread
  change_light(color_name = "#557700", brightness = 0.32, duration = 0.22) # corrosive
  change_light(color_name = "#334400", brightness = 0.10, duration = 0.50) # fumes

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  HEAT METAL
#  Voice command (French): "Brasier"
# ------------------------------------------------------------------------------

#' Heat Metal spell effect
#'
#' Cold metallic grey-blue warms through dull copper to red-orange, peaks
#' white-hot, holds searing, surges again with the sound's second wave, then
#' cools to a long red glow.  Timed to heat_metal.wav (peak ~1.20s, secondary
#' surge at 2.02-2.12s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
heat_metal <- function() {
  play_sound(.get_sound_path("heat_metal.wav"))

  change_light(color_name = "#6080A0", brightness = 0.18, duration = 0.45) # cold steel
  change_light(color_name = "#A88060", brightness = 0.32, duration = 0.40) # copper warming
  change_light(color_name = "#D06820", brightness = 0.50, duration = 0.35) # red-orange
  change_light(color_name = "#FFAA00", brightness = 0.88, duration = 0.10) # WHITE-HOT
  change_light(color_name = "#FF8500", brightness = 0.72, duration = 0.22) # searing
  change_light(color_name = "#FF5500", brightness = 0.55, duration = 0.50) # sustained
  change_light(color_name = "#FF6800", brightness = 0.78, duration = 0.30) # second surge
  change_light(color_name = "#CC3300", brightness = 0.50, duration = 0.30) # cooling
  change_light(color_name = "#881800", brightness = 0.20, duration = 1.00) # red holds

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  FAERIE FIRE
#  Voice command (French): "Féerie"
# ------------------------------------------------------------------------------

#' Faerie Fire spell effect
#'
#' Vivid violet sparks ignite, spread to outline targets in brilliant purple,
#' peak in a bright outline flash, and persist in a slow vibrant glow.  Timed
#' to faerie_fire.wav (peak ~1.00s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
faerie_fire <- function() {
  play_sound(.get_sound_path("faerie_fire.wav"))

  change_light(color_name = "#B048DC", brightness = 0.42, duration = 0.40) # sparks ignite
  change_light(color_name = "#C040FF", brightness = 0.65, duration = 0.34) # spreading
  change_light(color_name = "#D870FF", brightness = 0.85, duration = 0.26) # near-impact
  change_light(color_name = "#E888FF", brightness = 0.95, duration = 0.10) # OUTLINES FLASH
  change_light(color_name = "#C040FF", brightness = 0.82, duration = 0.20) # outlines hold
  change_light(color_name = "#A828EE", brightness = 0.65, duration = 0.30) # vibrant glow
  change_light(color_name = "#8020D0", brightness = 0.45, duration = 0.60) # persists
  change_light(color_name = "#5818A0", brightness = 0.20, duration = 1.00) # slow fade

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  RAY OF FROST
#  Voice command (French): "Verglas"
# ------------------------------------------------------------------------------

#' Ray of Frost spell effect
#'
#' A long pale focus builds, the ray fires bright blue at peak, holds through
#' a secondary frost pulse, and frost spreads down through deeper blues.
#' Timed to ray_of_frost.wav (peak ~1.32s, secondary at 1.38s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
ray_of_frost <- function() {
  play_sound(.get_sound_path("ray_of_frost.wav"))

  change_light(color_name = "#D8E8F8", brightness = 0.22, duration = 0.50) # cold focus
  change_light(color_name = "#B0D8F0", brightness = 0.42, duration = 0.50) # ray builds
  change_light(color_name = "#88C8E8", brightness = 0.65, duration = 0.32) # near-impact
  change_light(color_name = "#80CCFF", brightness = 0.92, duration = 0.08) # RAY FIRES
  change_light(color_name = "#A0D0F0", brightness = 0.55, duration = 0.18) # frost pulse
  change_light(color_name = "#60A8E8", brightness = 0.30, duration = 0.30) # frost spread
  change_light(color_name = "#3080C0", brightness = 0.12, duration = 0.50) # frozen residue

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  WALL OF FIRE
#  Voice command (French): "Fournaise"
# ------------------------------------------------------------------------------

#' Wall of Fire spell effect
#'
#' Embers stir, the wall ignites and rises through warm orange to a towering
#' near-white peak, then roars at sustained intensity before slowly dying down.
#' Timed to wall_of_fire.wav (peak ~2.76s, long sustained burn).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
wall_of_fire <- function() {
  play_sound(.get_sound_path("wall_of_fire.wav"))

  change_light(color_name = "#5A1800", brightness = 0.18, duration = 0.50) # embers stir
  change_light(color_name = "#B04000", brightness = 0.40, duration = 0.60) # ignition
  change_light(color_name = "#E07020", brightness = 0.62, duration = 0.60) # wall rising
  change_light(color_name = "#FF8500", brightness = 0.78, duration = 0.60) # heat building
  change_light(color_name = "#FF7000", brightness = 0.88, duration = 0.46) # near-impact
  change_light(color_name = "#FFAA00", brightness = 0.96, duration = 0.10) # TOWERING PEAK
  change_light(color_name = "#FF7000", brightness = 0.85, duration = 0.50) # roaring
  change_light(color_name = "#FF5500", brightness = 0.70, duration = 0.80) # sustained
  change_light(color_name = "#E04000", brightness = 0.48, duration = 1.40) # blaze
  change_light(color_name = "#A02000", brightness = 0.22, duration = 1.30) # dying down

  revert_state(duration = 5)
}


# ------------------------------------------------------------------------------
#  FINGER OF DEATH
#  Voice command (French): "Trépas"
# ------------------------------------------------------------------------------

#' Finger of Death spell effect
#'
#' Necrotic green stirs, charges through sickly bright green, and the impact
#' frame whitens to a brilliant near-white green; life drains back through
#' deepening green into void.  Timed to finger_of_death.wav (peak ~0.76s,
#' long decay to 2.58s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
finger_of_death <- function() {
  play_sound(.get_sound_path("finger_of_death.wav"))

  change_light(color_name = "#003A14", brightness = 0.18, duration = 0.20) # death stirs
  change_light(color_name = "#006028", brightness = 0.38, duration = 0.30) # necrotic rises
  change_light(color_name = "#00903C", brightness = 0.62, duration = 0.26) # beam charges
  change_light(color_name = "#C8FFD8", brightness = 0.95, duration = 0.10) # IMPACT (whiter green)
  change_light(color_name = "#00B040", brightness = 0.62, duration = 0.20) # tail
  change_light(color_name = "#006028", brightness = 0.40, duration = 0.30) # sub-peak
  change_light(color_name = "#003020", brightness = 0.22, duration = 0.40) # life draining
  change_light(color_name = "#001810", brightness = 0.10, duration = 0.50) # settling
  change_light(color_name = "#000800", brightness = 0.04, duration = 0.60) # void

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  DISINTEGRATE
#  Voice command (French): "Néant"
# ------------------------------------------------------------------------------

#' Disintegrate spell effect
#'
#' Muted orange gathers, charges through hotter orange, peaks in a searing
#' near-white flare, sustains through the disintegration cluster, then matter
#' crumbles down through ash-grey into smoke.  Timed to disintegrate.wav
#' (peak ~2.52s, sustained cluster through 2.60s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
disintegrate <- function() {
  play_sound(.get_sound_path("disintegrate.wav"))

  change_light(color_name = "#803000", brightness = 0.22, duration = 0.60) # gathering
  change_light(color_name = "#C04800", brightness = 0.45, duration = 0.65) # charging
  change_light(color_name = "#F06400", brightness = 0.65, duration = 0.65) # orange surges
  change_light(color_name = "#FF7800", brightness = 0.82, duration = 0.62) # near-impact
  change_light(color_name = "#FFAA40", brightness = 0.98, duration = 0.10) # DISINTEGRATION
  change_light(color_name = "#FF8C00", brightness = 0.82, duration = 0.20) # cluster sustain
  change_light(color_name = "#C86820", brightness = 0.60, duration = 0.22) # matter crumbling
  change_light(color_name = "#7A6050", brightness = 0.38, duration = 0.30) # ash forming
  change_light(color_name = "#4A4845", brightness = 0.18, duration = 0.40) # smoke grey
  change_light(color_name = "#2A2825", brightness = 0.06, duration = 0.80) # nothing left

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  BLIGHT
#  Voice command (French): "Flétrissure"
# ------------------------------------------------------------------------------

#' Blight spell effect
#'
#' Necrotic tendrils strike almost immediately in olive-yellow, then warm life
#' drains through deepening brown into withered darkness across a long slow
#' decay.  Timed to blight.wav (peak ~0.10s, long decay through 2.34s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
blight <- function() {
  play_sound(.get_sound_path("blight.wav"))

  change_light(color_name = "#604010", brightness = 0.32, duration = 0.06) # tendrils reach
  change_light(color_name = "#A88018", brightness = 0.58, duration = 0.08) # NECROTIC PEAK
  change_light(color_name = "#8B6914", brightness = 0.45, duration = 0.30) # yellowing
  change_light(color_name = "#6B4C00", brightness = 0.40, duration = 0.30) # browning
  change_light(color_name = "#4A3000", brightness = 0.30, duration = 0.50) # withering
  change_light(color_name = "#2A1800", brightness = 0.18, duration = 0.80) # collapse
  change_light(color_name = "#1A0F00", brightness = 0.08, duration = 1.40) # husks

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  MASS HEALING WORD
#  Voice command (French): "Cantique"
# ------------------------------------------------------------------------------

#' Mass Healing Word spell effect
#'
#' A stronger, longer cure_wounds — pale gold word spoken, three golden waves
#' build through warm tones, peak in a bright golden burst, and breathe out
#' through a long pale residue.  Timed to mass_healing_word.wav (peak ~1.34s,
#' long decay through 5.74s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
mass_healing_word <- function() {
  play_sound(.get_sound_path("mass_healing_word.wav"))

  change_light(color_name = "#FFF1C8", brightness = 0.22, duration = 0.40) # word spoken
  change_light(color_name = "#FFE9A8", brightness = 0.42, duration = 0.30) # first wave
  change_light(color_name = "#FFD46A", brightness = 0.62, duration = 0.34) # second wave
  change_light(color_name = "#FFC640", brightness = 0.78, duration = 0.30) # near-impact
  change_light(color_name = "#FFE680", brightness = 0.95, duration = 0.10) # THIRD WAVE PEAK
  change_light(color_name = "#FFD46A", brightness = 0.78, duration = 0.30) # warmth spread
  change_light(color_name = "#FFE9A8", brightness = 0.55, duration = 0.60) # settle
  change_light(color_name = "#FFF1C8", brightness = 0.35, duration = 1.00) # glow
  change_light(color_name = "#FFE8A8", brightness = 0.15, duration = 2.50) # long residue

  revert_state(duration = 4)
}
