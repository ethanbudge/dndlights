"""
Cue definitions for dndlights.

Every scene, spell, and effect is plain data here — no code. Light
``sequence`` entries are ``(color_hex, brightness_0_to_1, duration_seconds)``
steps applied in order; each function's original R implementation played a
sound and stepped through this exact sequence before fading back to the
active scene (see engine.fire_cue). Sequences ported from R timings hit their
"peak" frame at the same offset as the source .wav file's amplitude peak
(noted in each `description`) — keep that in mind if you retime a sound.

`triggers` maps a language code to the spoken phrase that fires the cue by
voice (see dndlights.triggers and dndlights.voice.listener). Every cue also
works as a plain on-screen button or bound hotkey regardless of triggers.

Language codes: en (English), fr (French), la (Latin), ar (Arabic),
zh (Mandarin Chinese). The fr triggers are the originals from the R package,
chosen to be phonetically distinct from ordinary English-language D&D table
chatter. The la/ar/zh triggers are a first-language-pass by the agent that
built this port (not a native speaker of any of the three) — sanity-check
them with a fluent speaker before relying on them at the table. See
HANDOFF.md for the voice-recognition-per-language caveat (Latin has no
offline open-source ASR model, so it is button/hotkey-triggerable only).
"""

from __future__ import annotations

from typing import Optional, TypedDict


class LightStep(TypedDict):
    color: str
    brightness: float
    duration: float


class CueDef(TypedDict, total=False):
    group: str
    description: str
    sound: str
    sequence: list
    revert_duration: float
    triggers: Optional[dict]


class SceneDef(TypedDict, total=False):
    group: str
    description: str
    color: str
    brightness: float
    playlist: str
    transition: float


def _step(color: str, brightness: float, duration: float) -> LightStep:
    return {"color": color, "brightness": brightness, "duration": duration}


# ==============================================================================
# SCENES
# ==============================================================================
# color/brightness set the ambient LIFX state; playlist is a Spotify URI
# (spotify:playlist:<id>) — replace with your own via the settings UI or
# config.json; see HANDOFF.md.

SCENES: dict[str, SceneDef] = {
    "dueling_club": {
        "group": "urban",
        "description": "Abandoned warehouse arena — amber gas-lamp glow.",
        "color": "#C87820", "brightness": 0.30, "transition": 3,
        "playlist": "spotify:playlist:47cMNWd7HteEWNKafIBy5P",
    },
    "noble_house": {
        "group": "urban",
        "description": "Estate office — oil-lamp gold.",
        "color": "#D4961E", "brightness": 0.28, "transition": 3,
        "playlist": "spotify:playlist:7b09RNPhEh3OtBIg0v2FHH",
    },
    "detective_office": {
        "group": "urban",
        "description": "Noir detective's office — single lamp amber.",
        "color": "#E8A000", "brightness": 0.12, "transition": 3,
        "playlist": "spotify:playlist:0iEqFsH5710NeQIsjY6GRV",
    },
    "curio_shop": {
        "group": "urban",
        "description": "Magical antique shop — aged green-gold.",
        "color": "#A8B040", "brightness": 0.30, "transition": 3,
        "playlist": "spotify:playlist:0GkkCFKCZBasPAH3AYbbfX",
    },
    "newspaper": {
        "group": "urban",
        "description": "Newspaper press room — bright work-lamp.",
        "color": "#FFDA80", "brightness": 0.70, "transition": 3,
        "playlist": "spotify:playlist:5iAKfKLlsGyjAfu4ewx7nI",
    },
    "tavern": {
        "group": "urban",
        "description": "Working-class tavern — warm amber.",
        "color": "#CC7820", "brightness": 0.40, "transition": 3,
        "playlist": "spotify:playlist:3fFObop6jjj38jXoUXrUHt",
    },
    "ballroom": {
        "group": "urban",
        "description": "Aristocratic ballroom — golden candlelight.",
        "color": "#E8C030", "brightness": 0.38, "transition": 3,
        "playlist": "spotify:playlist:5nzmZMA0K3U0FIHxw6V70m",
    },
    "ironbottom_riots": {
        "group": "outdoors",
        "description": "Canyon at dawn — desert orange.",
        "color": "#E88C14", "brightness": 0.50, "transition": 3,
        "playlist": "spotify:playlist:6m3PyWHc1K2Et4PWwWqoyy",
    },
    "ironbottom_neutral": {
        "group": "outdoors",
        "description": "Canyon at noon — blinding desert sun.",
        "color": "#FFE060", "brightness": 0.85, "transition": 3,
        "playlist": "spotify:playlist:22d55dZa63IuYnVrohz29R",
    },
    "ironbottom_night": {
        "group": "outdoors",
        "description": "Canyon at night — torch fire.",
        "color": "#B04808", "brightness": 0.18, "transition": 3,
        "playlist": "spotify:playlist:37R2hKuxOd9QzFslqXDXAj",
    },
    "mine": {
        "group": "outdoors",
        "description": "Mine with glowing mushrooms — purple bioluminescence.",
        "color": "#7800CC", "brightness": 0.08, "transition": 3,
        "playlist": "spotify:playlist:2aUhqxrhZfEwDJ4YHALuJo",
    },
    "factory": {
        "group": "outdoors",
        "description": "Molten-metal factory — orange-red.",
        "color": "#E84A00", "brightness": 0.60, "transition": 3,
        "playlist": "spotify:playlist:0gMWkF51N34O3HtDOpuOW5",
    },
    "dream_sequence": {
        "group": "outdoors",
        "description": "Fire, ash, blood-red sun — deep crimson.",
        "color": "#C01800", "brightness": 0.22, "transition": 3,
        "playlist": "spotify:playlist:00XuMs8zOdT1KagPXK1qBg",
    },
    "combat_1": {
        "group": "combat",
        "description": "Ballroom — combat.",
        "color": "#E8C030", "brightness": 0.38, "transition": 3,
        "playlist": "spotify:playlist:4mirB6vFgWAm2JtVt0DvUn",
    },
    "combat_2": {
        "group": "combat",
        "description": "Mine — combat.",
        "color": "#7800CC", "brightness": 0.08, "transition": 3,
        "playlist": "spotify:playlist:0eOHdH2Dp35vccbF2ePfZh",
    },
    "combat_3": {
        "group": "combat",
        "description": "Factory — combat.",
        "color": "#E84A00", "brightness": 0.60, "transition": 3,
        "playlist": "spotify:playlist:2kgWzqO1GBRI35jNBTSbA7",
    },
    "combat_4": {
        "group": "combat",
        "description": "Bridge over canyon at noon.",
        "color": "#FFE060", "brightness": 0.85, "transition": 3,
        "playlist": "spotify:playlist:3f5vznWOHhdP8H6Ib4N8DW",
    },
    "victory": {
        "group": "combat",
        "description": "Canyon bridge — victory.",
        "color": "#FFE060", "brightness": 0.85, "transition": 3,
        "playlist": "spotify:playlist:3YPnzQ6TcXoUAy0G5dCaTX",
    },
    "base_1": {
        "group": "ambient",
        "description": "Neutral outdoor desert — warm afternoon.",
        "color": "#FFB040", "brightness": 0.55, "transition": 3,
        "playlist": "spotify:playlist:5jwMaDX2Uzoq0lCdhiXGJ4",
    },
    "base_2": {
        "group": "ambient",
        "description": "Neutral indoor — warm lamp.",
        "color": "#D49020", "brightness": 0.35, "transition": 3,
        "playlist": "spotify:playlist:5sSlpIe2qBaUzTDDE154Rw",
    },
    "base_3": {
        "group": "ambient",
        "description": "Neutral outdoor desert, alt playlist.",
        "color": "#FFB040", "brightness": 0.55, "transition": 3,
        "playlist": "spotify:playlist:1pP5lXmBbzja8h1Umtlcof",
    },
    "base_4": {
        "group": "ambient",
        "description": "Neutral indoor, alt playlist.",
        "color": "#D49020", "brightness": 0.35, "transition": 3,
        "playlist": "spotify:playlist:0GSqqyr05SnnzCtujMpIgc",
    },
}


# ==============================================================================
# SPELLS
# ==============================================================================

SPELLS: dict[str, CueDef] = {
    "fireball": {
        "group": "offensive",
        "description": "Kindling warmth builds through fire gathering to an EXPLOSION, then rolling fire settles to ember glow. Timed to fireball.wav (peak ~1.76s).",
        "sound": "fireball.wav",
        "revert_duration": 4,
        "sequence": [
            _step("#A04018", 0.35, 0.50), _step("#C8581C", 0.55, 0.40),
            _step("#E07020", 0.75, 0.86), _step("#FDBE49", 0.98, 0.10),
            _step("#FF7A00", 0.82, 0.28), _step("#E84500", 0.58, 0.55),
            _step("#C03A14", 0.30, 1.55),
        ],
        "triggers": {"en": "fireball", "fr": "boule de feu", "la": "ignis globus", "ar": "كرة نار", "zh": "火球"},
    },
    "eldritch_blast": {
        "group": "offensive",
        "description": "Teal charges through near-impact cyan into a bright BEAM, sustains through a second pulse, settles to void. Timed to eldritch_blast.wav (peak ~1.00s).",
        "sound": "eldritch_blast.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#0B4858", 0.25, 0.45), _step("#1A7895", 0.55, 0.30),
            _step("#4AB0CC", 0.75, 0.25), _step("#00E5FF", 0.95, 0.08),
            _step("#2298B0", 0.52, 0.48), _step("#0F4C5C", 0.18, 0.70),
        ],
        "triggers": {"en": "eldritch blast", "fr": "funeste", "la": "tenebrae ictus", "ar": "لعنة الظلام", "zh": "秘咒冲击"},
    },
    "ice_knife": {
        "group": "offensive",
        "description": "Pale blue snaps to a fast icy KNIFE STRIKE, frost spreads into lingering chill. Timed to ice_knife.wav (peak ~0.14s).",
        "sound": "ice_knife.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#A8D4EC", 0.50, 0.14), _step("#5BB8E8", 0.95, 0.08),
            _step("#90C8E8", 0.45, 0.28), _step("#80B0D0", 0.16, 0.55),
        ],
        "triggers": {"en": "ice knife", "fr": "givre", "la": "gelu culter", "ar": "سكين الجليد", "zh": "冰刃"},
    },
    "lightning_bolt": {
        "group": "offensive",
        "description": "Pale near-white charges to a single near-white LIGHTNING STRIKE, fades through pale blue. Timed to lightning_bolt.wav (peak ~0.62s).",
        "sound": "lightning_bolt.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#DCE8FF", 0.38, 0.32), _step("#EEF4FF", 0.70, 0.22),
            _step("#FFF8C8", 1.00, 0.08), _step("#DCE8FF", 0.45, 0.30),
            _step("#C8D8F0", 0.12, 0.90),
        ],
        "triggers": {"en": "lightning bolt", "fr": "foudre", "la": "fulmen", "ar": "صاعقة", "zh": "闪电束"},
    },
    "firebolt": {
        "group": "offensive",
        "description": "Muted orange gathers, the BOLT FIRES bright orange, smooths through amber to a quick ember. Timed to firebolt.wav (peak ~0.34s).",
        "sound": "firebolt.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#C06018", 0.52, 0.34), _step("#FF7A00", 0.95, 0.08),
            _step("#D05800", 0.48, 0.30), _step("#5A1A00", 0.10, 0.70),
        ],
        "triggers": {"en": "firebolt", "fr": "étincelle", "la": "scintilla", "ar": "شرارة نارية", "zh": "火星弹"},
    },
    "magic_missile": {
        "group": "offensive",
        "description": "Silent void, faint gathering, then two bright-white DART impacts 160ms apart, cool white afterglow. Timed to magic_missile.wav (darts at 1.46s/1.62s).",
        "sound": "magic_missile.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#303040", 0.10, 0.50), _step("#B0B0C0", 0.35, 0.50),
            _step("#D0D0E0", 0.60, 0.46), _step("#FFFFFF", 0.98, 0.08),
            _step("#E8E8F8", 0.80, 0.20), _step("#A0A0B8", 0.28, 0.55),
            _step("#606078", 0.08, 0.75),
        ],
        "triggers": {"en": "magic missile", "fr": "carreau", "la": "missile magicum", "ar": "سهم سحري", "zh": "魔法飞弹"},
    },
    "acid_splash": {
        "group": "offensive",
        "description": "Muted yellow-green builds to a vivid SPLASH peak, spreads and corrodes into dark fumes. Timed to acid_splash.wav (peak ~0.86s).",
        "sound": "acid_splash.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#88AA20", 0.32, 0.30), _step("#AABB30", 0.58, 0.30),
            _step("#BBDD30", 0.78, 0.26), _step("#CCFF33", 0.92, 0.08),
            _step("#668800", 0.35, 0.40), _step("#334400", 0.10, 0.65),
        ],
        "triggers": {"en": "acid splash", "fr": "acerbe", "la": "acidum", "ar": "رذاذ حمضي", "zh": "酸液飞溅"},
    },
    "ray_of_frost": {
        "group": "offensive",
        "description": "Long pale focus builds, the RAY FIRES bright blue, frost spreads down through deeper blues. Timed to ray_of_frost.wav (peak ~1.32s).",
        "sound": "ray_of_frost.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#D8E8F8", 0.22, 0.50), _step("#B0D8F0", 0.42, 0.50),
            _step("#88C8E8", 0.65, 0.32), _step("#80CCFF", 0.92, 0.08),
            _step("#60A8E8", 0.30, 0.48), _step("#3080C0", 0.10, 0.65),
        ],
        "triggers": {"en": "ray of frost", "fr": "verglas", "la": "radius gelidus", "ar": "شعاع الصقيع", "zh": "冰霜射线"},
    },
    "booming_blade": {
        "group": "offensive",
        "description": "Electric-blue charge gathers, connects in a sharp white-blue BOOM, thunder rolls through diminishing pulses. Timed to booming_blade.wav (peak ~0.26s).",
        "sound": "booming_blade.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#4488DD", 0.45, 0.26), _step("#E8F4FF", 0.98, 0.08),
            _step("#4488DD", 0.52, 0.30), _step("#0A2860", 0.14, 0.55),
        ],
        "triggers": {"en": "booming blade", "fr": "grondement", "la": "gladius tonans", "ar": "نصل الرعد", "zh": "轰鸣剑"},
    },
    "water_whip": {
        "group": "elemental",
        "description": "Muted aqua coils as the whip winds, snaps in a bright aquamarine CRACK, rolls down through deep ocean blue. Timed to water_whip.wav (peak ~0.94s).",
        "sound": "water_whip.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#6CC8E0", 0.30, 0.30), _step("#48BAD8", 0.55, 0.30),
            _step("#38B8DC", 0.75, 0.34), _step("#48CAE4", 0.95, 0.08),
            _step("#0096C7", 0.45, 0.40), _step("#023E8A", 0.16, 0.75),
        ],
        "triggers": {"en": "water whip", "fr": "fouet", "la": "flagellum aquae", "ar": "سوط الماء", "zh": "水鞭"},
    },
    "heat_metal": {
        "group": "elemental",
        "description": "Cold metallic grey warms through copper to WHITE-HOT, surges again, cools to a long red glow. Timed to heat_metal.wav (peak ~1.20s, surge ~2.02s).",
        "sound": "heat_metal.wav",
        "revert_duration": 4,
        "sequence": [
            _step("#6080A0", 0.18, 0.45), _step("#A88060", 0.32, 0.40),
            _step("#D06820", 0.50, 0.35), _step("#FFAA00", 0.88, 0.10),
            _step("#FF8500", 0.72, 0.22), _step("#FF5500", 0.55, 0.50),
            _step("#FF6800", 0.78, 0.30), _step("#CC3300", 0.50, 0.30),
            _step("#881800", 0.20, 1.00),
        ],
        "triggers": {"en": "heat metal", "fr": "brasier", "la": "ferrum ardens", "ar": "تسخين المعدن", "zh": "灼热金属"},
    },
    "wall_of_fire": {
        "group": "elemental",
        "description": "Embers stir, the wall ignites and rises to a towering near-white peak, roars, slowly dies down. Timed to wall_of_fire.wav (peak ~2.76s).",
        "sound": "wall_of_fire.wav",
        "revert_duration": 5,
        "sequence": [
            _step("#5A1800", 0.18, 0.50), _step("#B04000", 0.40, 0.60),
            _step("#E07020", 0.62, 0.60), _step("#FF8500", 0.78, 0.60),
            _step("#FF7000", 0.88, 0.46), _step("#FFAA00", 0.96, 0.10),
            _step("#FF7000", 0.85, 0.50), _step("#FF5500", 0.70, 0.80),
            _step("#E04000", 0.48, 1.40), _step("#A02000", 0.22, 1.30),
        ],
        "triggers": {"en": "wall of fire", "fr": "fournaise", "la": "murus ignis", "ar": "جدار النار", "zh": "火墙"},
    },
    "faerie_fire": {
        "group": "elemental",
        "description": "Vivid violet sparks spread to outline targets in a bright flash, persists in a slow vibrant glow. Timed to faerie_fire.wav (peak ~1.00s).",
        "sound": "faerie_fire.wav",
        "revert_duration": 4,
        "sequence": [
            _step("#B048DC", 0.42, 0.40), _step("#C040FF", 0.65, 0.34),
            _step("#D870FF", 0.85, 0.26), _step("#E888FF", 0.95, 0.10),
            _step("#C040FF", 0.82, 0.20), _step("#A828EE", 0.65, 0.30),
            _step("#8020D0", 0.45, 0.60), _step("#5818A0", 0.20, 1.00),
        ],
        "triggers": {"en": "faerie fire", "fr": "féerie", "la": "ignis fatuus", "ar": "نار الجن", "zh": "妖精之火"},
    },
    "blight": {
        "group": "necrotic",
        "description": "Necrotic tendrils strike almost immediately in olive-yellow, life drains through withered darkness. Timed to blight.wav (peak ~0.10s).",
        "sound": "blight.wav",
        "revert_duration": 4,
        "sequence": [
            _step("#7A6010", 0.40, 0.06), _step("#A88018", 0.58, 0.08),
            _step("#5A3800", 0.32, 0.45), _step("#2A1800", 0.14, 0.90),
            _step("#1A0F00", 0.05, 1.60),
        ],
        "triggers": {"en": "blight", "fr": "flétrissure", "la": "corruptio", "ar": "تعفن", "zh": "枯萎术"},
    },
    "finger_of_death": {
        "group": "necrotic",
        "description": "Necrotic green charges, IMPACT whitens to brilliant green, life drains back into void. Timed to finger_of_death.wav (peak ~0.76s, decay to 2.58s).",
        "sound": "finger_of_death.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#003A14", 0.18, 0.20), _step("#006028", 0.38, 0.30),
            _step("#00903C", 0.62, 0.26), _step("#C8FFD8", 0.95, 0.10),
            _step("#00B040", 0.62, 0.20), _step("#006028", 0.40, 0.30),
            _step("#003020", 0.22, 0.40), _step("#001810", 0.10, 0.50),
            _step("#000800", 0.04, 0.60),
        ],
        "triggers": {"en": "finger of death", "fr": "trépas", "la": "digitus mortis", "ar": "إصبع الموت", "zh": "死亡之指"},
    },
    "disintegrate": {
        "group": "necrotic",
        "description": "Muted orange charges hotter, peaks in a searing near-white DISINTEGRATION flare, matter crumbles to ash and smoke. Timed to disintegrate.wav (peak ~2.52s).",
        "sound": "disintegrate.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#803000", 0.22, 0.60), _step("#C04800", 0.45, 0.65),
            _step("#F06400", 0.65, 0.65), _step("#FF7800", 0.82, 0.62),
            _step("#FFAA40", 0.98, 0.10), _step("#FF8C00", 0.82, 0.20),
            _step("#C86820", 0.60, 0.22), _step("#7A6050", 0.38, 0.30),
            _step("#4A4845", 0.18, 0.40), _step("#2A2825", 0.06, 0.80),
        ],
        "triggers": {"en": "disintegrate", "fr": "néant", "la": "dissolutio", "ar": "تحلل", "zh": "解离术"},
    },
    "cure_wounds": {
        "group": "healing",
        "description": "Slow warm golden bloom: pale gold whispers, brightens, peaks gently, breathes out. Timed to cure_wounds.wav (peak ~0.88s).",
        "sound": "cure_wounds.wav",
        "revert_duration": 4,
        "sequence": [
            _step("#FFF0D0", 0.20, 0.30), _step("#FFE9A8", 0.40, 0.30),
            _step("#FFE08A", 0.65, 0.28), _step("#FFE08A", 0.90, 0.10),
            _step("#FFD46A", 0.72, 0.30), _step("#FFE9A8", 0.50, 0.40),
            _step("#FFF1C8", 0.28, 0.70), _step("#F0D098", 0.12, 1.00),
        ],
        "triggers": {"en": "cure wounds", "fr": "guérison", "la": "sanatio", "ar": "شفاء", "zh": "治疗术"},
    },
    "mass_healing_word": {
        "group": "healing",
        "description": "A stronger, longer cure_wounds — three golden waves peak in a bright burst, breathe out through a long pale residue. Timed to mass_healing_word.wav (peak ~1.34s).",
        "sound": "mass_healing_word.wav",
        "revert_duration": 4,
        "sequence": [
            _step("#FFF1C8", 0.22, 0.40), _step("#FFE9A8", 0.42, 0.30),
            _step("#FFD46A", 0.62, 0.34), _step("#FFC640", 0.78, 0.30),
            _step("#FFE680", 0.95, 0.10), _step("#FFD46A", 0.78, 0.30),
            _step("#FFE9A8", 0.55, 0.60), _step("#FFF1C8", 0.35, 1.00),
            _step("#FFE8A8", 0.15, 2.50),
        ],
        "triggers": {"en": "mass healing word", "fr": "cantique", "la": "canticum salutis", "ar": "ترنيمة الشفاء", "zh": "集体治愈"},
    },
    "haste": {
        "group": "healing",
        "description": "Warm gold accelerates — pale cream brightens to a bright BURST, sustains through speed-pulses, breathes to a long aura. Timed to haste.wav (peak ~1.36s).",
        "sound": "haste.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#FFE8A0", 0.30, 0.40), _step("#FFDA80", 0.52, 0.50),
            _step("#FFD040", 0.72, 0.46), _step("#FFE680", 0.94, 0.10),
            _step("#FFD040", 0.78, 0.20), _step("#E8B020", 0.55, 0.30),
            _step("#C89010", 0.32, 0.50), _step("#8E6010", 0.15, 1.00),
        ],
        "triggers": {"en": "haste", "fr": "véloce", "la": "celeritas", "ar": "سرعة", "zh": "加速术"},
    },
    "light": {
        "group": "healing",
        "description": "A mote kindles from pale gold, rises to FULL LIGHT, sustains through pulses, slowly fades. Timed to light.wav (peak ~1.02s).",
        "sound": "light.wav",
        "revert_duration": 4,
        "sequence": [
            _step("#FFF8E0", 0.18, 0.40), _step("#FFFCEA", 0.40, 0.36),
            _step("#FFFFFA", 0.65, 0.26), _step("#FFFFFF", 0.88, 0.10),
            _step("#FFFFF8", 0.78, 0.28), _step("#FFF8D6", 0.55, 0.40),
            _step("#FFE8A8", 0.20, 1.20),
        ],
        "triggers": {"en": "light", "fr": "lueur", "la": "lux", "ar": "ضياء", "zh": "光亮术"},
    },
    "shield": {
        "group": "defense",
        "description": "Gold rises to a BARRIER PEAK, shimmer settles, fades to a steady warm hold. Timed to shield.wav (peak ~0.50s).",
        "sound": "shield.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#FFE680", 0.60, 0.50), _step("#FFE680", 0.92, 0.08),
            _step("#FFF1B0", 0.65, 0.35), _step("#E8B040", 0.22, 1.00),
        ],
        "triggers": {"en": "shield", "fr": "bouclier", "la": "scutum", "ar": "درع", "zh": "护盾术"},
    },
    "mage_armor": {
        "group": "defense",
        "description": "Long shimmer braids light blue with gold trim, peaks in a WARD SEALS flash, settles to a steady ward. Timed to mage_armor.wav (peak ~2.10s).",
        "sound": "mage_armor.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#B8D8E8", 0.20, 0.50), _step("#C0D8E0", 0.36, 0.50),
            _step("#D8D8C0", 0.52, 0.50), _step("#E8E0B0", 0.68, 0.60),
            _step("#F8E8A8", 0.88, 0.30), _step("#C8D8D0", 0.55, 0.20),
            _step("#90B8D8", 0.32, 0.50), _step("#6890B8", 0.15, 1.20),
        ],
        "triggers": {"en": "mage armor", "fr": "égide", "la": "aegis magica", "ar": "درع الساحر", "zh": "法师护甲"},
    },
    "private_sanctum": {
        "group": "defense",
        "description": "Muted purple wards stir, spread outward, peak as SANCTUM SEALED, pulse, settle to a low purple hold. Timed to private_sanctum.wav (peak ~1.48s).",
        "sound": "private_sanctum.wav",
        "revert_duration": 5,
        "sequence": [
            _step("#B898C8", 0.18, 0.45), _step("#A878C0", 0.32, 0.45),
            _step("#9460B8", 0.48, 0.34), _step("#8050B0", 0.62, 0.24),
            _step("#B070E0", 0.88, 0.10), _step("#7B68EE", 0.68, 0.30),
            _step("#6B4A98", 0.42, 0.30), _step("#4A2A78", 0.25, 0.80),
            _step("#28184A", 0.10, 1.60),
        ],
        "triggers": {"en": "private sanctum", "fr": "citadelle", "la": "sanctuarium", "ar": "الحرم الخاص", "zh": "秘密圣所"},
    },
    "prestidigitation": {
        "group": "utility",
        "description": "Subtle whimsical lavender shimmer rises softly, breathes through pale pink-mauve, fades gently. Timed to prestidigitation.wav (peak ~0.96s, gentle).",
        "sound": "prestidigitation.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#F0E0F0", 0.18, 0.42), _step("#E0CCEC", 0.30, 0.30),
            _step("#D8C0E8", 0.42, 0.24), _step("#DCC8E5", 0.32, 0.30),
            _step("#C8B0D0", 0.18, 0.45), _step("#A89AB8", 0.08, 0.80),
        ],
        "triggers": {"en": "prestidigitation", "fr": "sortilège", "la": "praestigium", "ar": "خفة اليد", "zh": "戏法"},
    },
    "disguise_self": {
        "group": "utility",
        "description": "Light blue shimmer weaves with violet, peaks as ILLUSION SETTLES, holds in a slow blue-violet fade. Timed to disguise_self.wav (peak ~1.78s).",
        "sound": "disguise_self.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#B8D0E8", 0.25, 0.45), _step("#A8B8D8", 0.38, 0.40),
            _step("#9888C8", 0.52, 0.40), _step("#8070C0", 0.65, 0.53),
            _step("#B898E8", 0.88, 0.18), _step("#9080D0", 0.48, 0.28),
            _step("#888098", 0.12, 1.20),
        ],
        "triggers": {"en": "disguise self", "fr": "frimousse", "la": "dissimulatio", "ar": "تنكر", "zh": "变装术"},
    },
    "misty_step": {
        "group": "utility",
        "description": "Silver mist rises, caster fades to near-dark vanish, soft teal flash REAPPEARS, mist dissipates. Timed to misty_step.wav (peak ~0.78s).",
        "sound": "misty_step.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#E0F7FA", 0.28, 0.32), _step("#6088A0", 0.12, 0.46),
            _step("#C0E8F0", 0.72, 0.08), _step("#80DEEA", 0.35, 0.32),
            _step("#2080A0", 0.08, 0.72),
        ],
        "triggers": {"en": "misty step", "fr": "brume", "la": "gradus nebulae", "ar": "خطوة الضباب", "zh": "雾步术"},
    },
}


# ==============================================================================
# EFFECTS
# ==============================================================================

EFFECTS: dict[str, CueDef] = {
    # -- PC combat (voice triggers) ------------------------------------------
    "arcane_shot": {
        "group": "pc_combat",
        "description": "An arcane rifle firing. Muted red charges, MUZZLE FLASH, slug trails through smoke. Timed to arcane_shot.wav (peak ~1.28s).",
        "sound": "arcane_shot.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#5C0808", 0.22, 0.40), _step("#903030", 0.45, 0.50),
            _step("#C04040", 0.68, 0.38), _step("#FFE0E0", 0.98, 0.08),
            _step("#900808", 0.40, 0.40), _step("#400404", 0.10, 0.60),
        ],
        "triggers": {"en": "arcane shot", "fr": "décharge", "la": "iactus arcanus", "ar": "طلقة سحرية", "zh": "秘法射击"},
    },
    "wild_shape": {
        "group": "pc_combat",
        "description": "Druidic transformation into a beast. Forest green surges toward a vivid TRANSFORMATION flash, settles into primal darkness. Timed to wild_shape.wav (peak ~1.78s).",
        "sound": "wild_shape.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#2A4A20", 0.22, 0.45), _step("#387028", 0.42, 0.40),
            _step("#44A038", 0.62, 0.40), _step("#66CC44", 0.78, 0.53),
            _step("#98FF50", 0.95, 0.18), _step("#226622", 0.38, 0.28),
            _step("#112211", 0.10, 1.20),
        ],
        "triggers": {"en": "wild shape", "fr": "sauvagine", "la": "forma fera", "ar": "تحول وحشي", "zh": "野性变形"},
    },
    "bludgeon": {
        "group": "pc_combat",
        "description": "Bludgeoning impact frame. Grey anticipation rises to a RED IMPACT flash, clean fadeout. Timed to bludgeon.wav (peak ~1.08s).",
        "sound": "bludgeon.wav",
        "revert_duration": 1,
        "sequence": [
            _step("#6A6A6A", 0.25, 0.40), _step("#A8A8A8", 0.50, 0.30),
            _step("#C0C0C0", 0.72, 0.38), _step("#FF0033", 0.95, 0.08),
            _step("#888888", 0.38, 0.36), _step("#383838", 0.10, 0.50),
        ],
        "triggers": {"en": "bludgeon", "fr": "boutez", "la": "contusio", "ar": "ضربة راضّة", "zh": "钝击"},
    },
    "slash": {
        "group": "pc_combat",
        "description": "Slashing impact frame. Near-instant STEEL FLASH into a RED SLASH, fast fade. Timed to slash.wav (peak ~0.06s).",
        "sound": "slash.wav",
        "revert_duration": 1,
        "sequence": [
            _step("#888888", 0.40, 0.04), _step("#FFFFFF", 0.95, 0.06),
            _step("#FF0033", 0.90, 0.08), _step("#888888", 0.28, 0.22),
            _step("#383838", 0.08, 0.45),
        ],
        "triggers": {"en": "slash", "fr": "taillade", "la": "incisio", "ar": "شق", "zh": "斩击"},
    },
    "pierce": {
        "group": "pc_combat",
        "description": "Piercing impact frame. Grey anticipation rises to a white POINT FLASH then RED THRUST, tight fadeout. Timed to pierce.wav (peak ~1.14s).",
        "sound": "pierce.wav",
        "revert_duration": 1,
        "sequence": [
            _step("#6A6A6A", 0.25, 0.40), _step("#A0A0A0", 0.55, 0.40),
            _step("#D0D0D0", 0.75, 0.34), _step("#FFFFFF", 0.92, 0.08),
            _step("#FF0033", 0.98, 0.08), _step("#888888", 0.28, 0.30),
            _step("#383838", 0.08, 0.45),
        ],
        "triggers": {"en": "pierce", "fr": "estoc", "la": "punctio", "ar": "طعن", "zh": "刺击"},
    },
    # -- Creatures (no voice triggers -- bind to hotkeys) --------------------
    "spider_bite": {
        "group": "creatures",
        "description": "A spider bite and cry. Dark green shadow snaps to a VENOM PEAK, creeps down into paralysis. Timed to spider_bite.wav (peak ~0.30s).",
        "sound": "spider_bite.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#226A18", 0.32, 0.30), _step("#44FF00", 0.85, 0.08),
            _step("#114400", 0.22, 0.42), _step("#081A00", 0.06, 0.55),
        ],
        "triggers": None,
    },
    "worm_surge": {
        "group": "creatures",
        "description": "A giant worm erupting from the ground. Brown rumble builds to a PURPLE ERUPTION, writhes, late surge, settles. Timed to worm_surge.wav (peak ~1.70s, late surge ~3.84s).",
        "sound": "worm_surge.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#2A1800", 0.15, 0.40), _step("#5C3D20", 0.32, 0.45),
            _step("#7A4A28", 0.55, 0.45), _step("#8B5828", 0.68, 0.40),
            _step("#6A3878", 0.82, 0.10), _step("#7A4A28", 0.62, 0.20),
            _step("#5C3018", 0.42, 0.30), _step("#3A2010", 0.20, 1.54),
            _step("#5A3020", 0.45, 0.30), _step("#3A2010", 0.20, 0.40),
            _step("#1F1008", 0.06, 0.50),
        ],
        "triggers": None,
    },
    "crystal_breath": {
        "group": "creatures",
        "description": "Dragon crystal breath weapon. Pale crystals charge to a near-white BARRAGE PEAK, shards settle through cooler blues. Timed to crystal_breath.wav (peak ~0.40s).",
        "sound": "crystal_breath.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#88CCEE", 0.52, 0.40), _step("#EEFFFF", 0.98, 0.08),
            _step("#66B8E8", 0.52, 0.32), _step("#2266AA", 0.20, 0.50),
            _step("#224466", 0.06, 0.90),
        ],
        "triggers": None,
    },
    "dragon_bite": {
        "group": "creatures",
        "description": "The bite of a dragon. Jaws descend almost instantly to a RED BITE, wound deepens into pain. Timed to dragon_bite.wav (peak ~0.06s).",
        "sound": "dragon_bite.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#2A0808", 0.20, 0.04), _step("#CC3300", 0.88, 0.06),
            _step("#550000", 0.28, 0.30), _step("#1A0000", 0.06, 0.65),
        ],
        "triggers": None,
    },
    # -- Magical & environmental (no voice triggers) -------------------------
    "hammer_slam": {
        "group": "magical",
        "description": "Magical electric-blue hammer impact. Charge builds to a near-white SLAM, shockwave fades into grounded silence. Timed to hammer_slam.wav (peak ~1.26s).",
        "sound": "hammer_slam.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#2A488A", 0.22, 0.40), _step("#4488FF", 0.50, 0.40),
            _step("#88BBFF", 0.72, 0.46), _step("#DDEEFF", 0.98, 0.08),
            _step("#2266FF", 0.52, 0.36), _step("#001888", 0.18, 0.55),
            _step("#000A40", 0.06, 0.50),
        ],
        "triggers": None,
    },
    "arcane_surge": {
        "group": "magical",
        "description": "Massive release of metallic arcane energy. Long buildup through silver and gold to a BLINDING BURST, shockwave dissipates into deep silence. Timed to arcane_surge.wav (peak ~4.26s).",
        "sound": "arcane_surge.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#4A4A50", 0.18, 0.80), _step("#8A8A8A", 0.35, 1.00),
            _step("#C0C0C0", 0.55, 1.00), _step("#E8D080", 0.70, 0.90),
            _step("#F8E090", 0.85, 0.56), _step("#FFFFFF", 0.98, 0.10),
            _step("#E8D080", 0.75, 0.20), _step("#A09050", 0.50, 0.30),
            _step("#705030", 0.22, 0.50), _step("#3A2810", 0.08, 1.20),
        ],
        "triggers": None,
    },
    "ignite": {
        "group": "magical",
        "description": "A burst of flame as something small combusts. Near-instant spark snaps into a hot-orange BURST, smoulders to a quick ember. Timed to ignite.wav (peak ~0.04s).",
        "sound": "ignite.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#FF6600", 0.55, 0.04), _step("#FFAA00", 0.92, 0.08),
            _step("#CC4400", 0.35, 0.32), _step("#5A1000", 0.06, 0.55),
        ],
        "triggers": None,
    },
    "gust": {
        "group": "magical",
        "description": "A rush of wind. Very long pale wind buildup to a bright RUSH PEAK, streams away through cooler blues. Timed to gust.wav (peak ~4.80s).",
        "sound": "gust.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#C0D8F0", 0.25, 1.20), _step("#D8E8F8", 0.45, 1.20),
            _step("#EEF4FF", 0.62, 1.20), _step("#F8FCFF", 0.80, 1.20),
            _step("#FFFFFF", 0.92, 0.10), _step("#DDEEFF", 0.65, 0.30),
            _step("#BBDDFF", 0.38, 0.40), _step("#88AADD", 0.15, 0.80),
        ],
        "triggers": None,
    },
    "sand_blast": {
        "group": "magical",
        "description": "A blast of sand. Amber sand swirls, fires in a stinging gold BLAST PEAK, cloud settles into drifting dust. Timed to sand_blast.wav (peak ~0.42s).",
        "sound": "sand_blast.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#886020", 0.32, 0.22), _step("#C08840", 0.65, 0.20),
            _step("#FFD080", 0.92, 0.08), _step("#A07030", 0.38, 0.32),
            _step("#704A1A", 0.10, 0.60),
        ],
        "triggers": None,
    },
    "steam_blast": {
        "group": "magical",
        "description": "A pressurised steam blast. Pale grey vent bursts to a brilliant WHITE BURST, billows into drifting wisps. Timed to steam_blast.wav (peak ~0.24s).",
        "sound": "steam_blast.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#D8D8D8", 0.52, 0.24), _step("#FFFFFF", 0.95, 0.08),
            _step("#F0F0F0", 0.60, 0.30), _step("#C8C8C8", 0.26, 0.55),
            _step("#A0A0A0", 0.08, 0.90),
        ],
        "triggers": None,
    },
    "spore_burst": {
        "group": "magical",
        "description": "Release of bright spores. Dark green sac shifts through muted purple to a light-purple PURPLE BURST, settles into deep green stillness. Timed to spore_burst.wav (peak ~1.00s).",
        "sound": "spore_burst.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#224028", 0.22, 0.30), _step("#5C4040", 0.42, 0.32),
            _step("#8870A8", 0.65, 0.38), _step("#D8A8FF", 0.92, 0.10),
            _step("#A878D0", 0.65, 0.20), _step("#786088", 0.42, 0.40),
            _step("#4A5030", 0.25, 0.50), _step("#1F3015", 0.08, 0.80),
        ],
        "triggers": None,
    },
    "flask_shatter": {
        "group": "magical",
        "description": "An alchemical flask shattering. Near-instant olive-green shatter to a yellow-green REACTION PEAK, fumes settle into dark haze. Timed to flask_shatter.wav (peak ~0.10s).",
        "sound": "flask_shatter.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#88AA20", 0.48, 0.04), _step("#CCFF66", 0.92, 0.08),
            _step("#88DD00", 0.45, 0.28), _step("#446600", 0.20, 0.50),
            _step("#223300", 0.06, 0.65),
        ],
        "triggers": None,
    },
    # -- Universal / narrative (new, not D&D-spell-specific) -----------------
    "critical_hit": {
        "group": "narrative",
        "description": "A natural 20 lands. Quick anticipation snaps to a blinding golden PEAK, settles triumphantly.",
        "sound": "critical_hit.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#FFD700", 0.40, 0.15), _step("#FFFFFF", 1.00, 0.10),
            _step("#FFD700", 0.70, 0.30), _step("#FFA500", 0.30, 0.60),
        ],
        "triggers": {"en": "critical hit", "fr": "coup critique", "la": "ictus praecipuus", "ar": "ضربة حاسمة", "zh": "会心一击"},
    },
    "critical_fail": {
        "group": "narrative",
        "description": "A natural 1. A dull grey-red flicker sputters and drops away — an anticlimax, not a flash.",
        "sound": "critical_fail.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#886060", 0.30, 0.20), _step("#553030", 0.15, 0.40),
            _step("#301010", 0.05, 0.80),
        ],
        "triggers": {"en": "critical fail", "fr": "échec critique", "la": "casus pessimus", "ar": "فشل ذريع", "zh": "大失败"},
    },
    "level_up": {
        "group": "narrative",
        "description": "A character levels up. A slow warm gold build with two ascending pulses, settling into a proud glow.",
        "sound": "level_up.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#FFE8A0", 0.30, 0.40), _step("#FFD040", 0.65, 0.35),
            _step("#FFFFFF", 0.95, 0.12), _step("#FFD700", 0.75, 0.40),
            _step("#FFB020", 0.35, 0.80),
        ],
        "triggers": {"en": "level up", "fr": "montée de niveau", "la": "gradus ascensus", "ar": "ترقية المستوى", "zh": "升级"},
    },
    "long_rest": {
        "group": "narrative",
        "description": "The party takes a long rest. A very slow fade to a calm, dim, restful blue — no peak at all.",
        "sound": "long_rest.wav",
        "revert_duration": 6,
        "sequence": [
            _step("#405070", 0.20, 2.00), _step("#304060", 0.12, 2.00),
            _step("#203050", 0.06, 2.00),
        ],
        "triggers": {"en": "long rest", "fr": "repos long", "la": "quies longa", "ar": "راحة طويلة", "zh": "长休"},
    },
    "short_rest": {
        "group": "narrative",
        "description": "The party takes a short rest. A brief calm fade to dim warm neutral.",
        "sound": "short_rest.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#605040", 0.22, 1.00), _step("#403020", 0.10, 1.20),
        ],
        "triggers": {"en": "short rest", "fr": "repos court", "la": "quies brevis", "ar": "راحة قصيرة", "zh": "短休"},
    },
    "boss_intro": {
        "group": "narrative",
        "description": "The boss reveals itself. A long ominous crimson build through deepening red to a searing peak, holds menacingly.",
        "sound": "boss_intro.wav",
        "revert_duration": 4,
        "sequence": [
            _step("#400000", 0.20, 0.80), _step("#700000", 0.35, 0.80),
            _step("#A00000", 0.55, 0.70), _step("#FF0000", 0.85, 0.50),
            _step("#FF2020", 0.98, 0.15), _step("#900000", 0.60, 1.00),
        ],
        "triggers": {"en": "boss intro", "fr": "entrée du boss", "la": "adventus tyranni", "ar": "ظهور الزعيم", "zh": "首领登场"},
    },
    "treasure_found": {
        "group": "narrative",
        "description": "The party finds treasure. A bright, sparkling gold shimmer with a quick joyful peak.",
        "sound": "treasure_found.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#FFE080", 0.35, 0.25), _step("#FFD700", 0.75, 0.20),
            _step("#FFFFE0", 0.95, 0.10), _step("#FFD700", 0.50, 0.50),
        ],
        "triggers": {"en": "treasure found", "fr": "trésor trouvé", "la": "thesaurus inventus", "ar": "اكتشاف كنز", "zh": "发现宝藏"},
    },
    "puzzle_solved": {
        "group": "narrative",
        "description": "A puzzle clicks into place. A gentle blue-green resolve, calm and satisfying.",
        "sound": "puzzle_solved.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#60D0C0", 0.30, 0.30), _step("#A0F0E0", 0.70, 0.25),
            _step("#60D0C0", 0.40, 0.60),
        ],
        "triggers": {"en": "puzzle solved", "fr": "énigme résolue", "la": "aenigma solutum", "ar": "حل اللغز", "zh": "解开谜题"},
    },
    "death_save_fail": {
        "group": "narrative",
        "description": "A failed death saving throw. Lights dim ominously toward near-darkness.",
        "sound": "death_save_fail.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#402020", 0.20, 0.60), _step("#200000", 0.08, 1.20),
            _step("#100000", 0.03, 1.00),
        ],
        "triggers": {"en": "death save fail", "fr": "échec du jet de mort", "la": "casus mortis", "ar": "فشل رمية الموت", "zh": "死亡豁免失败"},
    },
    "death_save_success": {
        "group": "narrative",
        "description": "A successful death saving throw. A small warm pulse of relief.",
        "sound": "death_save_success.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#FFE0C0", 0.30, 0.30), _step("#FFF0E0", 0.55, 0.30),
            _step("#FFD0A0", 0.25, 0.60),
        ],
        "triggers": {"en": "death save success", "fr": "réussite du jet de mort", "la": "salus mortis", "ar": "نجاح رمية الموت", "zh": "死亡豁免成功"},
    },
    "stealth_success": {
        "group": "narrative",
        "description": "A stealth check succeeds. Lights dim subtly to a low cool hush.",
        "sound": "stealth_success.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#304050", 0.15, 0.50), _step("#203040", 0.06, 0.80),
        ],
        "triggers": {"en": "stealth success", "fr": "discrétion réussie", "la": "occultatio felix", "ar": "تخفٍ ناجح", "zh": "潜行成功"},
    },
    "stealth_fail": {
        "group": "narrative",
        "description": "A stealth check fails — you're spotted. A sudden bright white alert flash.",
        "sound": "stealth_fail.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#FFFFFF", 0.95, 0.08), _step("#FF6060", 0.55, 0.30),
            _step("#803030", 0.20, 0.50),
        ],
        "triggers": {"en": "stealth fail", "fr": "discrétion échouée", "la": "occultatio irrita", "ar": "فشل التخفي", "zh": "潜行失败"},
    },
    "trap_triggered": {
        "group": "narrative",
        "description": "A trap springs. A sudden sharp red alarm flash, then a wary settle.",
        "sound": "trap_triggered.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#FF0000", 0.90, 0.06), _step("#800000", 0.40, 0.30),
            _step("#400000", 0.15, 0.60),
        ],
        "triggers": {"en": "trap triggered", "fr": "piège déclenché", "la": "laqueus tactus", "ar": "تفعيل الفخ", "zh": "陷阱触发"},
    },
    "ambush": {
        "group": "narrative",
        "description": "An ambush breaks out. One hard bright red flash to snap attention, then combat-ready red hold.",
        "sound": "ambush.wav",
        "revert_duration": 1,
        "sequence": [
            _step("#FF2020", 0.95, 0.10), _step("#C00000", 0.55, 0.40),
        ],
        "triggers": {"en": "ambush", "fr": "embuscade", "la": "insidiae", "ar": "كمين", "zh": "伏击"},
    },
    "curse_effect": {
        "group": "narrative",
        "description": "A curse takes hold. Sickly purple-green creeps in slowly, no clean peak — just dread.",
        "sound": "curse_effect.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#503060", 0.20, 0.60), _step("#405020", 0.15, 0.80),
            _step("#302010", 0.08, 1.20),
        ],
        "triggers": {"en": "curse", "fr": "malédiction", "la": "maledictio", "ar": "لعنة", "zh": "诅咒"},
    },
    "holy_effect": {
        "group": "narrative",
        "description": "A holy blessing manifests. Radiant white-gold rises smoothly to a soft, sustained glow.",
        "sound": "holy_effect.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#FFF8E0", 0.30, 0.50), _step("#FFFFF0", 0.75, 0.40),
            _step("#FFE8A0", 0.45, 0.80),
        ],
        "triggers": {"en": "holy blessing", "fr": "bénédiction", "la": "benedictio", "ar": "بركة مقدسة", "zh": "神圣祝福"},
    },
    "poison_cloud": {
        "group": "narrative",
        "description": "A cloud of poison gas spreads. Murky green haze rolls in slowly, lingers low.",
        "sound": "poison_cloud.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#405020", 0.25, 0.80), _step("#304010", 0.15, 1.20),
            _step("#203008", 0.08, 1.20),
        ],
        "triggers": {"en": "poison cloud", "fr": "nuage toxique", "la": "nubes veneni", "ar": "سحابة سامة", "zh": "毒云"},
    },
    "teleport_generic": {
        "group": "narrative",
        "description": "A generic teleport / planar shift. Violet-blue swirl builds and vanishes on a quick flash.",
        "sound": "teleport_generic.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#6060C0", 0.30, 0.30), _step("#A0A0FF", 0.75, 0.20),
            _step("#E0E0FF", 0.95, 0.08), _step("#404080", 0.10, 0.50),
        ],
        "triggers": {"en": "teleport", "fr": "téléportation", "la": "transitus", "ar": "انتقال آني", "zh": "传送"},
    },
    "time_stop": {
        "group": "narrative",
        "description": "Time freezes. Everything holds at a pale, unnaturally still white, then snaps back suddenly.",
        "sound": "time_stop.wav",
        "revert_duration": 1,
        "sequence": [
            _step("#F0F0F8", 0.60, 0.10), _step("#F0F0F8", 0.60, 1.50),
            _step("#FFFFFF", 1.00, 0.05),
        ],
        "triggers": {"en": "time stop", "fr": "arrêt du temps", "la": "tempus stat", "ar": "توقف الزمن", "zh": "时间停止"},
    },
    "explosion_generic": {
        "group": "narrative",
        "description": "A generic explosion (barrel, trap, siege weapon — not a spell). Orange-white burst, quick and violent, dark smoke settle.",
        "sound": "explosion_generic.wav",
        "revert_duration": 2,
        "sequence": [
            _step("#FF8000", 0.60, 0.10), _step("#FFFFE0", 1.00, 0.08),
            _step("#FF4000", 0.50, 0.30), _step("#402010", 0.10, 0.70),
        ],
        "triggers": {"en": "explosion", "fr": "explosion", "la": "explosio", "ar": "انفجار", "zh": "爆炸"},
    },
    "npc_reveal": {
        "group": "narrative",
        "description": "A dramatic NPC reveal or plot twist. A single sharp flash to deep purple, held.",
        "sound": "npc_reveal.wav",
        "revert_duration": 3,
        "sequence": [
            _step("#F0F0FF", 0.90, 0.08), _step("#602080", 0.45, 0.60),
            _step("#301040", 0.20, 1.00),
        ],
        "triggers": {"en": "plot twist", "fr": "coup de théâtre", "la": "revelatio", "ar": "انقلاب الحبكة", "zh": "剧情反转"},
    },
}
