library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)
library(rpart.plot)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
library(tm)

corpus <- readRDS(file = "data/corpus.RDS")
text <- corpus$track.name
docs <- Corpus(VectorSource(text))

docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))

dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

set.seed(1234)
word_cloud <- wordcloud2(data=df, size=3)

saveRDS(object = word_cloud, file = "data/word.RDS")