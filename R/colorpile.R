#' colorpile palette
#'
#' @param palette_name Name of palette.
#'
#' @examples
#' if (requireNamespace("scales", quietly = TRUE)) {
#'   library(scales)
#'   show_col(colorpile_palette("Royal1")(4))
#' }
#' @export
colorpile_palette <- function(palette_name) {
  palette_data <- colorpile_palette_data(palette_name)
  max <- length(palette_data$colors)
  ret <- function(num_values=max) {
    palette_data$colors[subsample(num_values, max)]
  }
  class(ret) <- "colorpile_palette"
  ret
}

#' @export
#' @rdname colorpile_palette
colorpile_palette_data <- function(palette_name) {
  env$st$get(palette_name)
}

##' Purge the cache of downloaded palettes.
##' @title Purge colorpile cache
##' @export
colorpile_purge_cache <- function() {
  env$st$destroy()
  .onLoad()
}

fetch_hook_colorpiler <- function(key, namespace) {
  fmt <- "https://raw.githubusercontent.com/ropenscilabs/colorpile/master/palettes/%s.json"
  path <- tempfile("colorpiler_")
  on.exit(file.remove(path))
  download_file(sprintf(fmt, key), path)
  jsonlite::fromJSON(read_file(path))
}

#' @export
print.colorpile_palette <- function(x, ...) {
  bg <- x()
  fg <- ifelse(rgb2hsv(col2rgb(bg))["v", ] > 0.7, "black", "white")
  str <- sprintf("<a colorpile palette of %d colors:>\n%s\n",
                 length(bg),
                 paste0("\t", mapply(crayon::style, bg, fg, bg),
                        collapse="\n"))
  cat(str)
}
