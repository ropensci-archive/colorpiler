# colorpiler

[![Project Status: Abandoned – Initial development has started, but there has not yet been a stable, usable release; the project has been abandoned and the author(s) do not intend on continuing development.](https://www.repostatus.org/badges/latest/abandoned.svg)](https://www.repostatus.org/#abandoned)

Provides community-driven color palettes from https://github.com/ropenscilabs/colorpile

Installation:
```
devtools::install_github("ropenscilabs/colorpiler")
```

Usage:
```
library(ggplot2)
ggplot(mtcars, aes(x = mpg, y = hp, colour = factor(cyl))) +
  geom_point() +
  scale_colour_colorpile("Royal1")
```
