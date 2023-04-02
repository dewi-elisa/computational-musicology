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

corpus <- readRDS(file = "data/sleeping.RDS")
text <- corpus$track_name
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
word_cloud <- wordcloud2(data=df, size=5, ellipticity=0.5)

library(htmlwidgets) 
install.packages("webshot")
webshot::install_phantomjs()
library(wordcloud2)
saveWidget(word_cloud,"2.html",selfcontained = F)
webshot::webshot("2.html","2.png",vwidth = 1992, vheight = 1744, delay =10)

saveRDS(object = word_cloud, file = "data/word_sleeping.RDS")