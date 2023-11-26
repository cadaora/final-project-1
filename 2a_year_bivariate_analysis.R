# Final Project 2a_year_bivariate_analysis ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(ggthemes)
## load dataset
YA_19_21 <-read_rds("data/YA_clean_19_21.rds")

#average K6 score vs year
YA_19_21 %>%
  ggplot()