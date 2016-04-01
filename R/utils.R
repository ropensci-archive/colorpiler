drop_null <- function(x) {
  x[!vapply(x, is.null, logical(1))]
}

read_file <- function(x) {
  readChar(x, file.size(x))
}

download_file <- function(url, ..., dest=tempfile(), overwrite=FALSE) {
  oo <- options(warnPartialMatchArgs = FALSE)
  if (isTRUE(oo$warnPartialMatchArgs)) {
    on.exit(options(oo))
  }
  content <- httr::GET(url,
                       httr::write_disk(dest, overwrite),
                       httr::progress("down"), ...)
  if (httr::status_code(content) != 200L) {
    stop(DownloadError(content))
  }
  dest
}

DownloadError <- function(url, code) {
  msg <- sprintf("Downloading %s failed with code %d", url, code)
  structure(list(message=msg, call=NULL),
            class=c("DownloadError", "error", "condition"))
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

github_colorpile_sha <- function() {
  url <-
    "https://api.github.com/repos/ropenscilabs/colorpile/commits/master"
  r <- httr::GET(url)
  httr::stop_for_status(r)
  txt <- httr::content(r, "text")
  jsonlite::fromJSON(txt, FALSE)$sha
}
