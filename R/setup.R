# ==============================================================================
# dndlights — Setup & Configuration
# ==============================================================================

#' Set your LIFX API token
#'
#' Saves your LIFX personal access token to the R session environment so that
#' all spell functions can reach the LIFX API without needing to pass the token
#' explicitly. For the token to persist across sessions, add it to your
#' `.Renviron` file (see `usethis::edit_r_environ()`).
#'
#' @param token A character string containing your LIFX personal access token.
#'   Obtain one at \url{https://cloud.lifx.com/settings}.
#'
#' @return Invisibly returns `TRUE` on success.
#' @export
#'
#' @examples
#' \dontrun{
#' dnd_set_token("your_lifx_token_here")
#' }
dnd_set_token <- function(token) {
  if (!is.character(token) || nchar(trimws(token)) == 0) {
    stop("Token must be a non-empty character string.")
  }
  lifx::lx_save_token(token)
  message(
    "LIFX token set for this session.\n",
    "To persist across sessions, add LIFX_TOKEN=<your_token> to your .Renviron file.\n",
    "Run `usethis::edit_r_environ()` to open it."
  )
  invisible(TRUE)
}


#' Get the current sounds directory
#'
#' Returns the path to the directory where `dndlights` looks for sound effect
#' files. Defaults to a user-level data directory managed by R. Override with
#' [dnd_set_sounds_dir()].
#'
#' @return A character string file path.
#' @export
#'
#' @examples
#' dnd_sounds_dir()
dnd_sounds_dir <- function() {
  custom <- getOption("dndlights.sounds_dir")
  if (!is.null(custom) && nchar(custom) > 0) {
    return(custom)
  }
  tools::R_user_dir("dndlights", which = "data")
}


#' Set a custom sounds directory
#'
#' Tells `dndlights` where to look for `.wav` / `.mp3` sound effect files.
#' This is useful if you store your sounds somewhere other than the default
#' user data directory.
#'
#' @param path A character string giving the path to your sounds folder.
#'
#' @return Invisibly returns the path.
#' @export
#'
#' @examples
#' \dontrun{
#' dnd_set_sounds_dir("~/Music/dnd_sounds")
#' }
dnd_set_sounds_dir <- function(path) {
  if (!dir.exists(path)) {
    stop("Directory does not exist: ", path,
         "\nCreate it first or check the path.")
  }
  options(dndlights.sounds_dir = path)
  message("Sounds directory set to: ", path)
  invisible(path)
}


#' Download D&D spell sound effects
#'
#' Downloads the spell sound effect files from a remote URL into your local
#' sounds directory. By default the files are saved to the `dndlights` user
#' data directory; pass a `dest_dir` to override.
#'
#' **Before running this function** you (or your collaborators) must host the
#' sound files somewhere publicly accessible — e.g., a GitHub Release asset or
#' any direct-download URL. Edit the `base_url` argument or the internal
#' `SOUND_FILES` table to match wherever your files live.
#'
#' @param base_url Base URL (with trailing `/`) from which each file will be
#'   downloaded. Defaults to the GitHub Releases URL for this package — update
#'   it to match your own repository after you create a release and upload the
#'   sound files.
#' @param dest_dir Destination directory. Defaults to [dnd_sounds_dir()].
#' @param overwrite Logical; if `TRUE`, re-download files that already exist.
#'   Default `FALSE`.
#'
#' @return Invisibly returns a named logical vector indicating which files were
#'   successfully downloaded.
#' @export
#'
#' @examples
#' \dontrun{
#' # Download using the default base URL (set in your fork of dndlights)
#' dnd_download_sounds()
#'
#' # Specify a custom host
#' dnd_download_sounds(
#'   base_url = "https://github.com/YOUR_USERNAME/dndlights/releases/download/v1.0/"
#' )
#' }
dnd_download_sounds <- function(
    base_url   = "https://github.com/YOUR_USERNAME/dndlights/releases/download/v1.0/",
    dest_dir   = dnd_sounds_dir(),
    overwrite  = FALSE
) {
  # ---- canonical filenames ---------------------------------------------------
  sound_files <- c(
    fireball         = "fireball.wav",
    eldritch_blast   = "eldritch_blast.wav",
    ice_knife        = "ice_knife.wav",
    shield           = "shield.wav",
    lightning_bolt   = "lightning_bolt.wav",
    cure_wounds      = "cure_wounds.wav",
    firebolt         = "firebolt.wav",
    prestidigitation = "prestidigitation.wav",
    water_whip       = "water_whip.wav",
    magic_missile    = "magic_missile.wav"
  )

  # ---- ensure destination exists --------------------------------------------
  if (!dir.exists(dest_dir)) {
    dir.create(dest_dir, recursive = TRUE)
    message("Created sounds directory: ", dest_dir)
  }

  results <- vapply(sound_files, function(fname) {
    dest_file <- file.path(dest_dir, fname)
    if (file.exists(dest_file) && !overwrite) {
      message("Skipping (already exists): ", fname)
      return(TRUE)
    }
    url <- paste0(base_url, fname)
    tryCatch({
      utils::download.file(url, destfile = dest_file, mode = "wb", quiet = FALSE)
      message("Downloaded: ", fname)
      TRUE
    }, error = function(e) {
      warning("Failed to download: ", fname, "\n  URL: ", url, "\n  ", conditionMessage(e))
      FALSE
    })
  }, logical(1))

  n_ok  <- sum(results)
  n_tot <- length(results)
  message("\nDownload complete: ", n_ok, "/", n_tot, " files saved to:\n  ", dest_dir)

  if (n_ok == n_tot) {
    message("All sounds ready. Set this directory with:\n  dnd_set_sounds_dir(\"", dest_dir, "\")")
  }

  invisible(results)
}
