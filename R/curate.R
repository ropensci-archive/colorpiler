#' Palette metadata
#'
#' @export
colorpile_metadata <- function() {
  st <- env$st
  if (is.null(env$sha)) {
    env$sha <- github_colorpile_sha()
  }
  sha <- env$sha
  ok <- (st$exists("colorpile_sha", "internal") &&
         st$get("colorpile_sha", "internal") == sha)

  if (!ok) {
    path_zip <-
      download_file("https://github.com/ropenscilabs/colorpile/archive/master.zip")
    dest <- tempfile()
    unzip(path_zip, exdir = dest)
    on.exit({
      unlink(dest, recursive=TRUE)
      file.remove(path_zip)
    })

    ## This is the path we want:
    path <- file.path(dest, "colorpile-master", "palettes")
    re <- "\\.json$"
    files <- dir(path, pattern = re)

    pals <- sub(re, "", files)
    names(files) <- pals

    for (i in setdiff(pals, env$st$list())) {
      st$set(i, jsonlite::fromJSON(read_file(file.path(path, files[[i]]))))
    }

    st$set("contents", pals, "internal")

    data <- lapply(pals, st$get)

    schema <- jsonlite::fromJSON(read_file(
      system.file("schemas/palette.json", package="colorpiler")))
    type <- vapply(schema$properties, function(x) x$type, character(1))
    is_array <- type == "array"
    cols <- setdiff(names(type), "colors")

    data <- lapply(data, function(x) x[cols])

    f <- function(x) {
      if (is_array[[x]]) {
        I(lapply(data, "[[", x))
      } else {
        ## should use vapply and a bit more work
        sapply(data, "[[", x)
      }
    }

    ret <- as.data.frame(setNames(lapply(cols, f), cols),
                         stringsAsFactors=FALSE)
    st$set("metadata", ret, "internal")
    st$set("colorpile_sha", sha, "internal")
  }

  st$get("metadata", "internal")
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
#' search_colorpile(authors = "Cynthia Brewer", type = "diverging")
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
