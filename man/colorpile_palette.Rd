% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/colorpile.R
\name{colorpile_palette}
\alias{colorpile_palette}
\alias{colorpile_palette_data}
\title{colorpile palette}
\usage{
colorpile_palette(palette_name)

colorpile_palette_data(palette_name)
}
\arguments{
\item{palette_name}{Name of palette.}
}
\description{
colorpile palette
}
\examples{
if (requireNamespace("scales", quietly = TRUE)) {
  library(scales)
  show_col(colorpile_palette("Royal1")(4))
}
}

