#' colorpile colour palettes for ggplot2
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
#'     scale_colour_colorpile("Royal1")
#' }
#' @export
scale_colour_colorpile <- function(name, ...) {
  ggplot2::discrete_scale(aesthetics = "colour", scale_name = "colorpile",
                          palette = colorpile_palette(name), ...)
}

#' @rdname scale_colour_colorpile
#' @export
scale_color_colorpile <- function(name, ...) {
  scale_colour_colorpile(name, ...)
}

#' @rdname scale_colour_colorpile
#' @export
scale_fill_colorpile <- function(name, ...) {
  ggplot2::discrete_scale(aesthetics = "fill", scale_name = "colorpile",
                          palette = colorpile_palette(name), ...)
}
