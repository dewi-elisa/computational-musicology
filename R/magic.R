library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

magic <- get_tidy_audio_analysis('3cBtANnJGopPaRMXCl3mV7')
magic_plot <- magic |>
  tempogram(window_size = 8, hop_size = 1, cyclic = TRUE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(x = "Time (s)", y = "Tempo (BPM)") +
  theme_classic()

saveRDS(object = magic_plot, file = "data/magic_cyclic.RDS")