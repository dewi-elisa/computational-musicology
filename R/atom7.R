library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

atom7 <- get_tidy_audio_analysis('3KD3qVfZd6C7ERAaCYkhTn')
atom7_plot <- atom7 |>
  tempogram(window_size = 8, hop_size = 1, cyclic = TRUE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(x = "Time (s)", y = "Tempo (BPM)", title="Atom 7") +
  theme_classic() +
  theme(plot.title = element_text(size=6, hjust=0.5), axis.title=element_text(size=6))

saveRDS(object = atom7_plot, file = "data/atom7_cyclic.RDS")