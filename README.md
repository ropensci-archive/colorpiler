# farben

Provides community-driven color palettes from https://github.com/vsbuffalo/farbenfroh

Installation:
```
devtools::install_github("ropenscilabs/farben")
```

Usage:
```
library(ggplot2)
ggplot(mtcars, aes(x = mpg, y = hp, colour = factor(cyl))) +
  geom_point() +
  scale_colour_farben("wes_a_fave")
```
