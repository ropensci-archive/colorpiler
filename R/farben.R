#' solarized colour palette
#'
#' Provides a colour scheme based on the
#' \href{http://ethanschoonover.com/solarized}{solarized} accent colours.
#'
#' @param num_values Number of values to colour. If more than 9, colours start
#'   to repeat.
#'
#' @examples
#' if (requireNamespace("scales", quietly = TRUE)) {
#'   library(scales)
#'   show_col(farben_palette("example"))
#' }
#' @export
farben_palette <- function(palette_name) {
  function(num_values) {
    palette_data <- jsonlite::fromJSON(sprintf("../inst/%s.json", palette_name))
    palette_data$colors[1:num_values]
  }
}

#' farben colour palettes for ggplot2
#'
#' @param ... Arguments passed on to discrete_scale to control name, limits,
#'   breaks, labels and so forth.
#'
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(x = mpg, y = hp, colour = factor(cyl))) +
#'   geom_point() +
#'   scale_colour_farben("example")
#' @export
scale_colour_farben <- function(name, ...) {
  ggplot2::discrete_scale(aesthetics = "colour", scale_name = "farben",
                          palette = farben_palette(name), ...)
}

#' @rdname scale_colour_farben
#' @export
scale_color_farben <- function(name, ...) {
  scale_colour_farben(name, ...)
}

#' @rdname scale_colour_farben
#' @export
scale_fill_farben <- function(name, ...) {
  ggplot2::discrete_scale(aesthetics = "fill", scale_name = "farben",
                          palette = farben_palette(name), ...)
}
