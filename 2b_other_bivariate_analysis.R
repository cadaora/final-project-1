# Final Project 2b_other_bivariate_analysis ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(ggthemes)
## load dataset
YA_19_21 <-read_rds("data/YA_clean_19_21.rds")



YA_19_21 %>%
  ggplot(aes(x=collenrlft,fill=income)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Income Groups in Enrolled vs Not Enrolled", 
       x="Proportion",
       y="College Enrollment",
       fill="Family Income") +
  theme_light()
