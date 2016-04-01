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
      "https://raw.githubusercontent.com/vsbuffalo/farbenfroh/master/%s.json",
      palette_name
    )
    palette_data <- jsonlite::fromJSON(RCurl::getURL(palette_url))
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


#' create palette for farbenfroh
#'
#' @param name String for palette name (non-zero length alpha-numeric)
#' @param author Character vector of name(s) of palette author(s)
#' @param github_user String for palette's author's GitHub username
#' @param description String for palette's description
#' @param keywords Character vector of palette keywords
#' @param colors Character vector of palette colors
#' @param type One of "divergent", "qualitative", "sequential", "other"
#' @param group String for palette's group
#'
#' @export
#'
#' @examples
create_palette <- function(name, author, github_user = "", description = "",
                           keywords = "", colors, type) {
  palette_data <- list(name = jsonlite::unbox(name),
                       author = paste(keywords, collapse = "; "),
                       github_user = jsonlite::unbox(github_user),
                       description = jsonlite::unbox(description),
                       keywords = paste(keywords, collapse = "; "),
                       date = jsonlite::unbox(Sys.Date()),
                       version = jsonlite::unbox("1.0"),
                       colors = colors,
                       type = jsonlite::unbox(type))
  palette_str <- jsonlite::toJSON(palette_data, pretty = TRUE)
  write(palette_str, file = sprintf("%s.json", name))
}
