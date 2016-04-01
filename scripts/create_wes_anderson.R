wes_palettes <- list(
  GrandBudapest = c("#F1BB7B", "#FD6467", "#5B1A18", "#D67236"),
  Moonrise1 = c("#F3DF6C", "#CEAB07", "#D5D5D3", "#24281A"),
  Royal1 = c("#899DA4", "#C93312", "#FAEFD1", "#DC863B"),
  Moonrise2 = c("#798E87", "#C27D38", "#CCC591", "#29211F"),
  Cavalcanti = c("#D8B70A", "#02401B", "#A2A475", "#81A88D", "#972D15"),
  Royal2 = c("#9A8822", "#F5CDB4", "#F8AFA8", "#FDDDA0", "#74A089"),
  GrandBudapest2 = c("#E6A0C4", "#C6CDF7", "#D8A499", "#7294D4"),
  Moonrise3 = c("#85D4E3", "#F4B5BD", "#9C964A", "#CDC08C", "#FAD77B"),
  Chevalier = c("#446455", "#FDD262", "#D3DDDC", "#C7B19C"),
  Zissou = c("#3B9AB2", "#78B7C5", "#EBCC2A", "#E1AF00", "#F21A00"),
  FantasticFox = c("#DD8D29", "#E2D200", "#46ACC8", "#E58601", "#B40F20"),
  Darjeeling = c("#FF0000", "#00A08A", "#F2AD00", "#F98400", "#5BBCD6"),
  Rushmore = c("#E1BD6D", "#EABE94", "#0B775E", "#35274A" ,"#F2300F"),
  BottleRocket = c("#A42820", "#5F5647", "#9B110E", "#3F5151", "#4E2A1E", "#550307", "#0C1707"),
  Darjeeling2 = c("#ECCBAE", "#046C9A", "#D69C4E", "#ABDDDE", "#000000"),
  BottleRocket2 = c("#FAD510", "#CB2314", "#273046", "#354823", "#1E1E1E")
)

library(purrr)
walk(names(wes_palettes), function(wp) {
  create_palette(name = wp,
                 authors = "Karthik Ram",
                 github_user = "karthik",
                 description = "Palette generated mostly from 'Wes Anderson' movies.",
                 keywords = "",
                 colors = wes_palettes[[wp]],
                 type = "qualitative")
})



