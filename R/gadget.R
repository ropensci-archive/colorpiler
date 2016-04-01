##' @importFrom shiny uiOutput imageOutput renderUI observeEvent stopApp brushedPoints renderPlot runGadget
##' @importFrom miniUI miniPage gadgetTitleBar miniContentPanel
browse_colorpile <- function(pal) {

  ui <- miniPage(
      gadgetTitleBar("palette"),
      miniContentPanel(
          uiOutput("plot", height = "100%")
    )
  )

    server <- function(input, output, session) {

        each_palette <- function(pal) {
            lapply(seq_along(pal), function(i) {
                n <- length(pal[[i]]$colors)
                cols <- pal[[i]]$colors
                output[[paste0("pal", i)]] <- renderPlot({
                    image(seq_len(n), 1, as.matrix(seq_len(n)), col = cols,
                          xlab = "", ylab = "", xaxt = "n", yaxt = "n", bty = "n")

                    fg <- ifelse(rgb2hsv(col2rgb(cols))["v", ] > 0.7, "black", "white")
                    text(seq_len(n), 1, labels = cols, col = fg)
                })
            })
        }

      draw_palette <- function(pal_name, ...) {
          pal_data <- lapply(pal_name, colorpile_palette_data)
          lapply(seq_along(each_palette(pal_data)), function(i) {
              message(pal_data[[i]]$name)
              ##h3(pal_data[[i]]$name)
              imageOutput(paste0("pal", i))
          })
      }

      output$plot <- renderUI({
          draw_palette(pal)
      })

      ## Handle the Done button being pressed.
      observeEvent(input$done, {
          ## Return the brushed points. See ?shiny::brushedPoints.
          stopApp(brushedPoints(data, input$brush))
      })
  }

  runGadget(ui, server)
}