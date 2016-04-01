env <- new.env(parent=emptyenv())

.onLoad <- function(libname, pkgname) {
  path <- rappdirs::user_data_dir("colorpiler")
  env$st <- storr::storr_external(storr::driver_rds(path),
                                  fetch_hook_colorpiler)
}
