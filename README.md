# colorpiler

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
