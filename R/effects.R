# ==============================================================================
# dndlights — Non-Spell Sound Effects
# ==============================================================================
# Environmental and creature effects that don't map to a specific spell.
# All follow the same light-sequence pattern as spells and revert to the
# current ambient scene state when finished.
# ==============================================================================


# ------------------------------------------------------------------------------
#  HAMMER SLAM
#  A magical electric-blue hammer slamming its target
# ------------------------------------------------------------------------------

#' Hammer Slam effect
#'
#' An arc of electric-blue energy charges as a magical hammer swings, then
#' detonates on impact in a blinding flash and crackling shockwave.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
hammer_slam <- function() {
  play_sound(.get_sound_path("hammer_slam.wav"))

  change_light(color_name = "#4488FF", brightness = 0.42, duration = 0.08) # hammer charged, arc building
  change_light(color_name = "#AACCFF", brightness = 0.98, duration = 0.04) # SLAM — electric flash
  change_light(color_name = "#2266FF", brightness = 0.68, duration = 0.07) # shockwave pulses out
  change_light(color_name = "#1144CC", brightness = 0.32, duration = 0.22) # crackling aftermath
  change_light(color_name = "#001888", brightness = 0.09, duration = 0.75) # energy grounding

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  ARCANE SHOT
#  An arcane rifle firing
# ------------------------------------------------------------------------------

#' Arcane Shot effect
#'
#' A blinding muzzle flash, then a purple arcane slug trails through the air
#' before dissipating in drifting arcane smoke.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
arcane_shot <- function() {
  play_sound(.get_sound_path("arcane_shot.wav"))

  change_light(color_name = "#FFFFFF", brightness = 0.92, duration = 0.02) # muzzle flash
  change_light(color_name = "#9900FF", brightness = 0.58, duration = 0.05) # arcane slug trails
  change_light(color_name = "#6600CC", brightness = 0.30, duration = 0.14) # impact glow
  change_light(color_name = "#440088", brightness = 0.10, duration = 0.55) # arcane smoke

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  IGNITE
#  A burst of flame as something small combusts
# ------------------------------------------------------------------------------

#' Ignite effect
#'
#' A sharp combustion spark blooms into a brief hot-orange flash and settles
#' to a quick smolder.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
ignite <- function() {
  play_sound(.get_sound_path("ignite.wav"))

  change_light(color_name = "#FF6600", brightness = 0.55, duration = 0.04) # combustion spark
  change_light(color_name = "#FFAA00", brightness = 0.88, duration = 0.05) # burst peak
  change_light(color_name = "#FF4400", brightness = 0.45, duration = 0.09) # flame blooms
  change_light(color_name = "#CC2200", brightness = 0.14, duration = 0.38) # quick smolder

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  GUST
#  A rush of wind
# ------------------------------------------------------------------------------

#' Gust effect
#'
#' Light scatters as a powerful rush of wind tears through — a brief pale
#' white flicker that disperses quickly.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
gust <- function() {
  play_sound(.get_sound_path("gust.wav"))

  change_light(color_name = "#E8F4FF", brightness = 0.22, duration = 0.08) # wind gathering
  change_light(color_name = "#FFFFFF", brightness = 0.58, duration = 0.07) # rush hits — light scatters
  change_light(color_name = "#CCE8FF", brightness = 0.35, duration = 0.14) # wind streaming
  change_light(color_name = "#AADDFF", brightness = 0.14, duration = 0.38) # dispersing

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  WILD SHAPE
#  Druidic Wildshape — transformation into a beast
# ------------------------------------------------------------------------------

#' Wild Shape effect
#'
#' Nature energy gathers in a vivid green surge as the druid's form shifts
#' and reshapes, then settles into primal darkness.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
wild_shape <- function() {
  play_sound(.get_sound_path("wild_shape.wav"))

  change_light(color_name = "#228B22", brightness = 0.22, duration = 0.22) # nature energy gathering
  change_light(color_name = "#55CC44", brightness = 0.52, duration = 0.28) # transformation begins
  change_light(color_name = "#88FF44", brightness = 0.82, duration = 0.22) # peak — form shifting
  change_light(color_name = "#44BB22", brightness = 0.48, duration = 0.28) # new form emerging
  change_light(color_name = "#226622", brightness = 0.22, duration = 0.55) # beast form complete
  change_light(color_name = "#112211", brightness = 0.08, duration = 1.20) # primal energy settles

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  SPIDER BITE
#  A spider bite and cry
# ------------------------------------------------------------------------------

#' Spider Bite effect
#'
#' The spider strikes from the dark: a sharp green flash as venom is injected,
#' then creeping poison spreading into slow paralysis.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
spider_bite <- function() {
  play_sound(.get_sound_path("spider_bite.wav"))

  change_light(color_name = "#0A1500", brightness = 0.03, duration = 0.08) # spider strikes from shadow
  change_light(color_name = "#44FF00", brightness = 0.58, duration = 0.05) # venom injected — green flash
  change_light(color_name = "#22AA00", brightness = 0.28, duration = 0.12) # poison spreading
  change_light(color_name = "#114400", brightness = 0.09, duration = 0.48) # venom coursing
  change_light(color_name = "#081A00", brightness = 0.03, duration = 0.90) # paralysis creeping

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  WORM SURGE
#  A giant worm burrowing up from the ground in a sudden frenzy
# ------------------------------------------------------------------------------

#' Worm Surge effect
#'
#' The ground rumbles, cracks, and then erupts as a massive worm bursts
#' through in a spray of earth — thrashing and looming overhead.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
worm_surge <- function() {
  play_sound(.get_sound_path("worm_surge.wav"))

  change_light(color_name = "#2A1800", brightness = 0.07, duration = 0.32) # deep rumbling beneath
  change_light(color_name = "#5C3D20", brightness = 0.18, duration = 0.25) # ground cracking
  change_light(color_name = "#CC6633", brightness = 0.58, duration = 0.14) # erupts — earth explosion
  change_light(color_name = "#AA4422", brightness = 0.72, duration = 0.09) # maw bursts open — peak
  change_light(color_name = "#773322", brightness = 0.42, duration = 0.20) # thrashing and writhing
  change_light(color_name = "#442211", brightness = 0.14, duration = 0.75) # creature looms

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  SPORE BURST
#  A release of bright purple spores
# ------------------------------------------------------------------------------

#' Spore Burst effect
#'
#' A spore sac ruptures in a bright flash of purple, sending a vivid cloud
#' billowing outward before drifting and settling.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
spore_burst <- function() {
  play_sound(.get_sound_path("spore_burst.wav"))

  change_light(color_name = "#CC44FF", brightness = 0.52, duration = 0.14) # sac ruptures
  change_light(color_name = "#EE88FF", brightness = 0.82, duration = 0.09) # bright cloud billows
  change_light(color_name = "#BB33EE", brightness = 0.62, duration = 0.18) # spores spreading
  change_light(color_name = "#8800BB", brightness = 0.38, duration = 0.38) # cloud drifting
  change_light(color_name = "#550088", brightness = 0.18, duration = 1.00) # settling

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  FLASK SHATTER
#  An alchemical flask shattering
# ------------------------------------------------------------------------------

#' Flask Shatter effect
#'
#' Glass shatters and a chemical reaction flares in a bright yellow-green
#' burst — fumes rise and the acrid haze lingers.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
flask_shatter <- function() {
  play_sound(.get_sound_path("flask_shatter.wav"))

  change_light(color_name = "#AAFF33", brightness = 0.72, duration = 0.04) # glass shatters — chemical flash
  change_light(color_name = "#CCFF66", brightness = 0.88, duration = 0.04) # reaction peak
  change_light(color_name = "#88DD00", brightness = 0.52, duration = 0.07) # chemical spray
  change_light(color_name = "#446600", brightness = 0.18, duration = 0.28) # fumes rising
  change_light(color_name = "#223300", brightness = 0.05, duration = 0.75) # chemical haze

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  STEAM BLAST
#  A blast of steam
# ------------------------------------------------------------------------------

#' Steam Blast effect
#'
#' A pressurised vent of scalding steam erupts in a blinding white burst,
#' billowing outward and thinning to the last wisps.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
steam_blast <- function() {
  play_sound(.get_sound_path("steam_blast.wav"))

  change_light(color_name = "#FFFFFF", brightness = 0.88, duration = 0.07) # steam vents — white burst
  change_light(color_name = "#F5F5F5", brightness = 0.68, duration = 0.09) # cloud billowing
  change_light(color_name = "#EBEBEB", brightness = 0.48, duration = 0.18) # steam rolling
  change_light(color_name = "#D8D8D8", brightness = 0.24, duration = 0.45) # thinning
  change_light(color_name = "#BBBBBB", brightness = 0.09, duration = 0.90) # last wisps

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  CRYSTAL BREATH
#  The crystal breath weapon of a dragon
# ------------------------------------------------------------------------------

#' Crystal Breath effect
#'
#' Crystals form in the dragon's throat before a blinding barrage of cyan
#' shards fires outward — shattering on impact and leaving splinters settling.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
crystal_breath <- function() {
  play_sound(.get_sound_path("crystal_breath.wav"))

  change_light(color_name = "#AAEEFF", brightness = 0.28, duration = 0.18) # crystals forming in throat
  change_light(color_name = "#66DDFF", brightness = 0.58, duration = 0.14) # breath weapon charging
  change_light(color_name = "#EEFFFF", brightness = 0.98, duration = 0.09) # barrage fires — blinding
  change_light(color_name = "#88CCFF", brightness = 0.62, duration = 0.14) # shards flying
  change_light(color_name = "#4499CC", brightness = 0.35, duration = 0.28) # impact — shattering
  change_light(color_name = "#224466", brightness = 0.11, duration = 1.20) # splinters settling

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  DRAGON BITE
#  The bite of a dragon
# ------------------------------------------------------------------------------

#' Dragon Bite effect
#'
#' The shadow of enormous jaws descends before a savage red impact — tearing,
#' wounding, and leaving nothing but pain.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
dragon_bite <- function() {
  play_sound(.get_sound_path("dragon_bite.wav"))

  change_light(color_name = "#1A0000", brightness = 0.04, duration = 0.09) # shadow of jaws descending
  change_light(color_name = "#CC3300", brightness = 0.72, duration = 0.04) # BITE — blood red impact
  change_light(color_name = "#880000", brightness = 0.40, duration = 0.09) # wrenching tear
  change_light(color_name = "#550000", brightness = 0.18, duration = 0.28) # wound
  change_light(color_name = "#220000", brightness = 0.06, duration = 0.90) # pain settling

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  ARCANE SURGE
#  A massive release of metallic arcane energy
# ------------------------------------------------------------------------------

#' Arcane Surge effect
#'
#' Metallic arcane energy builds through silver and gold before detonating in
#' a blinding silver-white blast — a shockwave of pure arcane force.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
arcane_surge <- function() {
  play_sound(.get_sound_path("arcane_surge.wav"))

  change_light(color_name = "#C0C0C0", brightness = 0.38, duration = 0.22) # metallic energy building
  change_light(color_name = "#FFD700", brightness = 0.62, duration = 0.25) # gold-silver surge
  change_light(color_name = "#F8F8F8", brightness = 0.98, duration = 0.14) # blinding metallic burst
  change_light(color_name = "#E8D080", brightness = 0.72, duration = 0.18) # arcane shockwave
  change_light(color_name = "#A09050", brightness = 0.45, duration = 0.38) # metallic after-haze
  change_light(color_name = "#705030", brightness = 0.14, duration = 1.50) # energy dissipating

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  SAND BLAST
#  A blast of sand
# ------------------------------------------------------------------------------

#' Sand Blast effect
#'
#' Sand swirls up and fires in a stinging amber blast before the cloud settles
#' back into a drifting dust haze.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
sand_blast <- function() {
  play_sound(.get_sound_path("sand_blast.wav"))

  change_light(color_name = "#D4A055", brightness = 0.42, duration = 0.09) # sand swirling up
  change_light(color_name = "#E8B860", brightness = 0.68, duration = 0.07) # blast fires — sandstorm
  change_light(color_name = "#C89040", brightness = 0.52, duration = 0.11) # impact
  change_light(color_name = "#A07030", brightness = 0.28, duration = 0.28) # cloud settling
  change_light(color_name = "#704A1A", brightness = 0.09, duration = 0.75) # dust haze

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  BLUDGEON
#  The impact of bludgeoning damage
# ------------------------------------------------------------------------------

#' Bludgeon effect
#'
#' A dull grey-white impact flash — the blunt thud of bludgeoning force.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
bludgeon <- function() {
  play_sound(.get_sound_path("bludgeon.wav"))

  change_light(color_name = "#CCCCCC", brightness = 0.55, duration = 0.02) # impact flash
  change_light(color_name = "#DDDDDD", brightness = 0.72, duration = 0.02) # white impact
  change_light(color_name = "#666666", brightness = 0.28, duration = 0.05) # grey thud
  change_light(color_name = "#444444", brightness = 0.10, duration = 0.22) # dull pain

  revert_state(duration = 1)
}


# ------------------------------------------------------------------------------
#  SLASH
#  The impact of slashing damage
# ------------------------------------------------------------------------------

#' Slash effect
#'
#' A sharp white steel flash followed immediately by blood-red — the clean,
#' lethal cut of slashing damage.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
slash <- function() {
  play_sound(.get_sound_path("slash.wav"))

  change_light(color_name = "#FFFFFF", brightness = 0.88, duration = 0.02) # steel flash
  change_light(color_name = "#FF4444", brightness = 0.58, duration = 0.03) # blood — red
  change_light(color_name = "#CC2222", brightness = 0.24, duration = 0.09) # wound
  change_light(color_name = "#880000", brightness = 0.07, duration = 0.32) # seeping

  revert_state(duration = 1)
}


# ------------------------------------------------------------------------------
#  PIERCE
#  The impact of piercing damage
# ------------------------------------------------------------------------------

#' Pierce effect
#'
#' A tight white point of impact, then blood red as the wound opens deep —
#' the focused, penetrating strike of piercing damage.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
pierce <- function() {
  play_sound(.get_sound_path("pierce.wav"))

  change_light(color_name = "#FFFFFF", brightness = 0.78, duration = 0.02) # point impact
  change_light(color_name = "#FF2222", brightness = 0.48, duration = 0.02) # blood
  change_light(color_name = "#AA1111", brightness = 0.18, duration = 0.07) # deep wound
  change_light(color_name = "#660000", brightness = 0.05, duration = 0.38) # seeping

  revert_state(duration = 1)
}
