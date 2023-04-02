library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)

norms_chroma <- list("euclidean", "manhattan", "chebyshev")
dists_chroma <- list("manhattan", "aitchison", "cosine", "angular")
summary_chroma <- list("mean", "aitchison_centre", "root_mean_square", "max")

saveRDS(object = norms_chroma, file = "data/norms_chroma.RDS")
saveRDS(object = dists_chroma, file = "data/dists_chroma.RDS")
saveRDS(object = summary_chroma, file = "data/summary_chroma.RDS")