library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

colors <- readRDS(file = "data/colors.RDS")
theme <- readRDS(file = "data/theme.RDS")

corpus <- readRDS(file = "data/corpus.RDS") %>%
  mutate(track.duration_min = track.duration_ms / (1000 * 60))

duration_mean_sleeping <- corpus %>%
  filter(sleeping == 1) %>%
  summarize(mean = mean(track.duration_min))

duration_mean_other <- corpus %>%
  filter(sleeping == 0) %>%
  summarize(mean = mean(track.duration_min))

duration <- ggplot(corpus) + 
  geom_histogram(aes(track.duration_min, y=..density.., color=as.factor(sleeping), fill=as.factor(sleeping)), position="identity", lwd=0.2, alpha=0.6, binwidth=0.25) +
  geom_vline(xintercept=duration_mean_sleeping$mean, color=colors[7], linetype='dotdash') +
  geom_vline(xintercept=duration_mean_other$mean, color=colors[1], linetype='dotdash') +
  scale_color_manual(values=c(colors[1], colors[7]), labels = c("Other songs", "Sleeping At Last songs")) +
  scale_fill_manual(values=c(colors[2], colors[6]), labels = c("Other songs", "Sleeping At Last songs")) +
  labs(color='', fill='', x='Duration (min)', y='Relative density')

duration_plot <- duration + theme + theme(panel.grid = element_blank(), legend.position=c(0.8,0.8))

saveRDS(object = duration_plot, file = "data/duration.RDS")