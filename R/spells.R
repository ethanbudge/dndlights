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


# ------------------------------------------------------------------------------
#  LIGHT
#  Voice command (French): "Lueur"
# ------------------------------------------------------------------------------

#' Light spell effect
#'
#' A small mote of radiance kindles from nothing and swells into a steady
#' warm-white glow.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
light <- function() {
  # LIGHT — Sound
  play_sound(.get_sound_path("light.wav"))
  Sys.sleep(0.20)

  # LIGHT — Light
  change_light(color_name = "#FFF8E1", brightness = 0.10, duration = 0.30) # faint warm glow kindling
  change_light(color_name = "#FFFDE7", brightness = 0.35, duration = 0.50) # brightening steadily
  change_light(color_name = "#FFFFFF", brightness = 0.65, duration = 0.70) # full radiance
  change_light(color_name = "#FFF8D6", brightness = 0.55, duration = 1.50) # warm light holds

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  MAGE ARMOR
#  Voice command (French): "Égide"
# ------------------------------------------------------------------------------

#' Mage Armor spell effect
#'
#' Cool arcane force shimmers into being and snaps closed around the target —
#' a blue-white barrier that settles to a steady protective ward.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
mage_armor <- function() {
  # MAGE ARMOR — Sound
  play_sound(.get_sound_path("mage_armor.wav"))

  # MAGE ARMOR — Light
  change_light(color_name = "#B3E5FC", brightness = 0.15, duration = 0.30) # cool shimmer stirs
  change_light(color_name = "#4FC3F7", brightness = 0.50, duration = 0.35) # arcane shell forming
  change_light(color_name = "#E3F2FD", brightness = 0.75, duration = 0.20) # armour snaps on — bright peak
  change_light(color_name = "#90CAF9", brightness = 0.35, duration = 0.40) # blue sheen settles
  change_light(color_name = "#5B8EC4", brightness = 0.18, duration = 2.00) # steady ward glowing

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  MISTY STEP
#  Voice command (French): "Brume"
# ------------------------------------------------------------------------------

#' Misty Step spell effect
#'
#' The caster dissolves into silver mist and reappears in a flash of pale
#' teal light — a blink so fast the eye barely catches it.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
misty_step <- function() {
  # MISTY STEP — Sound
  play_sound(.get_sound_path("misty_step.wav"))

  # MISTY STEP — Light
  change_light(color_name = "#E0F7FA", brightness = 0.20, duration = 0.20) # mist rising
  change_light(color_name = "#B2EBF2", brightness = 0.03, duration = 0.12) # caster vanishes
  change_light(color_name = "#E0FFFF", brightness = 0.65, duration = 0.08) # reappearance flash
  change_light(color_name = "#80DEEA", brightness = 0.22, duration = 0.25) # mist settling
  change_light(color_name = "#4DD0E1", brightness = 0.06, duration = 0.70) # last wisps fade

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  MORDENKAINEN'S PRIVATE SANCTUM
#  Voice command (French): "Citadelle"
# ------------------------------------------------------------------------------

#' Mordenkainen's Private Sanctum spell effect
#'
#' Deep arcane wards spread slowly outward and seal the area in an
#' impenetrable purple barrier that hums with quiet, powerful authority.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
private_sanctum <- function() {
  # PRIVATE SANCTUM — Sound
  play_sound(.get_sound_path("private_sanctum.wav"))

  # PRIVATE SANCTUM — Light
  change_light(color_name = "#E8D5F5", brightness = 0.08, duration = 0.60) # wards stirring
  change_light(color_name = "#C39BD3", brightness = 0.22, duration = 0.80) # barrier spreading
  change_light(color_name = "#7B68EE", brightness = 0.42, duration = 0.90) # sanctum walls forming
  change_light(color_name = "#9B59B6", brightness = 0.30, duration = 0.70) # deep ward settles
  change_light(color_name = "#4A235A", brightness = 0.12, duration = 3.00) # ward hums at low power

  revert_state(duration = 5)
}


# ------------------------------------------------------------------------------
#  BOOMING BLADE
#  Voice command (French): "Grondement"
# ------------------------------------------------------------------------------

#' Booming Blade spell effect
#'
#' Electric-blue energy charges along a blade and detonates on impact in a
#' thunderous shockwave, leaving crackling arcs before silence returns.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
booming_blade <- function() {
  # BOOMING BLADE — Sound
  play_sound(.get_sound_path("booming_blade.wav"))

  # BOOMING BLADE — Light
  change_light(color_name = "#B3D9FF", brightness = 0.25, duration = 0.12) # blade charges
  change_light(color_name = "#00BFFF", brightness = 0.60, duration = 0.10) # electric blade swings
  change_light(color_name = "#E8F4FF", brightness = 0.95, duration = 0.07) # IMPACT — thunderous boom
  change_light(color_name = "#4488DD", brightness = 0.55, duration = 0.12) # shockwave ripples
  change_light(color_name = "#1A52A0", brightness = 0.28, duration = 0.35) # crackling aftermath
  change_light(color_name = "#0A2050", brightness = 0.07, duration = 1.00) # echoes fading

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  DISGUISE SELF
#  Voice command (French): "Mascarade"
# ------------------------------------------------------------------------------

#' Disguise Self spell effect
#'
#' The caster's appearance ripples through a chaotic shimmer of illusion
#' colours before snapping into a convincingly new form.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
disguise_self <- function() {
  # DISGUISE SELF — Sound
  play_sound(.get_sound_path("disguise_self.wav"))

  # DISGUISE SELF — Light
  change_light(color_name = "#F5F5F5", brightness = 0.40, duration = 0.18) # shimmer begins
  change_light(color_name = "#FFB3FF", brightness = 0.35, duration = 0.13) # illusion ripple — magenta
  change_light(color_name = "#B3FFFF", brightness = 0.35, duration = 0.11) # cyan shift
  change_light(color_name = "#FFFFB3", brightness = 0.35, duration = 0.11) # yellow shift
  change_light(color_name = "#F0F0F0", brightness = 0.22, duration = 0.28) # new form stabilising
  change_light(color_name = "#E8E8E8", brightness = 0.10, duration = 1.20) # illusion holds

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  HASTE
#  Voice command (French): "Véloce"
# ------------------------------------------------------------------------------

#' Haste spell effect
#'
#' A surge of yellow-green energy accelerates the target into overdrive —
#' a blinding burst of speed that settles into a vibrant sustained aura.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
haste <- function() {
  # HASTE — Sound
  play_sound(.get_sound_path("haste.wav"))

  # HASTE — Light
  change_light(color_name = "#FFFF80", brightness = 0.30, duration = 0.18) # speed spark ignites
  change_light(color_name = "#AAFFAA", brightness = 0.55, duration = 0.14) # energy surges
  change_light(color_name = "#FFFFFF", brightness = 0.88, duration = 0.09) # haste bursts — peak
  change_light(color_name = "#AAFE44", brightness = 0.62, duration = 0.18) # vibrant quickening
  change_light(color_name = "#88DD00", brightness = 0.42, duration = 0.40) # sustained haste aura
  change_light(color_name = "#55AA00", brightness = 0.22, duration = 1.50) # aura holds steady

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  ACID SPLASH
#  Voice command (French): "Vitriol"
# ------------------------------------------------------------------------------

#' Acid Splash spell effect
#'
#' A caustic orb of yellow-green acid shatters on impact and splashes
#' corrosive ruin across the target before the fumes fade.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
acid_splash <- function() {
  # ACID SPLASH — Sound
  play_sound(.get_sound_path("acid_splash.wav"))

  # ACID SPLASH — Light
  change_light(color_name = "#AAFB00", brightness = 0.50, duration = 0.07) # orb hurled
  change_light(color_name = "#CCFF33", brightness = 0.82, duration = 0.05) # orb shatters — splash
  change_light(color_name = "#99EE00", brightness = 0.55, duration = 0.09) # acid spreading
  change_light(color_name = "#557700", brightness = 0.22, duration = 0.28) # corrosive settle
  change_light(color_name = "#334400", brightness = 0.07, duration = 0.80) # fumes dissipate

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  HEAT METAL
#  Voice command (French): "Brasier"
# ------------------------------------------------------------------------------

#' Heat Metal spell effect
#'
#' Metal warms from orange to red-hot to blazing orange to white-hot agony,
#' holding in a long sustained sear before cooling.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
heat_metal <- function() {
  # HEAT METAL — Sound
  play_sound(.get_sound_path("heat_metal.wav"))

  # HEAT METAL — Light
  change_light(color_name = "#FF8C00", brightness = 0.22, duration = 0.60) # metal warming slowly
  change_light(color_name = "#FF4500", brightness = 0.42, duration = 0.70) # red-hot glow
  change_light(color_name = "#FF6200", brightness = 0.65, duration = 0.60) # orange-hot intensifying
  change_light(color_name = "#FFAA00", brightness = 0.85, duration = 0.55) # white-hot peak
  change_light(color_name = "#FF5500", brightness = 0.55, duration = 1.20) # searing sustained heat
  change_light(color_name = "#CC3300", brightness = 0.28, duration = 2.00) # red glow holding

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  FAERIE FIRE
#  Voice command (French): "Féerie"
# ------------------------------------------------------------------------------

#' Faerie Fire spell effect
#'
#' Sparks of violet faerie flame ignite and spread to outline every creature
#' in the area in vivid, persistent purple fire.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
faerie_fire <- function() {
  # FAERIE FIRE — Sound
  play_sound(.get_sound_path("faerie_fire.wav"))

  # FAERIE FIRE — Light
  change_light(color_name = "#CC44FF", brightness = 0.30, duration = 0.25) # faerie sparks ignite
  change_light(color_name = "#9900FF", brightness = 0.58, duration = 0.20) # violet fire spreading
  change_light(color_name = "#DD66FF", brightness = 0.80, duration = 0.22) # bright peak — targets outlined
  change_light(color_name = "#AA22EE", brightness = 0.60, duration = 0.30) # fire settling
  change_light(color_name = "#7700CC", brightness = 0.42, duration = 2.00) # faerie fire persists

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  RAY OF FROST
#  Voice command (French): "Verglas"
# ------------------------------------------------------------------------------

#' Ray of Frost spell effect
#'
#' A pale blue ray fires and strikes with cold force, leaving spreading frost
#' and a frozen residual chill.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
ray_of_frost <- function() {
  # RAY OF FROST — Sound
  play_sound(.get_sound_path("ray_of_frost.wav"))

  # RAY OF FROST — Light
  change_light(color_name = "#E0F4FF", brightness = 0.28, duration = 0.14) # cold focusing
  change_light(color_name = "#80CCFF", brightness = 0.78, duration = 0.07) # frost ray fires
  change_light(color_name = "#B0E8FF", brightness = 0.45, duration = 0.14) # cold impact
  change_light(color_name = "#60A8E8", brightness = 0.18, duration = 0.45) # frost spreading
  change_light(color_name = "#3080C0", brightness = 0.07, duration = 0.90) # frozen residue

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  WALL OF FIRE
#  Voice command (French): "Fournaise"
# ------------------------------------------------------------------------------

#' Wall of Fire spell effect
#'
#' Fire erupts from the ground and rises into a roaring wall of orange-red
#' flame — intensely bright and sustained.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
wall_of_fire <- function() {
  # WALL OF FIRE — Sound
  play_sound(.get_sound_path("wall_of_fire.wav"))

  # WALL OF FIRE — Light
  change_light(color_name = "#FF6600", brightness = 0.40, duration = 0.20) # ground igniting
  change_light(color_name = "#FF8C00", brightness = 0.65, duration = 0.25) # wall rising
  change_light(color_name = "#FFAA00", brightness = 0.92, duration = 0.28) # towering inferno — peak
  change_light(color_name = "#FF6600", brightness = 0.82, duration = 0.40) # roaring wall holds
  change_light(color_name = "#FF4400", brightness = 0.72, duration = 3.00) # blazing sustained

  revert_state(duration = 5)
}


# ------------------------------------------------------------------------------
#  FINGER OF DEATH
#  Voice command (French): "Trépas"
# ------------------------------------------------------------------------------

#' Finger of Death spell effect
#'
#' Death energy gathers in darkness, fires as a sickly green beam, and
#' drains life force to nothing — leaving only void.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
finger_of_death <- function() {
  # FINGER OF DEATH — Sound
  play_sound(.get_sound_path("finger_of_death.wav"))

  # FINGER OF DEATH — Light
  change_light(color_name = "#001A00", brightness = 0.04, duration = 0.25) # death energy gathers
  change_light(color_name = "#006600", brightness = 0.38, duration = 0.14) # necrotic beam fires
  change_light(color_name = "#00FF55", brightness = 0.72, duration = 0.09) # death ray peaks
  change_light(color_name = "#003300", brightness = 0.22, duration = 0.18) # life force draining
  change_light(color_name = "#001800", brightness = 0.07, duration = 0.55) # the kill settling
  change_light(color_name = "#000800", brightness = 0.02, duration = 1.50) # void of death

  revert_state(duration = 3)
}


# ------------------------------------------------------------------------------
#  DISINTEGRATE
#  Voice command (French): "Néant"
# ------------------------------------------------------------------------------

#' Disintegrate spell effect
#'
#' A thin green ray charges, fires, and blinds the room as the target is
#' vaporised — particles scatter and nothing remains.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
disintegrate <- function() {
  # DISINTEGRATE — Sound
  play_sound(.get_sound_path("disintegrate.wav"))

  # DISINTEGRATE — Light
  change_light(color_name = "#88FF00", brightness = 0.42, duration = 0.14) # beam charging
  change_light(color_name = "#AAFF22", brightness = 0.85, duration = 0.07) # ray fires
  change_light(color_name = "#FFFFFF", brightness = 0.98, duration = 0.05) # blinding — target vaporising
  change_light(color_name = "#66BB00", brightness = 0.38, duration = 0.14) # particles scattering
  change_light(color_name = "#224400", brightness = 0.09, duration = 0.45) # dust settling
  change_light(color_name = "#080808", brightness = 0.01, duration = 0.30) # nothing left

  revert_state(duration = 2)
}


# ------------------------------------------------------------------------------
#  BLIGHT
#  Voice command (French): "Flétrissure"
# ------------------------------------------------------------------------------

#' Blight spell effect
#'
#' Necrotic energy courses through the target draining all colour and life —
#' warm tones yellowing, browning, and collapsing to withered darkness.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
blight <- function() {
  # BLIGHT — Sound
  play_sound(.get_sound_path("blight.wav"))

  # BLIGHT — Light
  change_light(color_name = "#556B2F", brightness = 0.18, duration = 0.35) # necrotic tendrils reaching
  change_light(color_name = "#8B6914", brightness = 0.28, duration = 0.55) # life draining — yellowing
  change_light(color_name = "#6B4C00", brightness = 0.38, duration = 0.45) # withering begins
  change_light(color_name = "#4A3000", brightness = 0.22, duration = 0.65) # decay deepens
  change_light(color_name = "#2A1800", brightness = 0.07, duration = 1.80) # drained, withered husks

  revert_state(duration = 4)
}


# ------------------------------------------------------------------------------
#  MASS HEALING WORD
#  Voice command (French): "Cantique"
# ------------------------------------------------------------------------------

#' Mass Healing Word spell effect
#'
#' A sacred utterance sends three expanding waves of warm healing green
#' rippling through the whole group, lifting each target in turn.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
mass_healing_word <- function() {
  # MASS HEALING WORD — Sound
  play_sound(.get_sound_path("mass_healing_word.wav"))

  # MASS HEALING WORD — Light
  change_light(color_name = "#E8F5E9", brightness = 0.14, duration = 0.40) # sacred word spoken
  change_light(color_name = "#A5D6A7", brightness = 0.34, duration = 0.45) # first healing ripple
  change_light(color_name = "#66BB6A", brightness = 0.55, duration = 0.38) # second ripple
  change_light(color_name = "#81C784", brightness = 0.72, duration = 0.30) # third — all targets bathed
  change_light(color_name = "#A5D6A7", brightness = 0.48, duration = 0.45) # warmth spreading
  change_light(color_name = "#C8E6C9", brightness = 0.22, duration = 0.70) # healing glow settling
  change_light(color_name = "#E8F5E9", brightness = 0.08, duration = 1.50) # gentle green residue

  revert_state(duration = 4)
}

