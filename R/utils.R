drop_null <- function(x) {
  x[!vapply(x, is.null, logical(1))]
}

read_file <- function(x) {
  readChar(x, file.size(x))
}

download_file <- function(url, dest) {
  if (!isTRUE(unname(capabilities("libcurl")))) {
    stop("This package requires libcurl support in R to run")
  }
  code <- download.file(url, dest, method="libcurl")
  if (code != 0L) {
    stop("Error downloading file")
  }
  invisible(dest)
}
