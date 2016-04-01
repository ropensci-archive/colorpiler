# curate.R -- curate JSON palettes
COLS <- c('name', 'author', 'github_user', 'group', 'type',
          'description', 'keywords', 'date', 'version')
OPTIONAL <- c('github_user', 'keywords', 'description')


#' Apply function over palettes
#'
#' @param repo_dir directory of palette repository
#' @param fun function to apply over files
#' @param ... further arguments passed to \code{fun}
palette_pply <- function(repo_dir, fun, ...) {
  files <- list.files(repo_dir, pattern="*.json", full.names=TRUE)
  lapply(files, fun, ...)
}

try_join <- function(items) {
  if (length(items) > 1L)
    return(paste(items, collapse=";"))
  return(items)
}

format_palette  <- function(json) {
  # merge authors
  cnames <- names(json)
  df <- as.data.frame(lapply(COLS, function(col) {
          if (!(col %in% cnames)) {
            if (!(col %in% OPTIONAL))
              stop("non-optional key missing; did this pass validation?")
            else
              val <- NA
          } else {
            val <- json[[col]]
          }
          try_join(val)
  }))
  colnames(df) <- COLS
  df
}

#' Palette set metadata
#'
#' @param repo_dir Path to directory with farbenbroh repository
#' @export
metadata <- function(repo_dir) {
  do.call(rbind, palette_pply(repo_dir, function(f) {
    js <- jsonlite::fromJSON(readLines(f), simplifyDataFrame=TRUE)
    format_palette(js)
  }))
}
