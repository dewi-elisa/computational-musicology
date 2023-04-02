library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

norms_timbre <- readRDS(file = "data/norms_timbre.RDS")
dists_timbre <- readRDS(file = "data/dists_timbre.RDS")
summary_timbre <- readRDS(file = "data/summary_timbre.RDS")

taste2 <-
  get_tidy_audio_analysis("6usFrqlplLLU9OUDq936iE") |>
  compmus_align(bars, segments) |>
  select(bars) |>
  unnest(bars) |>
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = summary_chroma[4], norm = norms_chroma[3]
      )
  ) |>
  mutate(
    timbre =
      map(segments,
          compmus_summarise, timbre,
          method = summary_timbre[1]
      )
  )

self_sim <- bind_rows(
  taste2 |> 
    compmus_self_similarity(pitches, dists_chroma[1]) |> 
    mutate(d = d / max(d), type = "Chroma"),
  taste2 |> 
    compmus_self_similarity(timbre, dists_timbre[2]) |> 
    mutate(d = d / max(d), type = "Timbre")
) |>
  mutate() |> 
  ggplot(
    aes(
      x = xstart + xduration / 2,
      width = xduration,
      y = ystart + yduration / 2,
      height = yduration,
      fill = d
    )
  ) +
  geom_tile() +
  coord_fixed() +
  facet_wrap(~type) +
  scale_fill_viridis_c(option = "E", guide = "none") +
  theme_classic() + 
  labs(x = "", y = "")

self_sim_ggplotly <- ggplotly(self_sim, domain = list(x=c(0,1), y=c(0.6,1)))

parts <- data.frame(
  Chroma = c("0 - 23", "23 - 49", "49 - 72", "72 - 80", "80 - 148", ""), 
  Timbre = c("0 - 23", "23 - 72", "", "72 - 80", "80 - 84", "84 - 88"),
  Chroma2 = c("", "148 - 188", "188 - 251", "", "251 - 259", ""), 
  Timbre2 = c("88 - 148", "148 - 188", "188 - 215", "215 - 251", "251 - 259", ""))

parts_table <- plot_ly(
  type = 'table',
  domain = list(x=c(0,1), y=c(0,0.4)),
  header = list(values = c("Chroma", "Timbre", "Chroma", "Timbre")),
  cells = list(values = rbind(parts$Chroma, parts$Timbre, parts$Chroma2, parts$Timbre2), height=25)
)

taste2_plot <- subplot(self_sim_ggplotly, parts_table, nrows=2)

saveRDS(object = taste2_plot, file = "data/taste2.RDS")