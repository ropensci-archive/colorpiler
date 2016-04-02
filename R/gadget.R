#' Browse colorpile palettes
#'
#' @param pal Character vector of palette names
#' @export
#'
#' @importFrom shiny uiOutput renderUI observeEvent stopApp runGadget tags
#' @importFrom miniUI miniPage gadgetTitleBar miniContentPanel
browse_colorpile <- function(pal) {

  if (missing(pal)) {
    stop("You must pass a colour palette", call. = FALSE)
  }

  css <- "
  .palette-box { cursor: pointer; text-align: center; font-weight: bold; }
  .palette-box:hover .palette-table { opacity: 0.9; }
  .palette-table { height: 300px; width: 100%; margin-bottom: 40px; }
  .palette-name { font-size: 1.2em; }"

  jscode <- "
  shinyjs.init = function() {
    $(document).click('.palette-box', function(e) {
      var paletteName = $(e.target).closest('.palette-box').data('name');
      Shiny.onInputChange('paletteSelected', paletteName);
    });
  };
  "

  ui <- miniPage(
    shinyjs::useShinyjs(),
    shinyjs::inlineCSS(css),
    shinyjs::extendShinyjs(text = jscode, functions = c()),
    gadgetTitleBar("Palette browser"),
    miniContentPanel(
      uiOutput("palettes", height = "100%")
    )
  )

  server <- function(input, output, session) {

    draw_palette <- function(pal_data) {
      div(
        class = "palette-box",
        `data-name` = pal_data$name,
        div(class = "palette-name", pal_data$name),
        tags$table(class = "palette-table", tags$tbody(tags$tr(
          lapply(pal_data$colors, function(x) {
            if (rgb2hsv(col2rgb(x))["v", ] > 0.7) {
              fg <- "black"
            } else {
              fg <- "white"
            }
            tags$td(x,
                    style = paste0("background: ", x, "; color: ", fg))
          })
        )))
      )
    }

    output$palettes <- renderUI({
      lapply(pal, function(x) {
        pal_data <- colorpile_palette_data(x)
        draw_palette(pal_data)
      })
    })

    observeEvent(input$paletteSelected, {
      cat(input$paletteSelected, "\n")
      shinyjs::info(paste0("Selected ", input$paletteSelected))
    })
  }

  runGadget(ui, server)
}
