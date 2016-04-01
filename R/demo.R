##' Colorpile demo
##'
##' @export
demo_colorpile <- function() {

  ui <- miniPage(
    miniUI::gadgetTitleBar("Test out palettes"),
    miniUI::miniContentPanel(
      shiny::selectInput("palette", label = "Palette",
                  choices = as.character(colorpile_metadata()$name),
                  selected = "Darjeeling"),
      shiny::plotOutput("plot")
    )
  )

  server <- function(input, output, session) {
    ggplot2::theme_set(ggplot2::theme_bw())

    output$plot <- shiny::renderPlot({
      ggplot2::ggplot(iris,
                      ggplot2::aes_string(x = "Sepal.Length", y = "Sepal.Width",
                                          color = "Species")) +
        ggplot2::geom_point(size = 3) +
        scale_color_colorpile(input$palette)
    })

    observeEvent(input$done, {
      shiny::stopApp(input$palette)
    })

  }

  shiny::runGadget(ui, server)
}