# curate.R -- curate JSON palettes
COLS <- c('name', 'authors', 'github_user', 'type', 'date')
OPTIONAL <- c('github_user', 'keywords', 'description')

#' Apply function over palettes
#'
#' @param repo_dir directory of palette repository
#' @param fun function to apply over files
#' @param ... further arguments passed to \code{fun}
palette_pply <- function(repo_dir, fun, ...) {
  lapply(list.files(repo_dir, pattern = "\\.json$", full.names = TRUE), fun, ...)
}

try_join <- function(items) {
  if (length(items) > 1L)
    return(paste(items, collapse = ";"))
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
#' @export
colorpile_metadata <- function() {
  if (is.null(env$metadata)) {
    path <-
      download_file("https://github.com/vsbuffalo/farbenfroh/archive/master.zip",
                    tempfile())
    dest <- tempfile()
    unzip(path, exdir = dest)
    file.remove(path)
    ## This is the path we want:
    path <- file.path(dest, "farbenfroh-master", "palettes")
    re <- "\\.json$"
    files <- dir(path, pattern = re)

    pals <- sub(re, "", files)
    names(files) <- pals

    for (i in setdiff(pals, env$st$list())) {
      env$st$set(i, jsonlite::fromJSON(read_file(file.path(path, files[[i]]))))
    }

    env$metadata <- path
  } else {
    path <- env$metadata
  }

  read_pal <- function(f) {
    format_palette(jsonlite::fromJSON(read_file(f), simplifyDataFrame = TRUE))
  }
  do.call(rbind, c(palette_pply(path, read_pal)))
}

#' Search colorpile palettes
#'
#' Filters the palettes in colorpile down to those that match search terms
#'
#' @param authors Character vector of author(s)
#' @param github_user String of author's GitHub username
#' @param type One of 'divergent', 'qualitative', 'sequential', 'other'
#'
#' @return Character vector of palette names
#' @export
#'
#' @examples
#' search_colorpile(authors = c("Karthik Ram", "Ethan Schoonover"))
#' search_colorpile(author = "Cynthia Brewer", type = "diverging")
search_colorpile <- function(authors = NULL, github_user = NULL, type = NULL) {
  filtered_palettes <- colorpile_metadata()
  if (!is.null(authors)) {
    filtered_palettes <- filtered_palettes[filtered_palettes$authors %in% authors,]
  }
  if (!is.null(github_user)) {
    filtered_palettes <- filtered_palettes[filtered_palettes$github_user == github_user,]
  }
  if (!is.null(type)) {
    filtered_palettes <- filtered_palettes[filtered_palettes$type == type,]
  }
  as.character(filtered_palettes$name)
}
