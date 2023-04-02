library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

atom6 <- get_tidy_audio_analysis('4Hctp8jfbMwLTchI6o3vDc')
atom6_plot <- atom6 |>
  tempogram(window_size = 8, hop_size = 1, cyclic = TRUE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(x = "Time (s)", y = "Tempo (BPM)", title="Atom 6") +
  theme_classic() +
  theme(plot.title = element_text(size=6, hjust=0.5), axis.title=element_text(size=6))

saveRDS(object = atom6_plot, file = "data/atom6_cyclic.RDS")