library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

atom8 <- get_tidy_audio_analysis('3HOe1ZIcGx29Q8SGaYmDH2')
atom8_plot <- atom8 |>
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(x = "Time (s)", y = "Tempo (BPM)", title="Atom 8") +
  theme_classic() +
  theme(plot.title = element_text(size=6, hjust=0.5), axis.title=element_text(size=6))

saveRDS(object = atom8_plot, file = "data/atom8.RDS")