library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

norms_timbre <- list("euclidean", "manhattan", "chebyshev")
dists_timbre <- list("euclidean", "cosine", "angular")
summary_timbre <- list("mean", "root_mean_square")

saveRDS(object = norms_timbre, file = "data/norms_timbre.RDS")
saveRDS(object = dists_timbre, file = "data/dists_timbre.RDS")
saveRDS(object = summary_timbre, file = "data/summary_timbre.RDS")
