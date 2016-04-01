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
  palette_data <- farben_palette_data(palette_name)
  max <- length(palette_data$colors)
  function(num_values) {
    palette_data$colors[subsample(num_values, max)]
  }
}

#' @export
#' @rdname farben_palette
farben_palette_data <- function(palette_name) {
  env$st$get(palette_name)
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

fetch_hook_farben <- function(key, namespace) {
  fmt <- "https://raw.githubusercontent.com/vsbuffalo/farbenfroh/master/palettes/%s.json"
  path <- tempfile("farben_")
  on.exit(file.remove(path))
  download_file(sprintf(fmt, key), path)
  jsonlite::fromJSON(read_file(path))
}
