library(tidyverse)
library(spotifyr)
library(plotly)
library(compmus)
library(fontawesome)
library(gridExtra)
library(rpart)
library(rpart.plot)

corpus <- readRDS(file = "data/corpus.RDS")
prune_control <- rpart.control(maxdepth=5, minsplit=10)
corpus$sleeping <- ifelse(corpus$sleeping == 1, "Sleeping At Last", "Other")

N <- (nrow(corpus) %/% 10)*9
train <- corpus[1:N,]
test <- corpus[N:nrow(corpus),]

tree <- rpart(sleeping ~ danceability + valence + acousticness + instrumentalness + tempo + key, data=train, method="class", control=prune_control)

test$pred <- predict(tree, test[,-ncol(test)], type="class")
confusion_matrix <- table(test$pred, test$sleeping)
accuracy <- mean(test$pred == test$sleeping)

saveRDS(object = tree, file = "data/tree.RDS")
saveRDS(object = confusion_matrix, file = "data/confusion.RDS")
saveRDS(object = accuracy, file = "data/accuracy.RDS")
