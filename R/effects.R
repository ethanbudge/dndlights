# ==============================================================================
# dndlights — Non-Spell Sound Effects
# ==============================================================================
# Environmental, creature, and PC combat effects that don't map to a spell.
# All follow the same WAV-timed pattern as spells: buildup colours sit in the
# impact's hue family (muted), then a sudden bright frame fires on the audio
# peak, then a smooth decay tracks the audio envelope back down.
#
# PC Combat effects (arcane_shot, wild_shape, bludgeon, slash, pierce) carry
# French voice triggers like the spells; the rest are intended for direct
# hotkey binding.
# ==============================================================================


# ==============================================================================
#  PC COMBAT
# ==============================================================================


# ------------------------------------------------------------------------------
#  ARCANE SHOT
#  Voice command (French): "Décharge"
#  An arcane rifle firing
# ------------------------------------------------------------------------------

#' Arcane Shot effect
#'
#' Muted red gathers, charges through brighter red, the muzzle flashes in a
#' near-white burst, and the slug trails through deep red into smoke.  Timed
#' to arcane_shot.wav (peak ~1.28s, trail through 1.48s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
arcane_shot <- function() {
  play_sound(.get_sound_path("arcane_shot.wav"))

  change_light(color_name = "#5C0808", brightness = 0.22, duration = 0.40) # anticipation
  change_light(color_name = "#903030", brightness = 0.45, duration = 0.50) # charging
  change_light(color_name = "#C04040", brightness = 0.68, duration = 0.38) # near-impact
  change_light(color_name = "#FFE0E0", brightness = 0.98, duration = 0.06) # MUZZLE FLASH
  change_light(color_name = "#FF2020", brightness = 0.82, duration = 0.12) # slug trail
  change_light(color_name = "#C81818", brightness = 0.60, duration = 0.12) # impact
  change_light(color_name = "#800808", brightness = 0.32, duration = 0.30) # deep red
  change_light(color_name = "#400404", brightness = 0.10, duration = 0.50) # smoke fades

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  WILD SHAPE
#  Voice command (French): "Sauvagine"
#  Druidic Wildshape — transformation into a beast
# ------------------------------------------------------------------------------

#' Wild Shape effect
#'
#' Forest green stirs, surges through brighter green toward transformation,
#' peaks in a vivid bright-green flash as the beast emerges, and settles back
#' into primal darkness.  Timed to wild_shape.wav (peak ~1.78s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
wild_shape <- function() {
  play_sound(.get_sound_path("wild_shape.wav"))

  change_light(color_name = "#2A4A20", brightness = 0.22, duration = 0.45) # forest stirs
  change_light(color_name = "#387028", brightness = 0.42, duration = 0.40) # gathering
  change_light(color_name = "#44A038", brightness = 0.62, duration = 0.40) # surging
  change_light(color_name = "#66CC44", brightness = 0.78, duration = 0.53) # near-impact
  change_light(color_name = "#98FF50", brightness = 0.95, duration = 0.18) # TRANSFORMATION
  change_light(color_name = "#55CC44", brightness = 0.65, duration = 0.18) # new form
  change_light(color_name = "#226622", brightness = 0.35, duration = 0.40) # beast complete
  change_light(color_name = "#112211", brightness = 0.10, duration = 1.20) # primal settle

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  BLUDGEON
#  Voice command (French): "Boutez"
# ------------------------------------------------------------------------------

#' Bludgeon effect
#'
#' Grey anticipation rises through white-grey to a near-white pre-impact, the
#' weapon connects in a bright red flash, then a clean white-grey fadeout
#' returns to silence.  Timed to bludgeon.wav (peak ~1.08s, secondary at 1.24s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
bludgeon <- function() {
  play_sound(.get_sound_path("bludgeon.wav"))

  change_light(color_name = "#6A6A6A", brightness = 0.25, duration = 0.40) # grey anticipation
  change_light(color_name = "#A8A8A8", brightness = 0.50, duration = 0.30) # white-grey rise
  change_light(color_name = "#C0C0C0", brightness = 0.72, duration = 0.38) # near-impact
  change_light(color_name = "#FF0033", brightness = 0.95, duration = 0.08) # RED IMPACT
  change_light(color_name = "#CCCCCC", brightness = 0.60, duration = 0.16) # white fadeout
  change_light(color_name = "#888888", brightness = 0.35, duration = 0.20) # grey settling
  change_light(color_name = "#404040", brightness = 0.12, duration = 0.40) # back to grey

  revert_state(duration = 1)
}


# ------------------------------------------------------------------------------
#  SLASH
#  Voice command (French): "Taillade"
# ------------------------------------------------------------------------------

#' Slash effect
#'
#' Near-instant: a brief grey ready-frame, a brilliant white blade flash, a
#' bright red slash, then a fast white-to-grey fade.  Timed to slash.wav
#' (peak ~0.06s, very short).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
slash <- function() {
  play_sound(.get_sound_path("slash.wav"))

  change_light(color_name = "#888888", brightness = 0.40, duration = 0.02) # grey ready
  change_light(color_name = "#FFFFFF", brightness = 0.95, duration = 0.04) # STEEL FLASH
  change_light(color_name = "#FF0033", brightness = 0.98, duration = 0.04) # RED SLASH
  change_light(color_name = "#EEEEEE", brightness = 0.65, duration = 0.05) # white fadeout
  change_light(color_name = "#888888", brightness = 0.30, duration = 0.10) # grey settle
  change_light(color_name = "#383838", brightness = 0.10, duration = 0.30) # quiet grey

  revert_state(duration = 1)
}


# ------------------------------------------------------------------------------
#  PIERCE
#  Voice command (French): "Estoc"
# ------------------------------------------------------------------------------

#' Pierce effect
#'
#' Grey anticipation rises slowly through white-grey to a near-white point,
#' then a brilliant white point-flash followed by a bright red thrust, and a
#' tight white-to-grey fadeout.  Timed to pierce.wav (peak ~1.14s, fast decay).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
pierce <- function() {
  play_sound(.get_sound_path("pierce.wav"))

  change_light(color_name = "#6A6A6A", brightness = 0.25, duration = 0.40) # grey anticipation
  change_light(color_name = "#888888", brightness = 0.45, duration = 0.40) # rising
  change_light(color_name = "#BBBBBB", brightness = 0.65, duration = 0.30) # point gathering
  change_light(color_name = "#FFFFFF", brightness = 0.92, duration = 0.04) # POINT FLASH
  change_light(color_name = "#FF0033", brightness = 0.98, duration = 0.06) # RED THRUST
  change_light(color_name = "#DDDDDD", brightness = 0.55, duration = 0.05) # white fadeout
  change_light(color_name = "#777777", brightness = 0.25, duration = 0.10) # grey settle
  change_light(color_name = "#383838", brightness = 0.08, duration = 0.30) # quiet grey

  revert_state(duration = 1)
}


# ==============================================================================
#  CREATURES
# ==============================================================================


# ------------------------------------------------------------------------------
#  SPIDER BITE
#  A spider bite and cry
# ------------------------------------------------------------------------------

#' Spider Bite effect
#'
#' Dark forest green shadow strikes, gathers through deeper green, snaps to a
#' bright venom-green peak, and creeps down through poison spread into
#' paralysis.  Timed to spider_bite.wav (peak ~0.30s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
spider_bite <- function() {
  play_sound(.get_sound_path("spider_bite.wav"))

  change_light(color_name = "#1A4A0F", brightness = 0.18, duration = 0.10) # shadow strike
  change_light(color_name = "#226A18", brightness = 0.42, duration = 0.20) # gathering
  change_light(color_name = "#44FF00", brightness = 0.85, duration = 0.08) # VENOM PEAK
  change_light(color_name = "#33CC00", brightness = 0.55, duration = 0.14) # poison spreading
  change_light(color_name = "#114400", brightness = 0.22, duration = 0.30) # venom courses
  change_light(color_name = "#081A00", brightness = 0.06, duration = 0.40) # paralysis

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  WORM SURGE
#  A giant worm burrowing up from the ground in a sudden frenzy
# ------------------------------------------------------------------------------

#' Worm Surge effect
#'
#' Brown rumble beneath the ground builds into the eruption — earth bursts up
#' brown, the worm's bulk peaks in a flash of purple, brown returns, the
#' creature writhes, then a late surge before settling.  Timed to
#' worm_surge.wav (peak ~1.70s, late surge at 3.84s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
worm_surge <- function() {
  play_sound(.get_sound_path("worm_surge.wav"))

  change_light(color_name = "#2A1800", brightness = 0.15, duration = 0.40) # rumbling deep
  change_light(color_name = "#5C3D20", brightness = 0.32, duration = 0.45) # cracking
  change_light(color_name = "#7A4A28", brightness = 0.55, duration = 0.45) # earth bursting
  change_light(color_name = "#8B5828", brightness = 0.68, duration = 0.40) # near-impact
  change_light(color_name = "#6A3878", brightness = 0.82, duration = 0.10) # PURPLE ERUPTION
  change_light(color_name = "#7A4A28", brightness = 0.62, duration = 0.20) # back to brown
  change_light(color_name = "#5C3018", brightness = 0.42, duration = 0.30) # writhing
  change_light(color_name = "#3A2010", brightness = 0.20, duration = 1.54) # looming
  change_light(color_name = "#5A3020", brightness = 0.45, duration = 0.30) # late surge
  change_light(color_name = "#3A2010", brightness = 0.20, duration = 0.40) # settling
  change_light(color_name = "#1F1008", brightness = 0.06, duration = 0.50) # final fade

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  CRYSTAL BREATH
#  The crystal breath weapon of a dragon
# ------------------------------------------------------------------------------

#' Crystal Breath effect
#'
#' Pale crystals form, charge through cyan, the barrage fires in a near-white
#' burst, sustains through two shard pulses, and splinters settle through
#' cooler blues into stillness.  Timed to crystal_breath.wav (peak ~0.40s,
#' sustained shard cluster through 0.58s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
crystal_breath <- function() {
  play_sound(.get_sound_path("crystal_breath.wav"))

  change_light(color_name = "#B0DEEF", brightness = 0.30, duration = 0.10) # crystals form
  change_light(color_name = "#88CCEE", brightness = 0.55, duration = 0.10) # charging
  change_light(color_name = "#66DDFF", brightness = 0.78, duration = 0.20) # near-impact
  change_light(color_name = "#EEFFFF", brightness = 0.98, duration = 0.10) # BARRAGE PEAK
  change_light(color_name = "#88CCFF", brightness = 0.78, duration = 0.12) # shard pulse 1
  change_light(color_name = "#66B8E8", brightness = 0.58, duration = 0.18) # shard pulse 2
  change_light(color_name = "#4499CC", brightness = 0.38, duration = 0.30) # impact shatter
  change_light(color_name = "#2266AA", brightness = 0.18, duration = 0.40) # splinters
  change_light(color_name = "#224466", brightness = 0.06, duration = 0.80) # settle

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  DRAGON BITE
#  The bite of a dragon
# ------------------------------------------------------------------------------

#' Dragon Bite effect
#'
#' Jaws descend almost instantly: shadow contact, savage red impact at peak,
#' tearing wrench, then deepening blood-red wound settling into pain.  Timed
#' to dragon_bite.wav (peak ~0.06s, very fast).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
dragon_bite <- function() {
  play_sound(.get_sound_path("dragon_bite.wav"))

  change_light(color_name = "#2A0808", brightness = 0.18, duration = 0.02) # jaws descend
  change_light(color_name = "#CC3300", brightness = 0.88, duration = 0.06) # RED BITE
  change_light(color_name = "#880000", brightness = 0.55, duration = 0.10) # tear
  change_light(color_name = "#550000", brightness = 0.25, duration = 0.20) # wound
  change_light(color_name = "#330000", brightness = 0.12, duration = 0.30) # blood deepens
  change_light(color_name = "#1A0000", brightness = 0.06, duration = 0.60) # pain settles

  revert_state(duration = 2)
}


# ==============================================================================
#  MAGICAL & ENVIRONMENTAL
# ==============================================================================


# ------------------------------------------------------------------------------
#  HAMMER SLAM
#  A magical electric-blue hammer slamming its target
# ------------------------------------------------------------------------------

#' Hammer Slam effect
#'
#' Muted electric blue charges as the hammer swings, builds through brighter
#' blue, slams in a near-white flash at peak, and the shockwave fades through
#' three diminishing electric pulses into grounded silence.  Timed to
#' hammer_slam.wav (peak ~1.26s, pulse cluster through 1.62s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
hammer_slam <- function() {
  play_sound(.get_sound_path("hammer_slam.wav"))

  change_light(color_name = "#2A488A", brightness = 0.22, duration = 0.40) # anticipation
  change_light(color_name = "#4488FF", brightness = 0.50, duration = 0.40) # charge builds
  change_light(color_name = "#88BBFF", brightness = 0.72, duration = 0.46) # near-impact
  change_light(color_name = "#DDEEFF", brightness = 0.98, duration = 0.08) # SLAM
  change_light(color_name = "#AACCFF", brightness = 0.78, duration = 0.16) # pulse 1
  change_light(color_name = "#2266FF", brightness = 0.60, duration = 0.20) # pulse 2
  change_light(color_name = "#1144CC", brightness = 0.38, duration = 0.30) # crackling
  change_light(color_name = "#001888", brightness = 0.18, duration = 0.50) # grounding
  change_light(color_name = "#000A40", brightness = 0.06, duration = 0.40) # silence

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  IGNITE
#  A burst of flame as something small combusts
# ------------------------------------------------------------------------------

#' Ignite effect
#'
#' Near-instant: a combustion spark snaps into a bright hot-orange burst,
#' blooms briefly, and smoulders down to a quick ember.  Timed to ignite.wav
#' (peak ~0.04s, fast).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
ignite <- function() {
  play_sound(.get_sound_path("ignite.wav"))

  change_light(color_name = "#FF6600", brightness = 0.50, duration = 0.04) # combustion spark
  change_light(color_name = "#FFAA00", brightness = 0.92, duration = 0.06) # BURST PEAK
  change_light(color_name = "#FF7700", brightness = 0.55, duration = 0.12) # flame blooms
  change_light(color_name = "#CC2200", brightness = 0.22, duration = 0.30) # smoulder
  change_light(color_name = "#5A1000", brightness = 0.06, duration = 0.50) # ember fade

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  GUST
#  A rush of wind
# ------------------------------------------------------------------------------

#' Gust effect
#'
#' A very long pale wind buildup gathers through cooler whites toward a bright
#' rush at peak, then streams away through cooler blues.  Timed to gust.wav
#' (peak ~4.80s — extended buildup).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
gust <- function() {
  play_sound(.get_sound_path("gust.wav"))

  change_light(color_name = "#C0D8F0", brightness = 0.25, duration = 1.20) # wind stirring
  change_light(color_name = "#D8E8F8", brightness = 0.45, duration = 1.20) # gathering
  change_light(color_name = "#EEF4FF", brightness = 0.62, duration = 1.20) # building
  change_light(color_name = "#F8FCFF", brightness = 0.80, duration = 1.20) # near-peak
  change_light(color_name = "#FFFFFF", brightness = 0.92, duration = 0.10) # RUSH PEAK
  change_light(color_name = "#DDEEFF", brightness = 0.65, duration = 0.30) # streaming
  change_light(color_name = "#BBDDFF", brightness = 0.38, duration = 0.40) # dispersing
  change_light(color_name = "#88AADD", brightness = 0.15, duration = 0.80) # last breath

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  SPORE BURST
#  A release of bright spores
# ------------------------------------------------------------------------------

#' Spore Burst effect
#'
#' Dark green sac under pressure shifts through muted purple-green toward
#' rupture, bursts in a bright light-purple cloud at peak, sustains through
#' the spore drift, then settles back through purple-green into deep green
#' stillness.  Timed to spore_burst.wav (peak ~1.00s, sustained through 0.86s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
spore_burst <- function() {
  play_sound(.get_sound_path("spore_burst.wav"))

  change_light(color_name = "#224028", brightness = 0.22, duration = 0.30) # dark green sac
  change_light(color_name = "#5C4040", brightness = 0.42, duration = 0.32) # transitioning
  change_light(color_name = "#8870A8", brightness = 0.65, duration = 0.38) # near-impact purple
  change_light(color_name = "#D8A8FF", brightness = 0.92, duration = 0.10) # PURPLE BURST
  change_light(color_name = "#A878D0", brightness = 0.65, duration = 0.20) # cloud sustains
  change_light(color_name = "#786088", brightness = 0.42, duration = 0.40) # purple-green blend
  change_light(color_name = "#4A5030", brightness = 0.25, duration = 0.50) # back toward green
  change_light(color_name = "#1F3015", brightness = 0.08, duration = 0.80) # deep green

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  FLASK SHATTER
#  An alchemical flask shattering
# ------------------------------------------------------------------------------

#' Flask Shatter effect
#'
#' Near-instant: glass shatters in olive-green, the alchemical reaction flares
#' to a bright yellow-green peak, spray spreads, and fumes settle through
#' olive into dark haze.  Timed to flask_shatter.wav (peak ~0.10s, fast).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
flask_shatter <- function() {
  play_sound(.get_sound_path("flask_shatter.wav"))

  change_light(color_name = "#88AA20", brightness = 0.45, duration = 0.04) # glass shatters
  change_light(color_name = "#CCFF66", brightness = 0.92, duration = 0.06) # REACTION PEAK
  change_light(color_name = "#AAEE33", brightness = 0.70, duration = 0.10) # spray
  change_light(color_name = "#88DD00", brightness = 0.45, duration = 0.15) # spreading
  change_light(color_name = "#446600", brightness = 0.22, duration = 0.25) # fumes
  change_light(color_name = "#223300", brightness = 0.06, duration = 0.50) # haze

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  STEAM BLAST
#  A blast of steam
# ------------------------------------------------------------------------------

#' Steam Blast effect
#'
#' Pressurised vent builds in pale grey, bursts to brilliant white at peak,
#' sustains through a second pulse, then billows out through cooler whites
#' into drifting wisps.  Timed to steam_blast.wav (peak ~0.24s, sustained
#' through 0.32s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
steam_blast <- function() {
  play_sound(.get_sound_path("steam_blast.wav"))

  change_light(color_name = "#C8C8C8", brightness = 0.40, duration = 0.08) # vent builds
  change_light(color_name = "#E8E8E8", brightness = 0.72, duration = 0.16) # pressure
  change_light(color_name = "#FFFFFF", brightness = 0.95, duration = 0.08) # WHITE BURST
  change_light(color_name = "#F8F8F8", brightness = 0.85, duration = 0.10) # second pulse
  change_light(color_name = "#F0F0F0", brightness = 0.62, duration = 0.20) # billowing
  change_light(color_name = "#DDDDDD", brightness = 0.40, duration = 0.30) # rolling
  change_light(color_name = "#C8C8C8", brightness = 0.22, duration = 0.50) # thinning
  change_light(color_name = "#A0A0A0", brightness = 0.08, duration = 0.90) # last wisps

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  ARCANE SURGE
#  A massive release of metallic arcane energy
# ------------------------------------------------------------------------------

#' Arcane Surge effect
#'
#' A very long buildup: muted metallic anticipation, silver expanding, gold
#' surging, near-impact warmth, then a blinding white burst at peak; the
#' shockwave dissipates through metallic haze into deep silence.  Timed to
#' arcane_surge.wav (peak ~4.26s — extended buildup).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
arcane_surge <- function() {
  play_sound(.get_sound_path("arcane_surge.wav"))

  change_light(color_name = "#4A4A50", brightness = 0.18, duration = 0.80) # anticipation
  change_light(color_name = "#8A8A8A", brightness = 0.35, duration = 1.00) # silver beginning
  change_light(color_name = "#C0C0C0", brightness = 0.55, duration = 1.00) # silver building
  change_light(color_name = "#E8D080", brightness = 0.70, duration = 0.90) # gold rising
  change_light(color_name = "#F8E090", brightness = 0.85, duration = 0.56) # near-impact
  change_light(color_name = "#FFFFFF", brightness = 0.98, duration = 0.10) # BLINDING BURST
  change_light(color_name = "#E8D080", brightness = 0.75, duration = 0.20) # shockwave
  change_light(color_name = "#A09050", brightness = 0.50, duration = 0.30) # metallic haze
  change_light(color_name = "#705030", brightness = 0.22, duration = 0.50) # dissipating
  change_light(color_name = "#3A2810", brightness = 0.08, duration = 1.20) # fade out

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  SAND BLAST
#  A blast of sand
# ------------------------------------------------------------------------------

#' Sand Blast effect
#'
#' Amber sand swirls up, builds through brighter sand toward the blast peak,
#' fires in a stinging gold burst, and the cloud settles through warm sand
#' tones into drifting dust.  Timed to sand_blast.wav (peak ~0.42s, sub-peak
#' at 0.48s).
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
sand_blast <- function() {
  play_sound(.get_sound_path("sand_blast.wav"))

  change_light(color_name = "#886020", brightness = 0.30, duration = 0.20) # sand swirls
  change_light(color_name = "#C08840", brightness = 0.52, duration = 0.14) # building
  change_light(color_name = "#E8B860", brightness = 0.78, duration = 0.08) # near-impact
  change_light(color_name = "#FFD080", brightness = 0.92, duration = 0.08) # BLAST PEAK
  change_light(color_name = "#D4A055", brightness = 0.68, duration = 0.14) # sub-peak
  change_light(color_name = "#C89040", brightness = 0.50, duration = 0.16) # spreading
  change_light(color_name = "#A07030", brightness = 0.32, duration = 0.30) # cloud settles
  change_light(color_name = "#704A1A", brightness = 0.10, duration = 0.50) # dust haze

  revert_state(duration = 2)
}
