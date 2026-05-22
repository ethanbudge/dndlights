# ==============================================================================
# dndlights — Scene Functions
# ==============================================================================
# cue_scene() sets the ambient lighting and starts a Spotify playlist.
# After a scene is cued, all spell revert_state() calls return to that scene.
#
# Edit the playlist URI strings below to point to your Spotify playlists.
# Playlist URIs have the format: "spotify:playlist:<id>"
# ==============================================================================


# ------------------------------------------------------------------------------
# Scene definitions
# color    — hex RGB to set via change_light()
# brightness — 0–1 LIFX brightness
# playlist — Spotify playlist URI (edit placeholders before use)
# ------------------------------------------------------------------------------
.scene_defs <- list(

  # Abandoned warehouse lit by sparse gas lamps; the dueling arena carries
  # a hazy amber industrial glow with deep surrounding shadows.
  dueling_club = list(
    color = "#C87820", brightness = 0.30,
    playlist = "spotify:playlist:47cMNWd7HteEWNKafIBy5P?si=ea7042d7dcc24853"
  ),

  # A private estate office — dark oak panelling, leather chairs, warm oil lamps.
  noble_house = list(
    color = "#D4961E", brightness = 0.28,
    playlist = "spotify:playlist:7b09RNPhEh3OtBIg0v2FHH?si=55c91771f05b4e58"
  ),

  # A brooding noir detective's office: one lamp cuts the dark, everything
  # else dissolves into amber shadow.
  detective_office = list(
    color = "#E8A000", brightness = 0.12,
    playlist = "spotify:playlist:0iEqFsH5710NeQIsjY6GRV?si=0e20601c71ff460f"
  ),

  # Cramped shelves of ancient relics lit by low aged-gold oil lamps;
  # warm but slightly dim, as if the light itself is old.
  curio_shop = list(
    color = "#BFA030", brightness = 0.22,
    playlist = "spotify:playlist:0GkkCFKCZBasPAH3AYbbfX?si=0d45c629aa4f4f83"
  ),

  # The busy press room of a prominent newspaper: harsh bright work-lamps
  # illuminate ink-stained desks and thundering printing presses.
  newspaper = list(
    color = "#FFDA80", brightness = 0.70,
    playlist = "spotify:playlist:5iAKfKLlsGyjAfu4ewx7nI?si=15e904254dab4b82"
  ),

  # Ironbottom Canyon floor at dawn — golden-orange morning light rakes across
  # the rock walls, casting long warm shadows across the rising crowd.
  ironbottom_riots = list(
    color = "#E88C14", brightness = 0.50,
    playlist = "spotify:playlist:6m3PyWHc1K2Et4PWwWqoyy?si=ce7e1bf2b82d4eff"
  ),

  # The canyon floor at high noon — overhead desert sun at full ferocity,
  # brilliant white-gold with almost no shadows.
  ironbottom_neutral = list(
    color = "#FFE060", brightness = 0.85,
    playlist = "spotify:playlist:22d55dZa63IuYnVrohz29R?si=1a50cb049c144c8b"
  ),

  # The canyon floor at night; torchlight is the only source — a warm
  # orange-red glow pooling against impenetrable desert darkness.
  ironbottom_night = list(
    color = "#B04808", brightness = 0.18,
    playlist = "spotify:playlist:37R2hKuxOd9QzFslqXDXAj?si=afe403f6c5934f98"
  ),

  # A rowdy working-class tavern alive with fireplace warmth and swinging
  # oil lanterns; amber and lively, but nothing refined about it.
  tavern = list(
    color = "#CC7820", brightness = 0.40,
    playlist = "spotify:playlist:3fFObop6jjj38jXoUXrUHt?si=2d78dd0e97ee43aa"
  ),

  # The grand ballroom of high aristocracy: hundreds of warm candles in
  # crystal chandeliers cast a golden glow over polished marble floors.
  ballroom = list(
    color = "#E8C030", brightness = 0.38,
    playlist = "spotify:playlist:5nzmZMA0K3U0FIHxw6V70m?si=5ee2e2ec46bc409d"
  ),

  # Same candlelit-ballroom lighting; combat playlist.
  combat_1 = list(
    color = "#E8C030", brightness = 0.38,
    playlist = "spotify:playlist:4mirB6vFgWAm2JtVt0DvUn?si=96f01615090445e4"
  ),

  # A deep mine shaft in near-total darkness; faint purple bioluminescent
  # mushrooms are the only light source.
  mine = list(
    color = "#7800CC", brightness = 0.08,
    playlist = "spotify:playlist:2aUhqxrhZfEwDJ4YHALuJo?si=b7794a1e6de64a0a"
  ),

  # Same mine lighting; combat playlist.
  combat_2 = list(
    color = "#7800CC", brightness = 0.08,
    playlist = "spotify:playlist:0eOHdH2Dp35vccbF2ePfZh?si=5399ef275ceb478e"
  ),

  # A roaring factory floor: orange-red molten metal glows beneath the
  # harsh industrial lamps, heat haze blurring everything.
  factory = list(
    color = "#E84A00", brightness = 0.60,
    playlist = "spotify:playlist:0gMWkF51N34O3HtDOpuOW5?si=755e0fa38ceb4937"
  ),

  # Same factory lighting; combat playlist.
  combat_3 = list(
    color = "#E84A00", brightness = 0.60,
    playlist = "spotify:playlist:2kgWzqO1GBRI35jNBTSbA7?si=02cc14b790154c8d"
  ),

  # A bridge spanning Ironbottom Canyon at midday — same blinding desert sun
  # as ironbottom_neutral, now from an exposed elevated position.
  combat_4 = list(
    color = "#FFE060", brightness = 0.85,
    playlist = "spotify:playlist:3f5vznWOHhdP8H6Ib4N8DW?si=0a55f4295bf24890"
  ),

  # Same canyon-bridge midday lighting; victory playlist.
  victory = list(
    color = "#FFE060", brightness = 0.85,
    playlist = "spotify:playlist:3YPnzQ6TcXoUAy0G5dCaTX?si=18aff5279a5c419b"
  ),

  # A dreamscape of fire, swirling ash, and a blood-red sun — deep crimson
  # haze at low intensity, oppressive and otherworldly.
  dream_sequence = list(
    color = "#C01800", brightness = 0.22,
    playlist = "spotify:playlist:00XuMs8zOdT1KagPXK1qBg?si=116ad9c753c24cfb"
  ),

  # Neutral outdoor desert ambient — warm afternoon amber for general use.
  base_1 = list(
    color = "#FFB040", brightness = 0.55,
    playlist = "spotify:playlist:5jwMaDX2Uzoq0lCdhiXGJ4?si=809bf875be454269"
  ),

  # Neutral indoor ambient — warm lamp amber for general use.
  base_2 = list(
    color = "#D49020", brightness = 0.35,
    playlist = "spotify:playlist:5sSlpIe2qBaUzTDDE154Rw?si=bdf1baf226074fee"
  ),

  # Same outdoor desert lighting as base_1; alternate playlist.
  base_3 = list(
    color = "#FFB040", brightness = 0.55,
    playlist = "spotify:playlist:1pP5lXmBbzja8h1Umtlcof?si=28ae5d2e83884655"
  ),

  # Same indoor lighting as base_2; alternate playlist.
  base_4 = list(
    color = "#D49020", brightness = 0.35,
    playlist = "spotify:playlist:0GSqqyr05SnnzCtujMpIgc?si=1c0b651b2cf64d71"
  )
)


# ------------------------------------------------------------------------------
# Spotify token management
# ------------------------------------------------------------------------------

#' Set your Spotify access token
#'
#' Saves a Spotify access token for the current R session so that [cue_scene()]
#' can control playback.  The token must have the
#' `user-modify-playback-state` scope.
#'
#' **Obtaining a token:**
#' The easiest route is `spotifyr::get_spotify_authorization_code()`.  Set
#' `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET` in your `.Renviron` file,
#' then call:
#' ```r
#' tok <- spotifyr::get_spotify_authorization_code(
#'   scope = "user-modify-playback-state"
#' )
#' dnd_set_spotify_token(tok$credentials$access_token)
#' ```
#'
#' Alternatively, copy a token directly from the
#' [Spotify Developer Console](https://developer.spotify.com/console/put-play/).
#'
#' For the token to persist across sessions, add
#' `SPOTIFY_ACCESS_TOKEN=<your_token>` to your `.Renviron` file
#' (see `usethis::edit_r_environ()`). Note that Spotify access tokens expire
#' after one hour and must be refreshed.
#'
#' @param token A character string containing a valid Spotify access token.
#'
#' @return Invisibly returns `TRUE` on success.
#' @export
#'
#' @examples
#' \dontrun{
#' dnd_set_spotify_token("BQC...")
#' }
dnd_set_spotify_token <- function(token) {
  if (!is.character(token) || nchar(trimws(token)) == 0) {
    stop("Token must be a non-empty character string.")
  }
  .dnd_env$spotify_token <- token
  message(
    "Spotify token set for this session.\n",
    "Note: Spotify access tokens expire after one hour.\n",
    "To persist the token, add SPOTIFY_ACCESS_TOKEN=<token> to your .Renviron file.\n",
    "Run `usethis::edit_r_environ()` to open it."
  )
  invisible(TRUE)
}


# Internal: retrieve stored Spotify access token.
.get_spotify_token <- function() {
  token <- .dnd_env$spotify_token
  if (!is.null(token) && nchar(token) > 0) return(token)

  token <- Sys.getenv("SPOTIFY_ACCESS_TOKEN")
  if (nchar(token) > 0) return(token)

  stop(
    "Spotify access token not found.\n",
    "Call dnd_set_spotify_token() with a valid access token, or add\n",
    "SPOTIFY_ACCESS_TOKEN=<token> to your .Renviron file.\n",
    "The token needs the 'user-modify-playback-state' scope.\n",
    "Obtain one via:\n",
    "  spotifyr::get_spotify_authorization_code(scope = \"user-modify-playback-state\")\n",
    "or from the Spotify Developer Console."
  )
}


# Internal: start a playlist from its first track, disable shuffle,
# and set repeat mode to 'context' (loops the whole playlist).
.spotify_cue_playlist <- function(playlist_uri, token) {
  auth  <- httr::add_headers(Authorization = paste("Bearer", token))
  ctype <- httr::content_type_json()

  httr::PUT(
    "https://api.spotify.com/v1/me/player/play",
    auth, ctype,
    body = jsonlite::toJSON(
      list(
        context_uri = playlist_uri,
        offset      = list(position = 0L),
        position_ms = 0L
      ),
      auto_unbox = TRUE
    )
  )

  httr::PUT(
    "https://api.spotify.com/v1/me/player/shuffle",
    auth,
    query = list(state = "false")
  )

  httr::PUT(
    "https://api.spotify.com/v1/me/player/repeat",
    auth,
    query = list(state = "context")
  )

  invisible(NULL)
}


# ------------------------------------------------------------------------------
# cue_scene
# ------------------------------------------------------------------------------

#' Cue a scene: set ambient lighting and start a Spotify playlist
#'
#' Sets the LIFX lights to the scene's color and brightness, then starts the
#' scene's Spotify playlist from the top without shuffling, looping when it
#' reaches the end.
#'
#' After this call, all spell functions will fade back to this scene's lighting
#' when they finish (via [revert_state()]).
#'
#' A Spotify access token with the `user-modify-playback-state` scope must be
#' set before calling this function — see [dnd_set_spotify_token()].
#'
#' Edit the playlist URI placeholders in `R/scenes.R` (`.scene_defs`) to point
#' to your actual Spotify playlists before use.
#'
#' @param scene A character string naming the scene to activate. One of:
#'   `"dueling_club"`, `"noble_house"`, `"detective_office"`,
#'   `"curio_shop"`, `"newspaper"`, `"ironbottom_riots"`,
#'   `"ironbottom_neutral"`, `"ironbottom_night"`, `"tavern"`,
#'   `"ballroom"`, `"combat_1"`, `"mine"`, `"combat_2"`, `"factory"`,
#'   `"combat_3"`, `"combat_4"`, `"victory"`, `"dream_sequence"`,
#'   `"base_1"`, `"base_2"`, `"base_3"`, `"base_4"`.
#'
#' @return Invisibly `NULL`. Called for side effects.
#' @export
#'
#' @examples
#' \dontrun{
#' dnd_set_spotify_token("BQC...")
#' cue_scene("tavern")
#' fireball()        # lights flash, then return to tavern amber
#' cue_scene("combat_1")
#' }
cue_scene <- function(scene) {
  valid <- names(.scene_defs)
  if (!scene %in% valid) {
    stop(
      "Unknown scene: \"", scene, "\"\n",
      "Available scenes: ", paste(valid, collapse = ", ")
    )
  }

  s <- .scene_defs[[scene]]

  # Smooth 3-second transition into the scene lighting
  change_light(color_name = s$color, brightness = s$brightness, duration = 3)

  # Record this as the ambient state spells will revert to
  .dnd_env$color      <- s$color
  .dnd_env$brightness <- s$brightness

  # Start the Spotify playlist
  token <- .get_spotify_token()
  .spotify_cue_playlist(s$playlist, token)

  invisible(NULL)
}
