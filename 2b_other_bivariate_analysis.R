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

#sex vs enrollment in college
sex_enrolled <-YA_19_21 %>%
  ggplot(aes(x=collenrlft,fill=irsex)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Sex in College-Aged Adults", 
       y="Proportion",
       x="Full-Time College Enrollment",
       fill="Sex") +
  theme_light()
ggsave(sex_enrolled,filename="figures/2b_sex_enrolled.png",scale=1.3)

#income vs inpost college
income_inpost <- YA_19_21 %>%
  ggplot(aes(x=postin_coll,fill=income)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Income Groups vs Amount of College Completed", 
       y="Proportion",
       x="College Completion",
       fill="Family Income") +
  theme_light()
ggsave(income_inpost,filename="figures/2b_income_inpost.png",scale=1.3)

#sex vs inpost college
sex_inpost <-YA_19_21 %>%
  ggplot(aes(x=postin_coll,fill=irsex)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Sex vs Amount of College Completed", 
       y="Proportion",
       x="College Completion",
       fill="Sex") +
  theme_light()
ggsave(sex_enrolled,filename="figures/2b_sex_inpost.png",scale=1.3)

#k6 score vs year in school
YA_19_21 %>%
  ggplot(aes(x=eduschgrd2,y=k6scmon)) +
  geom_boxplot()
