# ==============================================================================
# dndlights — RStudio Addin
# ==============================================================================

#' Launch the dndlights Control Panel
#'
#' Opens an interactive control panel in the RStudio Viewer pane with tabs for
#' scenes, spells, and effects.  Clicking any button calls the corresponding
#' dndlights function directly in the current R session.
#'
#' The panel tracks the currently active scene and shows it in a status bar
#' at the top.  Requires the \pkg{shiny} and \pkg{miniUI} packages:
#'
#' ```r
#' install.packages(c("shiny", "miniUI"))
#' ```
#'
#' Launch from the RStudio **Addins** menu → *dndlights Control Panel*, or
#' bind it to a keyboard shortcut via Tools → Modify Keyboard Shortcuts.
#'
#' **Concurrency note for voice-command users:** while this panel is open
#' the R session is locked inside Shiny's event loop, so keyboard shortcuts
#' bound to other dndlights addins (e.g. `fireball`, `slash`) will not fire
#' — RStudio queues the shortcut but the R session cannot execute it until
#' the panel closes.  For live voice-command play, keep the panel closed
#' and trigger spells via shortcuts directly.
#'
#' @return Called for side effects. Blocks the R console until the panel is
#'   closed.
#' @export
dnd_addin <- function() {
  if (!requireNamespace("shiny",  quietly = TRUE))
    stop("Package 'shiny' is required. Install with: install.packages('shiny')")
  if (!requireNamespace("miniUI", quietly = TRUE))
    stop("Package 'miniUI' is required. Install with: install.packages('miniUI')")

  # ---- UI helpers ------------------------------------------------------------

  pretty_label <- function(x) tools::toTitleCase(gsub("_", " ", x))

  # Compact action button — full-width, text wraps on two lines if needed
  panel_btn <- function(id, label, bg) {
    shiny::actionButton(
      inputId = id,
      label   = label,
      style   = paste0(
        "background:", bg, ";color:#fff;border:none;border-radius:3px;",
        "width:100%;padding:5px 3px;font-size:11px;line-height:1.3;",
        "margin:0;white-space:normal;text-align:center;cursor:pointer;"
      )
    )
  }

  # Two-column grid of buttons
  btn_grid <- function(btn_list) {
    shiny::tags$div(
      style = paste0(
        "display:grid;grid-template-columns:1fr 1fr;",
        "gap:3px;margin-bottom:5px;"
      ),
      btn_list
    )
  }

  # Section heading inside a tab
  sec_head <- function(label) {
    shiny::tags$p(
      label,
      style = paste0(
        "font-size:10px;font-weight:700;text-transform:uppercase;",
        "letter-spacing:.06em;color:#888;margin:8px 0 3px 0;"
      )
    )
  }

  # ---- Data: groupings -------------------------------------------------------

  # Scenes ---------------------------------------------------------------
  scenes_urban <- c(
    "dueling_club", "noble_house", "detective_office", "curio_shop",
    "newspaper", "tavern", "ballroom"
  )
  scenes_outdoors <- c(
    "ironbottom_riots", "ironbottom_neutral", "ironbottom_night",
    "mine", "factory", "dream_sequence"
  )
  scenes_combat <- c("combat_1", "combat_2", "combat_3", "combat_4", "victory")
  scenes_ambient <- c("base_1", "base_2", "base_3", "base_4")

  # Spells ---------------------------------------------------------------
  spells_offensive <- c(
    "fireball", "eldritch_blast", "ice_knife", "lightning_bolt",
    "firebolt", "magic_missile", "acid_splash", "ray_of_frost", "booming_blade"
  )
  spells_elemental <- c("water_whip", "heat_metal", "wall_of_fire", "faerie_fire")
  spells_necrotic  <- c("blight", "finger_of_death", "disintegrate")
  spells_healing   <- c("cure_wounds", "mass_healing_word", "haste", "light")
  spells_defense   <- c("shield", "mage_armor", "private_sanctum")
  spells_utility   <- c("prestidigitation", "disguise_self", "misty_step")

  # Effects --------------------------------------------------------------
  effects_pc_combat <- c(
    "arcane_shot", "wild_shape", "bludgeon", "slash", "pierce"
  )
  effects_creatures <- c(
    "spider_bite", "dragon_bite", "worm_surge", "crystal_breath"
  )
  effects_magical <- c(
    "hammer_slam", "arcane_surge", "ignite",
    "gust", "sand_blast", "steam_blast", "spore_burst", "flask_shatter"
  )

  # Darkened scene colours — readable with white text
  SCENE_BG <- c(
    dueling_club       = "#7A4A10", noble_house        = "#8B5E10",
    detective_office   = "#6B4A00", curio_shop         = "#5A6520",
    newspaper          = "#7A6030", ironbottom_riots   = "#8B5C0A",
    ironbottom_neutral = "#7A6500", ironbottom_night   = "#6B3005",
    tavern             = "#8B5010", ballroom           = "#8B7518",
    combat_1           = "#7A6515", mine               = "#4A0080",
    combat_2           = "#400070", factory            = "#8B2A00",
    combat_3           = "#7A2000", combat_4           = "#7A6500",
    victory            = "#5A6500", dream_sequence     = "#700A00",
    base_1             = "#8B6820", base_2             = "#7A5010",
    base_3             = "#7A5E18", base_4             = "#6A4510"
  )

  # ---- UI --------------------------------------------------------------------

  ui <- miniUI::miniPage(
    shiny::tags$head(shiny::tags$style(shiny::HTML("
      body, html {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      }
      .gadget-title { background: #12122A; color: #fff; }
      .status-row {
        background: #1A1A30; color: #ccc;
        padding: 4px 10px; font-size: 11px;
        display: flex; align-items: center; gap: 7px;
        border-bottom: 1px solid #2A2A45;
      }
      .scene-dot {
        width: 10px; height: 10px;
        border-radius: 50%; flex-shrink: 0;
      }
      .mini-layout.padding { padding: 6px 8px; }
    "))),

    miniUI::gadgetTitleBar(
      "dndlights",
      left  = NULL,
      right = miniUI::miniTitleBarButton("close_btn", "Close", primary = FALSE)
    ),

    # Live scene indicator
    shiny::uiOutput("status_row"),

    miniUI::miniTabstripPanel(

      # ---------------------------------------------------------------- Scenes
      miniUI::miniTabPanel(
        "Scenes", icon = shiny::icon("map"),
        miniUI::miniContentPanel(
          sec_head("Indoor Locations"),
          btn_grid(lapply(scenes_urban, function(s)
            panel_btn(paste0("sc_", s), pretty_label(s), bg = SCENE_BG[[s]])
          )),
          sec_head("Outdoor & Depths"),
          btn_grid(lapply(scenes_outdoors, function(s)
            panel_btn(paste0("sc_", s), pretty_label(s), bg = SCENE_BG[[s]])
          )),
          sec_head("Combat"),
          btn_grid(lapply(scenes_combat, function(s)
            panel_btn(paste0("sc_", s), pretty_label(s), bg = SCENE_BG[[s]])
          )),
          sec_head("Ambient"),
          btn_grid(lapply(scenes_ambient, function(s)
            panel_btn(paste0("sc_", s), pretty_label(s), bg = SCENE_BG[[s]])
          ))
        )
      ),

      # ---------------------------------------------------------------- Spells
      miniUI::miniTabPanel(
        "Spells", icon = shiny::icon("magic"),
        miniUI::miniContentPanel(
          sec_head("Offensive"),
          btn_grid(lapply(spells_offensive, function(s)
            panel_btn(paste0("sp_", s), pretty_label(s), bg = "#5B2A6A")
          )),
          sec_head("Elemental"),
          btn_grid(lapply(spells_elemental, function(s)
            panel_btn(paste0("sp_", s), pretty_label(s), bg = "#7A3518")
          )),
          sec_head("Necrotic"),
          btn_grid(lapply(spells_necrotic, function(s)
            panel_btn(paste0("sp_", s), pretty_label(s), bg = "#2A1535")
          )),
          sec_head("Healing & Support"),
          btn_grid(lapply(spells_healing, function(s)
            panel_btn(paste0("sp_", s), pretty_label(s), bg = "#1A5C38")
          )),
          sec_head("Defense"),
          btn_grid(lapply(spells_defense, function(s)
            panel_btn(paste0("sp_", s), pretty_label(s), bg = "#1C3C60")
          )),
          sec_head("Utility"),
          btn_grid(lapply(spells_utility, function(s)
            panel_btn(paste0("sp_", s), pretty_label(s), bg = "#3C3A6A")
          ))
        )
      ),

      # --------------------------------------------------------------- Effects
      miniUI::miniTabPanel(
        "Effects", icon = shiny::icon("bolt"),
        miniUI::miniContentPanel(
          sec_head("PC Combat"),
          btn_grid(lapply(effects_pc_combat, function(s)
            panel_btn(paste0("ef_", s), pretty_label(s), bg = "#5A2A2A")
          )),
          sec_head("Creatures"),
          btn_grid(lapply(effects_creatures, function(s)
            panel_btn(paste0("ef_", s), pretty_label(s), bg = "#3A1A1A")
          )),
          sec_head("Magical & Environmental"),
          btn_grid(lapply(effects_magical, function(s)
            panel_btn(paste0("ef_", s), pretty_label(s), bg = "#1D5C40")
          ))
        )
      )
    )
  )

  # ---- Server ----------------------------------------------------------------

  server <- function(input, output, session) {

    active_scene <- shiny::reactiveVal(NULL)

    # Status bar: shows current scene colour and name
    output$status_row <- shiny::renderUI({
      s   <- active_scene()
      col <- if (!is.null(s)) .scene_defs[[s]]$color else "#444"
      lbl <- if (!is.null(s)) pretty_label(s)        else "No scene active"
      shiny::tags$div(
        class = "status-row",
        shiny::tags$span(class = "scene-dot",
                         style = paste0("background:", col, ";")),
        shiny::tags$span(lbl)
      )
    })

    # Scene buttons — use local() to capture loop variable by value
    all_scenes <- c(scenes_urban, scenes_outdoors, scenes_combat, scenes_ambient)
    for (s in all_scenes) {
      local({
        sc <- s
        shiny::observeEvent(input[[paste0("sc_", sc)]], {
          active_scene(sc)
          cue_scene(sc)
        }, ignoreInit = TRUE)
      })
    }

    # Spell buttons
    all_spells <- c(spells_offensive, spells_elemental, spells_necrotic,
                    spells_healing, spells_defense, spells_utility)
    for (sp in all_spells) {
      local({
        fn_name <- sp
        shiny::observeEvent(input[[paste0("sp_", fn_name)]], {
          fn <- get(fn_name, envir = asNamespace("dndlights"), inherits = FALSE)
          fn()
        }, ignoreInit = TRUE)
      })
    }

    # Effect buttons
    all_effects <- c(effects_pc_combat, effects_creatures, effects_magical)
    for (ef in all_effects) {
      local({
        fn_name <- ef
        shiny::observeEvent(input[[paste0("ef_", fn_name)]], {
          fn <- get(fn_name, envir = asNamespace("dndlights"), inherits = FALSE)
          fn()
        }, ignoreInit = TRUE)
      })
    }

    shiny::observeEvent(input$close_btn, shiny::stopApp())
  }

  shiny::runGadget(
    ui, server,
    viewer       = shiny::paneViewer(minHeight = 500),
    stopOnCancel = FALSE
  )
}
