library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

norms_chroma <- readRDS(file = "data/norms_chroma.RDS")

taste <- get_tidy_audio_analysis("6usFrqlplLLU9OUDq936iE") %>%
  select(segments) %>%
  unnest(segments) %>%
  select(start, duration, pitches)

taste_chrom <- taste |>
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

taste_plot <- ggplotly(taste_chrom)

saveRDS(object = taste_plot, file = "data/taste.RDS")