"""Cross-platform, non-blocking sound-effect playback (port of R/helpers.R)."""

from __future__ import annotations

import platform
import shutil
import subprocess
from pathlib import Path


def sound_path(sounds_dir: str, filename: str) -> Path:
    return Path(sounds_dir) / filename


def play_sound(fpath: str | Path) -> bool:
    """Play a .wav/.mp3 file in the background. Returns False if the file is
    missing or no supported player is found -- never raises, since a missing
    sound effect shouldn't block the light show."""
    path = Path(fpath)
    if not path.exists():
        return False

    system = platform.system()
    try:
        if system == "Darwin":
            subprocess.Popen(["afplay", str(path)],
                              stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        elif system == "Linux":
            player = "paplay" if shutil.which("paplay") else "aplay"
            if not shutil.which(player):
                return False
            subprocess.Popen([player, str(path)],
                              stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        elif system == "Windows":
            subprocess.Popen(
                ["powershell", "-NoProfile", "-Command",
                 f'$p = New-Object System.Media.SoundPlayer "{path}"; $p.PlaySync()'],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
            )
        else:
            return False
    except OSError:
        return False
    return True
