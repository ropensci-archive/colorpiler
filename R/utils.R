drop_null <- function(x) {
  x[!vapply(x, is.null, logical(1))]
}

read_file <- function(x) {
  readChar(x, file.size(x))
}
