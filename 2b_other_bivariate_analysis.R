# Final Project 2b_other_bivariate_analysis ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(ggthemes)
## load dataset
YA_19_21 <-read_rds("data/YA_clean_19_21.rds")


#income vs enrollment in college
income_enrolled <- YA_19_21 %>%
  ggplot(aes(x=collenrlft,fill=income)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Income Groups in College-Aged Adults", 
       y="Proportion",
       x="Full-Time College Enrollment",
       fill="Family Income") +
  theme_light()
ggsave(income_enrolled,filename="figures/2b_income_enrolled.png",scale=1.3)

#gov program vs enrollment in college
gov_enrolled <-YA_19_21 %>%
  ggplot(aes(x=collenrlft,fill=govtprog)) +
  geom_bar(position = "fill") +
  labs(title = "Use of Government Assistance Programs in College-Aged Adults", 
       y="Proportion",
       x="Full-Time College Enrollment",
       fill="Government Assistance") +
  theme_light()
ggsave(gov_enrolled,filename="figures/2b_gov_enrolled.png",scale=1.3)


