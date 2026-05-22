# ==============================================================================
# dndlights — Non-Spell Sound Effects
# ==============================================================================
# Environmental, creature, and PC combat effects that don't map to a spell.
# All follow the same light-sequence pattern as spells and revert to the
# current ambient scene state when finished. Light transitions are tuned for
# smoothness — no abrupt hue jumps, no harsh brightness cliffs.
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
#' Red anticipation, a sharp white muzzle flash, the red arcane slug trails
#' through the air, and impact glows down through deep red before fading.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
arcane_shot <- function() {
  play_sound(.get_sound_path("arcane_shot.wav"))

  change_light(color_name = "#3A0A0A", brightness = 0.10, duration = 0.10) # anticipation
  change_light(color_name = "#FFE0E0", brightness = 0.95, duration = 0.04) # muzzle flash
  change_light(color_name = "#FF2020", brightness = 0.70, duration = 0.08) # slug trails red
  change_light(color_name = "#C81818", brightness = 0.45, duration = 0.14) # impact glow
  change_light(color_name = "#800808", brightness = 0.18, duration = 0.40) # deep red
  change_light(color_name = "#400404", brightness = 0.06, duration = 0.70) # smoke fades

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  WILD SHAPE
#  Voice command (French): "Sauvagine"
#  Druidic Wildshape — transformation into a beast
# ------------------------------------------------------------------------------

#' Wild Shape effect
#'
#' Nature energy gathers from deep forest green, surges through vivid green at
#' the moment of transformation, and settles back into primal forest darkness.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
wild_shape <- function() {
  play_sound(.get_sound_path("wild_shape.wav"))

  change_light(color_name = "#0A1A08", brightness = 0.08, duration = 0.25) # anticipation
  change_light(color_name = "#228B22", brightness = 0.30, duration = 0.25) # gathering
  change_light(color_name = "#55CC44", brightness = 0.60, duration = 0.28) # transformation
  change_light(color_name = "#88FF44", brightness = 0.85, duration = 0.25) # peak shift
  change_light(color_name = "#55CC44", brightness = 0.55, duration = 0.30) # new form
  change_light(color_name = "#226622", brightness = 0.28, duration = 0.55) # beast complete
  change_light(color_name = "#112211", brightness = 0.10, duration = 1.20) # primal settle

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  BLUDGEON
#  Voice command (French): "Boutez"
# ------------------------------------------------------------------------------

#' Bludgeon effect
#'
#' Heavy impact frame — grey anticipation, white-grey rise, a bright red BLAM
#' at peak, then a clean grey fadeout. No bleed.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
bludgeon <- function() {
  play_sound(.get_sound_path("bludgeon.wav"))

  change_light(color_name = "#3A3A3A", brightness = 0.15, duration = 0.06) # grey anticipation
  change_light(color_name = "#A8A8A8", brightness = 0.50, duration = 0.05) # white-grey rise
  change_light(color_name = "#FF0033", brightness = 0.95, duration = 0.06) # RED IMPACT
  change_light(color_name = "#CCCCCC", brightness = 0.60, duration = 0.06) # white fadeout
  change_light(color_name = "#808080", brightness = 0.30, duration = 0.10) # grey settling
  change_light(color_name = "#404040", brightness = 0.12, duration = 0.25) # back to grey

  revert_state(duration = 1)
}


# ------------------------------------------------------------------------------
#  SLASH
#  Voice command (French): "Taillade"
# ------------------------------------------------------------------------------

#' Slash effect
#'
#' Sharp impact frame — quick grey anticipation, brilliant white blade flash,
#' a bright red SLASH peak, then a fast white-to-grey fade. No bleed.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
slash <- function() {
  play_sound(.get_sound_path("slash.wav"))

  change_light(color_name = "#3A3A3A", brightness = 0.18, duration = 0.04) # grey anticipation
  change_light(color_name = "#FFFFFF", brightness = 0.92, duration = 0.03) # steel flash
  change_light(color_name = "#FF0033", brightness = 0.98, duration = 0.03) # RED SLASH
  change_light(color_name = "#EEEEEE", brightness = 0.65, duration = 0.05) # white fadeout
  change_light(color_name = "#888888", brightness = 0.30, duration = 0.10) # grey settle
  change_light(color_name = "#404040", brightness = 0.10, duration = 0.28) # quiet grey

  revert_state(duration = 1)
}


# ------------------------------------------------------------------------------
#  PIERCE
#  Voice command (French): "Estoc"
# ------------------------------------------------------------------------------

#' Pierce effect
#'
#' Focused impact frame — grey anticipation, sharp white point flash, a bright
#' red THRUST peak, then a tight white-to-grey fadeout. No bleed.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
pierce <- function() {
  play_sound(.get_sound_path("pierce.wav"))

  change_light(color_name = "#3A3A3A", brightness = 0.16, duration = 0.04) # grey anticipation
  change_light(color_name = "#FFFFFF", brightness = 0.82, duration = 0.03) # point flash
  change_light(color_name = "#FF0033", brightness = 0.95, duration = 0.04) # RED THRUST
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
#' The spider strikes from shadow: a sharp green venom flash, then creeping
#' poison spreading through deeper green into paralysis darkness.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
spider_bite <- function() {
  play_sound(.get_sound_path("spider_bite.wav"))

  change_light(color_name = "#0A1500", brightness = 0.04, duration = 0.12) # shadow strike
  change_light(color_name = "#22AA00", brightness = 0.32, duration = 0.05) # bite contact
  change_light(color_name = "#44FF00", brightness = 0.65, duration = 0.07) # venom flash
  change_light(color_name = "#33CC00", brightness = 0.40, duration = 0.14) # poison spreading
  change_light(color_name = "#114400", brightness = 0.14, duration = 0.50) # venom courses
  change_light(color_name = "#081A00", brightness = 0.04, duration = 0.95) # paralysis

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  WORM SURGE
#  A giant worm burrowing up from the ground in a sudden frenzy
# ------------------------------------------------------------------------------

#' Worm Surge effect
#'
#' Deep brown rumble underground, then the eruption transitions brown → purple
#' → brown as the worm bursts up, twists in purple-tinged frenzy, and the
#' creature looms in receding earth tones.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
worm_surge <- function() {
  play_sound(.get_sound_path("worm_surge.wav"))

  change_light(color_name = "#2A1800", brightness = 0.08, duration = 0.35) # rumbling beneath
  change_light(color_name = "#5C3D20", brightness = 0.22, duration = 0.25) # ground cracking
  change_light(color_name = "#7A4A28", brightness = 0.55, duration = 0.14) # earth bursts — brown
  change_light(color_name = "#6A3878", brightness = 0.75, duration = 0.12) # purple eruption — peak
  change_light(color_name = "#7A4A28", brightness = 0.55, duration = 0.15) # back to brown
  change_light(color_name = "#5C3018", brightness = 0.38, duration = 0.25) # writhing
  change_light(color_name = "#3A2010", brightness = 0.15, duration = 0.85) # looming
  change_light(color_name = "#1F1008", brightness = 0.05, duration = 0.80) # settle

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  CRYSTAL BREATH
#  The crystal breath weapon of a dragon
# ------------------------------------------------------------------------------

#' Crystal Breath effect
#'
#' Pale crystals form in the throat, charge to a peak, a blinding barrage of
#' cyan shards fires, and splinters settle through cooler blues into stillness.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
crystal_breath <- function() {
  play_sound(.get_sound_path("crystal_breath.wav"))

  change_light(color_name = "#1A2A35", brightness = 0.10, duration = 0.20) # anticipation
  change_light(color_name = "#AAEEFF", brightness = 0.35, duration = 0.18) # crystals forming
  change_light(color_name = "#66DDFF", brightness = 0.65, duration = 0.14) # charging
  change_light(color_name = "#EEFFFF", brightness = 0.98, duration = 0.12) # blinding barrage
  change_light(color_name = "#88CCFF", brightness = 0.62, duration = 0.18) # shards flying
  change_light(color_name = "#4499CC", brightness = 0.38, duration = 0.30) # impact shatter
  change_light(color_name = "#224466", brightness = 0.14, duration = 1.20) # splinters settle

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  DRAGON BITE
#  The bite of a dragon
# ------------------------------------------------------------------------------

#' Dragon Bite effect
#'
#' Shadow of jaws descending in deepening darkness, a savage red impact,
#' wrenching tear, then deepening blood-red wound that settles into pain.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
dragon_bite <- function() {
  play_sound(.get_sound_path("dragon_bite.wav"))

  change_light(color_name = "#1A0000", brightness = 0.06, duration = 0.12) # jaws descend
  change_light(color_name = "#5A0808", brightness = 0.28, duration = 0.05) # contact
  change_light(color_name = "#CC3300", brightness = 0.78, duration = 0.06) # BITE — red
  change_light(color_name = "#880000", brightness = 0.45, duration = 0.10) # tear
  change_light(color_name = "#550000", brightness = 0.22, duration = 0.30) # wound
  change_light(color_name = "#220000", brightness = 0.08, duration = 0.90) # pain settles

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
#' Electric-blue charge builds as the magical hammer swings, detonates on
#' impact in a blue-white flash, and a crackling shockwave fades through
#' deepening blue.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
hammer_slam <- function() {
  play_sound(.get_sound_path("hammer_slam.wav"))

  change_light(color_name = "#0A1A40", brightness = 0.12, duration = 0.10) # anticipation
  change_light(color_name = "#4488FF", brightness = 0.50, duration = 0.08) # charge builds
  change_light(color_name = "#AACCFF", brightness = 0.95, duration = 0.06) # SLAM flash
  change_light(color_name = "#2266FF", brightness = 0.70, duration = 0.10) # shockwave
  change_light(color_name = "#1144CC", brightness = 0.40, duration = 0.25) # crackling
  change_light(color_name = "#001888", brightness = 0.12, duration = 0.75) # grounding

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  IGNITE
#  A burst of flame as something small combusts
# ------------------------------------------------------------------------------

#' Ignite effect
#'
#' A combustion spark builds into a brief hot-orange burst and smooths down to
#' a quick smoulder.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
ignite <- function() {
  play_sound(.get_sound_path("ignite.wav"))

  change_light(color_name = "#FF6600", brightness = 0.45, duration = 0.06) # combustion spark
  change_light(color_name = "#FFAA00", brightness = 0.88, duration = 0.07) # burst peak
  change_light(color_name = "#FF7700", brightness = 0.55, duration = 0.12) # flame blooms
  change_light(color_name = "#CC2200", brightness = 0.22, duration = 0.30) # smoulder
  change_light(color_name = "#5A1000", brightness = 0.06, duration = 0.60) # quiet ember

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  GUST
#  A rush of wind
# ------------------------------------------------------------------------------

#' Gust effect
#'
#' Pale wind gathers, the rush hits in a soft white-blue flicker, and streams
#' away through cooler blues.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
gust <- function() {
  play_sound(.get_sound_path("gust.wav"))

  change_light(color_name = "#E8F4FF", brightness = 0.28, duration = 0.10) # wind gathering
  change_light(color_name = "#FFFFFF", brightness = 0.62, duration = 0.10) # rush peak
  change_light(color_name = "#CCE8FF", brightness = 0.40, duration = 0.15) # streaming
  change_light(color_name = "#AADDFF", brightness = 0.20, duration = 0.30) # dispersing
  change_light(color_name = "#6090C0", brightness = 0.06, duration = 0.50) # last breath

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  SPORE BURST
#  A release of bright spores
# ------------------------------------------------------------------------------

#' Spore Burst effect
#'
#' A sac ruptures from dark forest green, blooms into a bright light-purple
#' cloud at peak, and the spores settle back through purple-green into deep
#' green stillness.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
spore_burst <- function() {
  play_sound(.get_sound_path("spore_burst.wav"))

  change_light(color_name = "#0F2A0F", brightness = 0.18, duration = 0.18) # dark green sac
  change_light(color_name = "#3A5A2A", brightness = 0.35, duration = 0.12) # building pressure
  change_light(color_name = "#9070C8", brightness = 0.60, duration = 0.12) # rupture transition
  change_light(color_name = "#D8A8FF", brightness = 0.88, duration = 0.15) # light purple peak
  change_light(color_name = "#A878D0", brightness = 0.55, duration = 0.25) # cloud drifts
  change_light(color_name = "#5A6038", brightness = 0.28, duration = 0.45) # purple-green settle
  change_light(color_name = "#1F3015", brightness = 0.10, duration = 1.00) # deep green

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  FLASK SHATTER
#  An alchemical flask shattering
# ------------------------------------------------------------------------------

#' Flask Shatter effect
#'
#' Glass shatters and the alchemical reaction flares in a bright yellow-green
#' flash; fumes rise and the haze settles down through olive into dark.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
flask_shatter <- function() {
  play_sound(.get_sound_path("flask_shatter.wav"))

  change_light(color_name = "#88AA20", brightness = 0.40, duration = 0.05) # shatter
  change_light(color_name = "#CCFF66", brightness = 0.90, duration = 0.06) # reaction peak
  change_light(color_name = "#AAEE33", brightness = 0.65, duration = 0.08) # spray
  change_light(color_name = "#88DD00", brightness = 0.40, duration = 0.12) # spreading
  change_light(color_name = "#446600", brightness = 0.20, duration = 0.30) # fumes
  change_light(color_name = "#223300", brightness = 0.06, duration = 0.80) # haze

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  STEAM BLAST
#  A blast of steam
# ------------------------------------------------------------------------------

#' Steam Blast effect
#'
#' A pressurised vent erupts in a blinding white burst, billows out through
#' lighter whites, and thins to drifting wisps.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
steam_blast <- function() {
  play_sound(.get_sound_path("steam_blast.wav"))

  change_light(color_name = "#E8E8E8", brightness = 0.45, duration = 0.08) # vent builds
  change_light(color_name = "#FFFFFF", brightness = 0.92, duration = 0.08) # white burst
  change_light(color_name = "#F5F5F5", brightness = 0.70, duration = 0.12) # billowing
  change_light(color_name = "#EBEBEB", brightness = 0.50, duration = 0.20) # rolling
  change_light(color_name = "#D8D8D8", brightness = 0.28, duration = 0.45) # thinning
  change_light(color_name = "#BBBBBB", brightness = 0.10, duration = 0.85) # last wisps

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  ARCANE SURGE
#  A massive release of metallic arcane energy
# ------------------------------------------------------------------------------

#' Arcane Surge effect
#'
#' Metallic energy builds through silver to gold, detonates in a blinding
#' silver-white burst, and dissipates through metallic haze.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
arcane_surge <- function() {
  play_sound(.get_sound_path("arcane_surge.wav"))

  change_light(color_name = "#3A3A40", brightness = 0.15, duration = 0.20) # anticipation
  change_light(color_name = "#C0C0C0", brightness = 0.45, duration = 0.25) # silver building
  change_light(color_name = "#FFD700", brightness = 0.70, duration = 0.25) # gold surge
  change_light(color_name = "#F8F8F8", brightness = 0.98, duration = 0.16) # blinding burst
  change_light(color_name = "#E8D080", brightness = 0.72, duration = 0.20) # shockwave
  change_light(color_name = "#A09050", brightness = 0.48, duration = 0.40) # metallic haze
  change_light(color_name = "#705030", brightness = 0.18, duration = 1.50) # dissipating

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  SAND BLAST
#  A blast of sand
# ------------------------------------------------------------------------------

#' Sand Blast effect
#'
#' Amber sand swirls up, fires in a stinging blast, and the cloud settles
#' through warm sand tones into drifting dust.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
sand_blast <- function() {
  play_sound(.get_sound_path("sand_blast.wav"))

  change_light(color_name = "#A07840", brightness = 0.28, duration = 0.10) # sand swirls
  change_light(color_name = "#D4A055", brightness = 0.55, duration = 0.10) # building
  change_light(color_name = "#E8B860", brightness = 0.78, duration = 0.10) # blast peak
  change_light(color_name = "#C89040", brightness = 0.55, duration = 0.14) # spreading
  change_light(color_name = "#A07030", brightness = 0.32, duration = 0.30) # cloud settles
  change_light(color_name = "#704A1A", brightness = 0.10, duration = 0.75) # dust haze

  revert_state(duration = 2)
}
