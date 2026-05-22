# ==============================================================================
# dndlights — Spell Functions
# ==============================================================================
# All light sequences use only change_light() and revert_state(). Transitions
# are tuned to feel like a continuous ribbon of colour: no abrupt hue jumps,
# no harsh brightness cliffs. For high-impact spells a brief anticipation dim
# precedes the strike, then peak, then a smooth tail back to scene.
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
#' A brief darkening anticipates the cast; ignition blooms through orange into
#' a peak white-gold explosion, then rolls smoothly through deep orange into a
#' long red ember.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
fireball <- function() {
  play_sound(.get_sound_path("fireball.wav"))
  Sys.sleep(0.15)

  change_light(color_name = "#2A1000", brightness = 0.06, duration = 0.18) # anticipation dim
  change_light(color_name = "#A04000", brightness = 0.28, duration = 0.15) # ignition kindles
  change_light(color_name = "#F18805", brightness = 0.60, duration = 0.20) # fireball forming
  change_light(color_name = "#FDBE49", brightness = 0.95, duration = 0.22) # explosion peak
  change_light(color_name = "#FF7A00", brightness = 0.80, duration = 0.30) # rolling fire
  change_light(color_name = "#E84500", brightness = 0.55, duration = 0.45) # deep burn
  change_light(color_name = "#DB461D", brightness = 0.30, duration = 2.20) # ember glow

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  ELDRITCH BLAST
#  Voice command (French): "Funeste"
# ------------------------------------------------------------------------------

#' Eldritch Blast spell effect
#'
#' Darkness gathers in deep teal before a cold cyan beam fires, peaks, then
#' settles back through teal into void silence.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
eldritch_blast <- function() {
  play_sound(.get_sound_path("eldritch_blast.wav"))

  change_light(color_name = "#001821", brightness = 0.05, duration = 0.30) # void gathers
  change_light(color_name = "#1B6B85", brightness = 0.25, duration = 0.20) # teal stirs
  change_light(color_name = "#5BC6E3", brightness = 0.55, duration = 0.15) # cyan charges
  change_light(color_name = "#00E5FF", brightness = 0.80, duration = 0.18) # beam fires
  change_light(color_name = "#0097A7", brightness = 0.45, duration = 0.25) # impact
  change_light(color_name = "#0F4C5C", brightness = 0.22, duration = 0.45) # energy settling
  change_light(color_name = "#001821", brightness = 0.06, duration = 1.40) # void silence

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  ICE KNIFE
#  Voice command (French): "Givre"
# ------------------------------------------------------------------------------

#' Ice Knife spell effect
#'
#' Pure light blue throughout — cold mist gathers, the knife brightens to a
#' vivid peak, strikes, then fades back through pale blue into chill.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
ice_knife <- function() {
  play_sound(.get_sound_path("ice_knife.wav"))

  change_light(color_name = "#C8E6F5", brightness = 0.18, duration = 0.20) # mist gathers
  change_light(color_name = "#A0D8F0", brightness = 0.40, duration = 0.15) # cold building
  change_light(color_name = "#7AC8EC", brightness = 0.65, duration = 0.15) # knife forming
  change_light(color_name = "#5BB8E8", brightness = 0.90, duration = 0.18) # strike peak
  change_light(color_name = "#7AC8EC", brightness = 0.55, duration = 0.22) # impact tail
  change_light(color_name = "#A0D8F0", brightness = 0.30, duration = 0.55) # frost spread
  change_light(color_name = "#86C8E8", brightness = 0.14, duration = 1.10) # lingering chill

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  SHIELD
#  Voice command (French): "Bouclier"
# ------------------------------------------------------------------------------

#' Shield spell effect
#'
#' Warm cream rises into a brilliant gold barrier flash, then settles to a
#' steady protective glow before fading.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
shield <- function() {
  play_sound(.get_sound_path("shield.wav"))

  change_light(color_name = "#FFF8DC", brightness = 0.30, duration = 0.12) # reactive cream
  change_light(color_name = "#FFE680", brightness = 0.55, duration = 0.12) # gold rises
  change_light(color_name = "#FFD700", brightness = 0.85, duration = 0.15) # barrier manifests
  change_light(color_name = "#FFF1B0", brightness = 0.92, duration = 0.18) # white-gold peak
  change_light(color_name = "#FFD700", brightness = 0.65, duration = 0.30) # gold shimmer
  change_light(color_name = "#FFF1B0", brightness = 0.40, duration = 0.60) # warm settling
  change_light(color_name = "#FFD700", brightness = 0.20, duration = 1.80) # barrier holds

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  LIGHTNING BOLT
#  Voice command (French): "Foudre"
# ------------------------------------------------------------------------------

#' Lightning Bolt spell effect
#'
#' Anticipation dim, then three rapid blue-white strobes for the strike,
#' followed by a blue-white afterburn that smooths down through indigo.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
lightning_bolt <- function() {
  play_sound(.get_sound_path("lightning_bolt.wav"))

  change_light(color_name = "#0A1A40", brightness = 0.08, duration = 0.15) # anticipation dim
  change_light(color_name = "#E8F0FF", brightness = 1.00, duration = 0.05) # strobe 1
  change_light(color_name = "#5070A0", brightness = 0.18, duration = 0.04) # dim flicker
  change_light(color_name = "#E8F0FF", brightness = 1.00, duration = 0.05) # strobe 2
  change_light(color_name = "#5070A0", brightness = 0.18, duration = 0.04) # dim flicker
  change_light(color_name = "#E8F0FF", brightness = 1.00, duration = 0.06) # strobe 3 sustained
  change_light(color_name = "#A0C8FF", brightness = 0.75, duration = 0.12) # blue-white afterburn
  change_light(color_name = "#4070C0", brightness = 0.40, duration = 0.30) # cooling indigo
  change_light(color_name = "#1A3060", brightness = 0.12, duration = 1.10) # ozone fade

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  CURE WOUNDS
#  Voice command (French): "Guérison"
# ------------------------------------------------------------------------------

#' Cure Wounds spell effect
#'
#' A slow, warm golden bloom — healing light rises, peaks gently, and breathes
#' out through pale gold into calm.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
cure_wounds <- function() {
  play_sound(.get_sound_path("cure_wounds.wav"))

  change_light(color_name = "#FFF8E0", brightness = 0.10, duration = 0.50) # first whisper
  change_light(color_name = "#FFE9A8", brightness = 0.30, duration = 0.80) # soft gold rises
  change_light(color_name = "#FFD46A", brightness = 0.55, duration = 1.00) # warm gold brightens
  change_light(color_name = "#FFE08A", brightness = 0.72, duration = 1.10) # healing peak
  change_light(color_name = "#FFE9A8", brightness = 0.45, duration = 1.30) # warmth settles
  change_light(color_name = "#FFF1C8", brightness = 0.18, duration = 1.80) # pale gold fades

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  FIREBOLT
#  Voice command (French): "Étincelle"
# ------------------------------------------------------------------------------

#' Firebolt spell effect
#'
#' A sharp orange ignition launches as a searing bolt, peaks bright orange,
#' and smooths down through warm amber to a quick ember.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
firebolt <- function() {
  play_sound(.get_sound_path("firebolt.wav"))

  change_light(color_name = "#2A1000", brightness = 0.08, duration = 0.10) # anticipation
  change_light(color_name = "#FF9020", brightness = 0.45, duration = 0.10) # ignition
  change_light(color_name = "#FF7A00", brightness = 0.90, duration = 0.12) # bolt peak — bright orange
  change_light(color_name = "#FF8A20", brightness = 0.65, duration = 0.15) # impact glow
  change_light(color_name = "#E86A00", brightness = 0.42, duration = 0.25) # warm amber
  change_light(color_name = "#A03800", brightness = 0.14, duration = 0.70) # smolder out

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  PRESTIDIGITATION
#  Voice command (French): "Sortilège"
# ------------------------------------------------------------------------------

#' Prestidigitation spell effect
#'
#' A subtle whimsical shimmer — soft lavender and warm cream tones rise gently,
#' breathe through a faint pink-mauve, and fade to nothing. The cantrip is
#' minor, so the light is gentle and easy on the eyes.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
prestidigitation <- function() {
  play_sound(.get_sound_path("prestidigitation.wav"))

  change_light(color_name = "#F4E8F5", brightness = 0.18, duration = 0.40) # faint shimmer
  change_light(color_name = "#E8D0F0", brightness = 0.28, duration = 0.45) # soft lavender
  change_light(color_name = "#F0DAE5", brightness = 0.32, duration = 0.50) # pink-mauve breath
  change_light(color_name = "#DCC8E5", brightness = 0.22, duration = 0.60) # gentle settle
  change_light(color_name = "#C8B0D0", brightness = 0.10, duration = 1.20) # quiet fade

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  WATER WHIP
#  Voice command (French): "Fouet"
# ------------------------------------------------------------------------------

#' Water Whip spell effect
#'
#' Pale aqua gathers, deepens through cyan as the whip coils, cracks in a
#' vivid aquamarine flash, and rolls down through deep ocean blue to dark.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
water_whip <- function() {
  play_sound(.get_sound_path("water_whip.wav"))

  change_light(color_name = "#CAF0F8", brightness = 0.22, duration = 0.30) # water gathers
  change_light(color_name = "#90E0EF", brightness = 0.40, duration = 0.25) # building flow
  change_light(color_name = "#00B4D8", brightness = 0.60, duration = 0.20) # whip forming
  change_light(color_name = "#0096C7", brightness = 0.72, duration = 0.18) # coil force
  change_light(color_name = "#48CAE4", brightness = 0.92, duration = 0.15) # CRACK — peak aqua
  change_light(color_name = "#0077B6", brightness = 0.55, duration = 0.25) # impact wash
  change_light(color_name = "#023E8A", brightness = 0.28, duration = 0.70) # deep blue residual
  change_light(color_name = "#03045E", brightness = 0.10, duration = 1.20) # ocean settle

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  MAGIC MISSILE
#  Voice command (French): "Carreau"
# ------------------------------------------------------------------------------

#' Magic Missile spell effect
#'
#' Two auto-hitting darts of arcane force — each a distinct bright white pulse
#' separated by a brief dim — followed by a warm white afterglow that fades.
#' Matches the two-dart cadence of the bundled sound file.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
magic_missile <- function() {
  play_sound(.get_sound_path("magic_missile.wav"))

  change_light(color_name = "#202028", brightness = 0.06, duration = 0.12) # void before
  # — Dart 1 —
  change_light(color_name = "#FFFFFF", brightness = 0.95, duration = 0.10) # dart 1 fires
  change_light(color_name = "#404048", brightness = 0.12, duration = 0.14) # dim between
  # — Dart 2 —
  change_light(color_name = "#FFFFFF", brightness = 0.95, duration = 0.10) # dart 2 fires
  change_light(color_name = "#E0E0E8", brightness = 0.55, duration = 0.18) # afterglow
  change_light(color_name = "#A0A0B0", brightness = 0.25, duration = 0.50) # cooling
  change_light(color_name = "#404050", brightness = 0.08, duration = 1.00) # last trace

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  LIGHT
#  Voice command (French): "Lueur"
# ------------------------------------------------------------------------------

#' Light spell effect
#'
#' A mote of radiance kindles from nothing and swells steadily into a sustained
#' warm-white glow.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
light <- function() {
  play_sound(.get_sound_path("light.wav"))
  Sys.sleep(0.20)

  change_light(color_name = "#FFF8E1", brightness = 0.10, duration = 0.40) # faint kindling
  change_light(color_name = "#FFFDE7", brightness = 0.28, duration = 0.55) # brightening
  change_light(color_name = "#FFFCEA", brightness = 0.50, duration = 0.70) # rising radiance
  change_light(color_name = "#FFFFFF", brightness = 0.70, duration = 0.70) # full light
  change_light(color_name = "#FFF8D6", brightness = 0.55, duration = 1.60) # warm hold

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  MAGE ARMOR
#  Voice command (French): "Égide"
# ------------------------------------------------------------------------------

#' Mage Armor spell effect
#'
#' A light-blue arcane shimmer braids with gold trim as the armour forms,
#' brightens to a blue-gold peak, and settles to a steady protective ward.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
mage_armor <- function() {
  play_sound(.get_sound_path("mage_armor.wav"))

  change_light(color_name = "#C8E8F8", brightness = 0.18, duration = 0.30) # cool shimmer
  change_light(color_name = "#A8D8F0", brightness = 0.35, duration = 0.30) # blue brightens
  change_light(color_name = "#E8D890", brightness = 0.55, duration = 0.30) # gold trim braids in
  change_light(color_name = "#F8E8A8", brightness = 0.80, duration = 0.22) # blue-gold peak
  change_light(color_name = "#BDD8E8", brightness = 0.45, duration = 0.45) # ward settling
  change_light(color_name = "#90B8D8", brightness = 0.22, duration = 1.80) # steady ward

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  MISTY STEP
#  Voice command (French): "Brume"
# ------------------------------------------------------------------------------

#' Misty Step spell effect
#'
#' Silver mist rises, the caster fades through it into near-dark, then a soft
#' teal flash signals their reappearance and the mist dissipates.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
misty_step <- function() {
  play_sound(.get_sound_path("misty_step.wav"))

  change_light(color_name = "#E0F7FA", brightness = 0.25, duration = 0.25) # mist rising
  change_light(color_name = "#A8D8E0", brightness = 0.15, duration = 0.18) # dimming
  change_light(color_name = "#5A7080", brightness = 0.05, duration = 0.15) # vanish point
  change_light(color_name = "#B8E8F0", brightness = 0.40, duration = 0.12) # reappearance flash
  change_light(color_name = "#80DEEA", brightness = 0.25, duration = 0.30) # mist settles
  change_light(color_name = "#4DD0E1", brightness = 0.08, duration = 0.80) # wisps fade

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  MORDENKAINEN'S PRIVATE SANCTUM
#  Voice command (French): "Citadelle"
# ------------------------------------------------------------------------------

#' Mordenkainen's Private Sanctum spell effect
#'
#' Pale wards stir, spread outward in deepening purple, peak as the barrier
#' seals, and settle to a steady low-purple hum that holds for several seconds.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
private_sanctum <- function() {
  play_sound(.get_sound_path("private_sanctum.wav"))

  change_light(color_name = "#E8D5F5", brightness = 0.10, duration = 0.60) # wards stir
  change_light(color_name = "#C39BD3", brightness = 0.25, duration = 0.75) # spreading
  change_light(color_name = "#9970C8", brightness = 0.42, duration = 0.80) # walls forming
  change_light(color_name = "#7B68EE", brightness = 0.50, duration = 0.50) # sanctum sealed
  change_light(color_name = "#6B4A98", brightness = 0.32, duration = 0.80) # settling
  change_light(color_name = "#4A235A", brightness = 0.14, duration = 2.80) # ward holds

  revert_state(duration = 5)
}


# ------------------------------------------------------------------------------
#  BOOMING BLADE
#  Voice command (French): "Grondement"
# ------------------------------------------------------------------------------

#' Booming Blade spell effect
#'
#' Electric-blue charge builds along the blade, swings through, and detonates
#' on impact in a white-blue boom — shockwave ripples and crackling fade out.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
booming_blade <- function() {
  play_sound(.get_sound_path("booming_blade.wav"))

  change_light(color_name = "#1A2848", brightness = 0.10, duration = 0.15) # anticipation
  change_light(color_name = "#B3D9FF", brightness = 0.40, duration = 0.15) # blade charges
  change_light(color_name = "#00BFFF", brightness = 0.70, duration = 0.12) # swing
  change_light(color_name = "#E8F4FF", brightness = 0.95, duration = 0.10) # IMPACT
  change_light(color_name = "#4488DD", brightness = 0.60, duration = 0.18) # shockwave
  change_light(color_name = "#1A52A0", brightness = 0.32, duration = 0.40) # crackling
  change_light(color_name = "#0A2050", brightness = 0.10, duration = 0.90) # echoes

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  DISGUISE SELF
#  Voice command (French): "Frimousse"
# ------------------------------------------------------------------------------

#' Disguise Self spell effect
#'
#' Light blue shimmer ripples through, blending with violet as the illusion
#' settles around the caster — the two hues weave together before holding.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
disguise_self <- function() {
  play_sound(.get_sound_path("disguise_self.wav"))

  change_light(color_name = "#D8E8F8", brightness = 0.28, duration = 0.25) # shimmer begins
  change_light(color_name = "#A8C8F0", brightness = 0.40, duration = 0.25) # light blue rises
  change_light(color_name = "#B8A8E0", brightness = 0.45, duration = 0.25) # blue-violet blend
  change_light(color_name = "#9080D0", brightness = 0.50, duration = 0.25) # violet ripple
  change_light(color_name = "#A8B8E0", brightness = 0.35, duration = 0.35) # blue settles
  change_light(color_name = "#9890C0", brightness = 0.20, duration = 1.20) # illusion holds

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  HASTE
#  Voice command (French): "Véloce"
# ------------------------------------------------------------------------------

#' Haste spell effect
#'
#' A surge of warm gold accelerates the target — bright cream burst at peak,
#' settling into a sustained golden aura that holds and slowly fades.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
haste <- function() {
  play_sound(.get_sound_path("haste.wav"))

  change_light(color_name = "#FFF4C8", brightness = 0.30, duration = 0.18) # spark
  change_light(color_name = "#FFE680", brightness = 0.55, duration = 0.15) # gold surges
  change_light(color_name = "#FFF1B0", brightness = 0.88, duration = 0.10) # burst peak
  change_light(color_name = "#FFD23F", brightness = 0.70, duration = 0.20) # vibrant gold
  change_light(color_name = "#E8B020", brightness = 0.50, duration = 0.40) # sustained aura
  change_light(color_name = "#C89010", brightness = 0.28, duration = 1.50) # aura holds

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  ACID SPLASH
#  Voice command (French): "Acerbe"
# ------------------------------------------------------------------------------

#' Acid Splash spell effect
#'
#' A caustic yellow-green orb peaks in a bright splash, then spreads and dims
#' through olive into a dark chemical settle.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
acid_splash <- function() {
  play_sound(.get_sound_path("acid_splash.wav"))

  change_light(color_name = "#8AB000", brightness = 0.35, duration = 0.10) # orb hurled
  change_light(color_name = "#AAFB00", brightness = 0.65, duration = 0.08) # build
  change_light(color_name = "#CCFF33", brightness = 0.85, duration = 0.10) # splash peak
  change_light(color_name = "#99EE00", brightness = 0.55, duration = 0.14) # spread
  change_light(color_name = "#557700", brightness = 0.24, duration = 0.32) # corrosive
  change_light(color_name = "#334400", brightness = 0.08, duration = 0.85) # fumes

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  HEAT METAL
#  Voice command (French): "Brasier"
# ------------------------------------------------------------------------------

#' Heat Metal spell effect
#'
#' Cold steel begins as a metallic grey-blue tone, then slowly warms through
#' dull copper, red-orange, blazing orange, and white-hot agony before cooling
#' to a long red glow.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
heat_metal <- function() {
  play_sound(.get_sound_path("heat_metal.wav"))

  change_light(color_name = "#7088A0", brightness = 0.18, duration = 0.65) # cold steel
  change_light(color_name = "#A88060", brightness = 0.28, duration = 0.65) # dull copper warming
  change_light(color_name = "#D06820", brightness = 0.42, duration = 0.65) # red-orange glow
  change_light(color_name = "#FF6200", brightness = 0.65, duration = 0.55) # orange-hot
  change_light(color_name = "#FFAA00", brightness = 0.85, duration = 0.50) # white-hot peak
  change_light(color_name = "#FF5500", brightness = 0.55, duration = 1.20) # searing sustained
  change_light(color_name = "#CC3300", brightness = 0.30, duration = 2.00) # red holds

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  FAERIE FIRE
#  Voice command (French): "Féerie"
# ------------------------------------------------------------------------------

#' Faerie Fire spell effect
#'
#' Bright sparks of vivid violet ignite and spread to outline targets in
#' brilliant, vibrant purple flame that persists.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
faerie_fire <- function() {
  play_sound(.get_sound_path("faerie_fire.wav"))

  change_light(color_name = "#D866FF", brightness = 0.40, duration = 0.22) # bright sparks
  change_light(color_name = "#C040FF", brightness = 0.70, duration = 0.20) # spreading
  change_light(color_name = "#E888FF", brightness = 0.95, duration = 0.20) # peak — vivid
  change_light(color_name = "#C040FF", brightness = 0.80, duration = 0.25) # outlines hold
  change_light(color_name = "#A828EE", brightness = 0.70, duration = 0.35) # vibrant glow
  change_light(color_name = "#9020E0", brightness = 0.55, duration = 1.80) # persists

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  RAY OF FROST
#  Voice command (French): "Verglas"
# ------------------------------------------------------------------------------

#' Ray of Frost spell effect
#'
#' Pale cold focuses, the ray fires bright blue, and frost spreads down
#' through deeper blues into a residual chill.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
ray_of_frost <- function() {
  play_sound(.get_sound_path("ray_of_frost.wav"))

  change_light(color_name = "#E8F4FF", brightness = 0.25, duration = 0.18) # cold focus
  change_light(color_name = "#A8DCFF", brightness = 0.50, duration = 0.12) # ray builds
  change_light(color_name = "#80CCFF", brightness = 0.80, duration = 0.10) # ray fires
  change_light(color_name = "#A0D0F0", brightness = 0.50, duration = 0.18) # impact
  change_light(color_name = "#60A8E8", brightness = 0.25, duration = 0.45) # frost spread
  change_light(color_name = "#3080C0", brightness = 0.10, duration = 0.85) # frozen residue

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  WALL OF FIRE
#  Voice command (French): "Fournaise"
# ------------------------------------------------------------------------------

#' Wall of Fire spell effect
#'
#' Embers ignite, the wall rises into a towering orange inferno, peaks at
#' near-white-hot, and holds at sustained roar before fading.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
wall_of_fire <- function() {
  play_sound(.get_sound_path("wall_of_fire.wav"))

  change_light(color_name = "#3A1000", brightness = 0.10, duration = 0.20) # embers stir
  change_light(color_name = "#FF6600", brightness = 0.45, duration = 0.25) # ground ignites
  change_light(color_name = "#FF8C00", brightness = 0.70, duration = 0.30) # wall rises
  change_light(color_name = "#FFAA00", brightness = 0.92, duration = 0.32) # towering peak
  change_light(color_name = "#FF6600", brightness = 0.82, duration = 0.50) # roaring hold
  change_light(color_name = "#FF4400", brightness = 0.72, duration = 2.80) # sustained blaze

  revert_state(duration = 5)
}


# ------------------------------------------------------------------------------
#  FINGER OF DEATH
#  Voice command (French): "Trépas"
# ------------------------------------------------------------------------------

#' Finger of Death spell effect
#'
#' Death gathers in deep green darkness, a sickly green beam fires, and the
#' impact frame is a whiter, brighter green before life drains back through
#' green into void.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
finger_of_death <- function() {
  play_sound(.get_sound_path("finger_of_death.wav"))

  change_light(color_name = "#001A00", brightness = 0.04, duration = 0.30) # death gathers
  change_light(color_name = "#005A20", brightness = 0.28, duration = 0.18) # necrotic stirs
  change_light(color_name = "#00B040", brightness = 0.55, duration = 0.12) # beam fires
  change_light(color_name = "#C8FFD8", brightness = 0.90, duration = 0.10) # IMPACT — whiter green
  change_light(color_name = "#00B040", brightness = 0.55, duration = 0.18) # tail
  change_light(color_name = "#003300", brightness = 0.22, duration = 0.30) # life draining
  change_light(color_name = "#001800", brightness = 0.08, duration = 0.55) # settling
  change_light(color_name = "#000800", brightness = 0.02, duration = 1.40) # void

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  DISINTEGRATE
#  Voice command (French): "Néant"
# ------------------------------------------------------------------------------

#' Disintegrate spell effect
#'
#' Fire-based disintegration: orange ignites the target, peaks in a searing
#' flare, then transitions through smoke-grey as the matter crumbles to ash.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
disintegrate <- function() {
  play_sound(.get_sound_path("disintegrate.wav"))

  change_light(color_name = "#2A1500", brightness = 0.10, duration = 0.18) # anticipation
  change_light(color_name = "#FF6200", brightness = 0.55, duration = 0.15) # orange charges
  change_light(color_name = "#FF8C00", brightness = 0.85, duration = 0.12) # ray fires
  change_light(color_name = "#FFAA40", brightness = 0.98, duration = 0.10) # disintegration peak
  change_light(color_name = "#C86820", brightness = 0.60, duration = 0.18) # matter crumbling
  change_light(color_name = "#7A6050", brightness = 0.30, duration = 0.30) # ash forming
  change_light(color_name = "#4A4845", brightness = 0.15, duration = 0.55) # smoke grey
  change_light(color_name = "#2A2825", brightness = 0.05, duration = 1.00) # nothing left

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  BLIGHT
#  Voice command (French): "Flétrissure"
# ------------------------------------------------------------------------------

#' Blight spell effect
#'
#' Necrotic energy drains warm life through olive-yellow, browning, deepening,
#' and collapsing into withered darkness.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
blight <- function() {
  play_sound(.get_sound_path("blight.wav"))

  change_light(color_name = "#7A8030", brightness = 0.22, duration = 0.40) # tendrils reach
  change_light(color_name = "#8B6914", brightness = 0.32, duration = 0.55) # yellowing
  change_light(color_name = "#6B4C00", brightness = 0.38, duration = 0.50) # withering
  change_light(color_name = "#4A3000", brightness = 0.28, duration = 0.65) # decay deepens
  change_light(color_name = "#2A1800", brightness = 0.12, duration = 0.90) # collapse
  change_light(color_name = "#1A0F00", brightness = 0.04, duration = 1.60) # husks

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  MASS HEALING WORD
#  Voice command (French): "Cantique"
# ------------------------------------------------------------------------------

#' Mass Healing Word spell effect
#'
#' A stronger, longer version of cure_wounds — three golden waves of healing
#' radiate outward, peak warmly, and breathe back into pale gold.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
mass_healing_word <- function() {
  play_sound(.get_sound_path("mass_healing_word.wav"))

  change_light(color_name = "#FFF1C8", brightness = 0.18, duration = 0.40) # word spoken
  change_light(color_name = "#FFE9A8", brightness = 0.40, duration = 0.40) # first wave
  change_light(color_name = "#FFD46A", brightness = 0.65, duration = 0.35) # second wave
  change_light(color_name = "#FFC640", brightness = 0.88, duration = 0.30) # third — peak
  change_light(color_name = "#FFD46A", brightness = 0.62, duration = 0.45) # warmth spread
  change_light(color_name = "#FFE9A8", brightness = 0.36, duration = 0.70) # glow settles
  change_light(color_name = "#FFF8E0", brightness = 0.12, duration = 1.60) # pale gold residue

  revert_state(duration = 4)
}
