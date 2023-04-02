library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

theme <- readRDS(file = "data/theme.RDS")
corpus <- readRDS(file = "data/corpus.RDS")
colors <- readRDS(file = "data/colors.RDS")

labels <- c('C','C#/Db','D','D#/Eb','E','F','F#/Gb','G','G#/Ab','A','A#/Bb','B')

tempo <- ggplot(corpus) + 
  geom_histogram(aes(tempo, y=..density.., color=as.factor(sleeping), fill=as.factor(sleeping)), position="identity", lwd=0.2, alpha=0.6, binwidth=10) +
  scale_color_manual(values=c(colors[1], colors[7]), labels = c("Other songs", "Sleeping At Last songs")) +
  scale_fill_manual(values=c(colors[2], colors[6]), labels = c("Other songs", "Sleeping At Last songs")) +
  labs(color='', fill='', x='Tempo', y='Relative density')

tempo_plot <- tempo + theme + theme(panel.grid = element_blank(), legend.position=c(0.8,0.9))

saveRDS(object = tempo_plot, file = "data/tempo.RDS")