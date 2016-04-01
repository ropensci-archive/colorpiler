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

subsample <- function(n, max) {
  if (n > max) {
    stop(sprintf("Too many colours selected (max is %d, requested %d)",
                 max, n))
  } else if (n == max) {
    seq_len(n)
  } else {
    as.integer(seq(1, max, length.out=n))
  }
}
