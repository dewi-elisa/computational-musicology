library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

corpus <- get_playlist_audio_features("", "3jblLN3iqoULSfQGHAFYVe")

sleeping_at_last_tracks <- get_artist_audio_features("sleeping at last")
corpus$sleeping <- ifelse(corpus$track.id %in% sleeping_at_last_tracks$track_id, 1, 0)

saveRDS(object = corpus, file = "data/corpus.RDS")
saveRDS(object = sleeping_at_last_tracks, file = "data/sleeping.RDS")