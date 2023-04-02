library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

hearing <- get_tidy_audio_analysis('13Z3uZXTFpbLBZ8R1rTUKO')
hearing_plot <- hearing |>
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(x = "Time (s)", y = "Tempo (BPM)") +
  theme_classic()

saveRDS(object = hearing_plot, file = "data/hearing.RDS")