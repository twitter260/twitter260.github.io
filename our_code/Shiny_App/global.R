##GLOBAL
library(rsconnect)
library(shiny)
library(shinyTime)
library(dplyr)
library(tidytext)
library(tidyverse)
library(scales)
library(wordcloud)


tweets <- read.csv(url("https://raw.githubusercontent.com/twitter260/twitter260.github.io/master/our_code/text_identities.csv"), stringsAsFactors = FALSE)
source("DateRoundFunction.R")
tweets$created <- myRound(tweets$created)

tokens <- unnest_tokens(tweets, word, text, to_lower = TRUE) %>%
  anti_join(stop_words)

#afinn assigns numeric value form -5 to 5 (-5 being most negative sentiment)
afinn_sentiments <- get_sentiments("afinn")

tokens_afinn_sentiment <- tokens %>%
  inner_join(afinn_sentiments) %>%
  group_by(id, created) %>%
  mutate(tweet_sentiment = mean(score)) 


cloud <- tokens_afinn_sentiment %>%
  select(word, created, id, score) %>%
  group_by(word, created) %>% 
  mutate(n = n()) %>%
  distinct(word, created, n, score)

cloud <- cloud %>% mutate(day = as.character(as.Date(created)), time = unlist(strsplit(created, " "))[2])
cloud <- cloud %>% mutate(hour = as.numeric(unlist(strsplit(time, ":"))[1]), minute = as.numeric(unlist(strsplit(time, ":"))[2]))
cloud <- cloud %>% ungroup

#get overall word counts for each 15 min interval
length(unique(cloud$created))
counts <- cloud %>% group_by(created) %>%
  summarize(count_15 = n())
cloud <- cloud %>% left_join(counts, by=c("created"))
#
cloud$rescaled <- rescale(cloud$count_15, to = c(2, 7))

#color
pal <- colorRampPalette(c("red", "yellow", "green"))



