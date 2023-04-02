library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

colors <- RColorBrewer::brewer.pal(7, "PuOr")

theme <- theme_minimal() +
  theme(panel.grid.minor=element_blank(),
        axis.line=element_line(), 
        plot.title = element_text(hjust = 0.5))

saveRDS(object = colors, file = "data/colors.RDS")
saveRDS(object = theme, file = "data/theme.RDS")