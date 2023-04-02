library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

norms_chroma <- readRDS(file = "data/norms_chroma.RDS")
dists_chroma <- readRDS(file = "data/dists_chroma.RDS")
summary_chroma <- readRDS(file = "data/summary_chroma.RDS")
dark_horse_sleeping <- readRDS(file = "data/dark_horse_sleeping.RDS")

dark_horse_katy <- get_tidy_audio_analysis("4jbmgIyjGoXjY01XxatOx6") %>%
  select(segments) %>%
  unnest(segments) %>%
  select(start, duration, pitches)

dark_horse_dist <- compmus_long_distance(
  dark_horse_katy %>% mutate(pitches = map(pitches, compmus_normalise, norms_chroma[3])),
  dark_horse_sleeping %>% mutate(pitches = map(pitches, compmus_normalise, norms_chroma[3])),
  feature = pitches,
  method = dists_chroma[2]
)

dark_horse_plot <- dark_horse_dist %>%
  mutate(dark_horse_sleeping = xstart + xduration / 2,
         dark_horse_katy = ystart + yduration / 2) %>%
  ggplot(aes(x=dark_horse_sleeping, y=dark_horse_katy, fill=d)) +
  geom_tile(aes(width=xduration, height=yduration)) +
  coord_fixed() + 
  scale_x_continuous(breaks=c(16,51,89,123,163,192,209,221), labels=c("I knew you were", "So you wanna play with magic?", "Mark my words", "So you wanna play with magic?", "So you wanna play with magic?", "There's no going back (first time)", "There's no going back (last time)", "")) + 
  scale_y_continuous(breaks = c(15, 45, 80, 110, 139, 183, 210, 216), labels=c("I knew you were", "So you wanna play with magic?", "Mark my words", "So you wanna play with magic?", "Uh, she's a beast", "So you wanna play with magic?", "There's no going back", "")) + 
  scale_fill_viridis_c(option = "E", guide = "none") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1)) +
  labs(x = "Sleeping At Last", y = "Katy Perry")

saveRDS(object = dark_horse_plot, file = "data/dark_horse.RDS")