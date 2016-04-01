#' farben palette
#'
#' @param palette_name Name of palette.
#'
#' @examples
#' if (requireNamespace("scales", quietly = TRUE)) {
#'   library(scales)
#'   show_col(farben_palette("wes_a_fave")(9))
#' }
#' @export
farben_palette <- function(palette_name) {
  function(num_values) {
    palette_url <- sprintf(
      "https://raw.githubusercontent.com/vsbuffalo/farbenfroh/master/palettes/%s.json",
      palette_name
    )
    palette_data <- jsonlite::fromJSON(httr::content(httr::GET(palette_url), as = "text"))
    palette_data$colors[1:num_values]
  }
}

#' farben colour palettes for ggplot2
#'
#' @param name Name of palette.
#' @param ... Arguments passed on to discrete_scale to control name, limits,
#'   breaks, labels and so forth.
#'
#' @examples
#' if (requireNamespace("ggplot2", quietly = TRUE)) {
#'   library(ggplot2)
#'   ggplot(mtcars, aes(x = mpg, y = hp, colour = factor(cyl))) +
#'     geom_point() +
#'     scale_colour_farben("wes_a_fave")
#' }
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
