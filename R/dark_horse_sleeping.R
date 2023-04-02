library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

norms_chroma <- readRDS(file = "data/norms_chroma.RDS")
dists_chroma <- readRDS(file = "data/dists_chroma.RDS")
summary_chroma <- readRDS(file = "data/summary_chroma.RDS")

dark_horse_sleeping <- get_tidy_audio_analysis("1i5PW20LSYwCQMjVQgSXVM") %>%
  select(segments) %>%
  unnest(segments) %>%
  select(start, duration, pitches)

dark_horse_sleeping_plot <- dark_horse_sleeping |>
  mutate(pitches = map(pitches, compmus_normalise, norms_chroma[3])) |>
  compmus_gather_chroma() |> 
  ggplot(
    aes(
      x = start + duration / 2,
      width = duration,
      y = pitch_class,
      fill = value
    )
  ) +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  theme_minimal() +
  scale_fill_viridis_c()

saveRDS(object = dark_horse_sleeping, file = "data/dark_horse_sleeping.RDS")
saveRDS(object = dark_horse_sleeping_plot, file = "data/dark_horse_sleeping_plot.RDS")