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

  scenes_outdoor <- c(
    "ironbottom_riots", "ironbottom_neutral", "ironbottom_night",
    "base_1", "base_3", "combat_4", "victory"
  )
  scenes_indoor <- c(
    "dueling_club", "noble_house", "detective_office", "curio_shop",
    "newspaper", "tavern", "ballroom", "dream_sequence", "base_2", "base_4"
  )
  scenes_combat <- c("combat_1", "mine", "combat_2", "factory", "combat_3")

  spells_orig <- c(
    "fireball", "eldritch_blast", "ice_knife", "shield", "lightning_bolt",
    "cure_wounds", "firebolt", "prestidigitation", "water_whip", "magic_missile"
  )
  spells_exp <- c(
    "light", "mage_armor", "misty_step", "private_sanctum", "booming_blade",
    "disguise_self", "haste", "acid_splash", "heat_metal", "faerie_fire",
    "ray_of_frost", "wall_of_fire", "finger_of_death", "disintegrate",
    "blight", "mass_healing_word"
  )
  effects <- c(
    "hammer_slam", "arcane_shot", "ignite", "gust", "wild_shape",
    "spider_bite", "worm_surge", "spore_burst", "flask_shatter",
    "steam_blast", "crystal_breath", "dragon_bite", "arcane_surge",
    "sand_blast", "bludgeon", "slash", "pierce"
  )

  # Darkened scene colours — readable with white text
  SCENE_BG <- c(
    dueling_club       = "#7A4A10", noble_house        = "#8B5E10",
    detective_office   = "#6B4A00", curio_shop         = "#6A5510",
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
          sec_head("Outdoor / Canyon"),
          btn_grid(lapply(scenes_outdoor, function(s)
            panel_btn(paste0("sc_", s), pretty_label(s), bg = SCENE_BG[[s]])
          )),
          sec_head("Indoor Spaces"),
          btn_grid(lapply(scenes_indoor, function(s)
            panel_btn(paste0("sc_", s), pretty_label(s), bg = SCENE_BG[[s]])
          )),
          sec_head("Combat"),
          btn_grid(lapply(scenes_combat, function(s)
            panel_btn(paste0("sc_", s), pretty_label(s), bg = SCENE_BG[[s]])
          ))
        )
      ),

      # ---------------------------------------------------------------- Spells
      miniUI::miniTabPanel(
        "Spells", icon = shiny::icon("magic"),
        miniUI::miniContentPanel(
          sec_head("Original"),
          btn_grid(lapply(spells_orig, function(s)
            panel_btn(paste0("sp_", s), pretty_label(s), bg = "#5B3A8A")
          )),
          sec_head("Expanded"),
          btn_grid(lapply(spells_exp, function(s)
            panel_btn(paste0("sp_", s), pretty_label(s), bg = "#2D4E8A")
          ))
        )
      ),

      # --------------------------------------------------------------- Effects
      miniUI::miniTabPanel(
        "Effects", icon = shiny::icon("bolt"),
        miniUI::miniContentPanel(
          sec_head("Combat & Creatures"),
          btn_grid(lapply(effects, function(s)
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
    all_scenes <- c(scenes_outdoor, scenes_indoor, scenes_combat)
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
    for (sp in c(spells_orig, spells_exp)) {
      local({
        fn_name <- sp
        shiny::observeEvent(input[[paste0("sp_", fn_name)]], {
          fn <- get(fn_name, envir = asNamespace("dndlights"), inherits = FALSE)
          fn()
        }, ignoreInit = TRUE)
      })
    }

    # Effect buttons
    for (ef in effects) {
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
