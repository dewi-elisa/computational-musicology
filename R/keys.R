library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

colors <- readRDS(file = "data/colors.RDS")
theme <- readRDS(file = "data/theme.RDS")
corpus <- readRDS(file = "data/corpus.RDS")

labels <- c('C','C#/Db','D','D#/Eb','E','F','F#/Gb','G','G#/Ab','A','A#/Bb','B')

key <- ggplot(corpus) + 
  geom_histogram(aes(key, y=..density.., color=as.factor(sleeping), fill=as.factor(sleeping)), position="identity", lwd=0.2, alpha=0.6, binwidth=1) +
  scale_color_manual(values=c(colors[1], colors[7]), labels = c("Other songs", "Sleeping At Last songs")) +
  scale_fill_manual(values=c(colors[2], colors[6]), labels = c("Other songs", "Sleeping At Last songs")) +
  scale_x_continuous(breaks=0:11, labels=labels) +
  labs(color='', fill='', x='Key', y='Relative density')

key_plot <- key + theme + theme(panel.grid = element_blank(), legend.position=c(0.8,0.8))

saveRDS(object = key_plot, file = "data/keys.RDS")