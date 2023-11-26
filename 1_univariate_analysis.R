# Final Project 1_univariate_analysis ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(ggthemes)
## load dataset
YA_19_21 <-read_rds("data/YA_clean_19_21.rds")

#year count
YA_19_21 %>%
  ggplot(aes(year)) + geom_bar(fill="plum4") + theme_fivethirtyeight()
