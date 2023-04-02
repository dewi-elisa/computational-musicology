library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

corpus <- readRDS(file = "data/corpus.RDS")
theme <- readRDS(file = "data/theme.RDS")

plot <- ggplot(corpus) +
  geom_point(aes(x=valence, y=acousticness, size=danceability, color=instrumentalness, text=track.name), alpha=0.4, shape=21) +
  geom_rug(aes(x=valence, y=acousticness, color=instrumentalness)) +
  facet_grid(cols = vars(sleeping), labeller=as_labeller(c(`0`='Other songs', `1`='Sleeping At Last songs'))) +
  scale_color_distiller(palette='PuOr') + 
  scale_x_continuous(breaks=c(0,0.5,1),limits=c(0,1)) +
  scale_y_continuous(breaks=c(0,0.5,1), limits=c(0,1))

track_plot <- ggplotly(plot + theme)

saveRDS(object = track_plot, file = "data/track.RDS")