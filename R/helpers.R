# ==============================================================================
# dndlights — Core Helper Functions
# ==============================================================================

# ------------------------------------------------------------------------------
# Internal: resolve sound file path
# ------------------------------------------------------------------------------
.get_sound_path <- function(filename) {
  sounds_dir <- dnd_sounds_dir()
  fpath <- file.path(sounds_dir, filename)
  if (!file.exists(fpath)) {
    warning(
      "Sound file not found: ", fpath,
      "\nRun dnd_download_sounds() to fetch all sound effects, or ",
      "dnd_set_sounds_dir() to point to your existing sounds folder."
    )
  }
  fpath
}


#' Play a sound file asynchronously
#'
#' Plays a `.wav` or `.mp3` file in the background so R is not blocked while
#' the sound is playing. Uses `afplay` on macOS, `paplay` / `aplay` on Linux,
#' and PowerShell's `SoundPlayer` on Windows.
#'
#' @param fpath Full path to the audio file.
#'
#' @return Invisibly returns the system call exit code.
#' @export
#'
#' @examples
#' \dontrun{
#' play_sound(file.path(dnd_sounds_dir(), "fireball.wav"))
#' }
play_sound <- function(fpath) {
  if (!file.exists(fpath)) {
    warning("Sound file not found, skipping audio: ", fpath)
    return(invisible(1L))
  }

  os <- Sys.info()[["sysname"]]

  code <- switch(
    os,
    "Darwin"  = system(paste("afplay", shQuote(fpath), "&"), wait = FALSE),
    "Linux"   = {
      # prefer PulseAudio, fall back to ALSA
      if (nchar(Sys.which("paplay")) > 0) {
        system(paste("paplay", shQuote(fpath), "&"), wait = FALSE)
      } else {
        system(paste("aplay", shQuote(fpath), "&"), wait = FALSE)
      }
    },
    "Windows" = system(
      paste0(
        'powershell -NoProfile -Command "',
        '$p = New-Object System.Media.SoundPlayer ',
        shQuote(fpath, type = "cmd"),
        '; $p.Play()"'
      ),
      wait = FALSE
    ),
    {
      warning("Unsupported OS for audio playback: ", os)
      1L
    }
  )

  invisible(code)
}


#' Change LIFX light color and brightness
#'
#' A thin wrapper around [lifx::lx_color()] that additionally calls
#' `Sys.sleep(duration)` after the transition so that sequential calls chain
#' smoothly without overlapping.
#'
#' @param color_name A color hex string (e.g. `"#FF4500"`) or LIFX color name.
#' @param brightness Brightness between `0` and `1`.
#' @param duration Transition time in seconds.
#' @param fast Logical; if `TRUE` the API call skips state checks for speed.
#'
#' @return Invisibly returns the `lifx` API response.
#' @export
#'
#' @examples
#' \dontrun{
#' change_light("#FF4500", brightness = 0.5, duration = 0.5)
#' }
change_light <- function(color_name = "#ffffff",
                         brightness = 0.3,
                         duration   = 1,
                         fast       = TRUE) {
  resp <- lifx::lx_color(
    color_name = color_name,
    brightness = brightness,
    duration   = duration,
    fast       = fast
  )
  Sys.sleep(duration)
  invisible(resp)
}


#' Revert lights to a neutral warm-white state
#'
#' Fades the lights back to a soft warm white (`#E0D4CC`) at low brightness —
#' intended to restore a "room is calm" ambiance after a spell effect completes.
#'
#' @param duration Fade duration in seconds. Default `4`.
#'
#' @return Invisibly returns the `lifx` API response.
#' @export
#'
#' @examples
#' \dontrun{
#' revert_state()
#' revert_state(duration = 2)
#' }
revert_state <- function(duration = 4) {
  resp <- lifx::lx_color(
    color_name = "#E0D4CC",
    brightness = 0.1,
    duration   = duration
  )
  invisible(resp)
}
