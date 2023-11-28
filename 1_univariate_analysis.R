# Final Project 1_univariate_analysis ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(ggthemes)
## load dataset
YA_19_21 <-read_rds("data/YA_clean_19_21.rds")

#year count
yearcount <- YA_19_21 %>%
  ggplot(aes(year)) + 
  geom_bar(fill="plum4") + 
  labs(title="Young Adult Observations from Each Year",x="Year",y="Count") +
  theme_light()

ggsave(yearcount,filename="figures/1_yearcount.png")

#sex count
sexcount <-YA_19_21 %>%
  ggplot(aes(x=irsex)) + 
  geom_bar(fill="plum4") + 
  labs(title="Young Adult Observations by Sex",x="Sex",y="Count") +
  theme_light()

ggsave(sexcount,filename="figures/1_sexcount.png")

#income count
incomecount <- YA_19_21 %>%
  ggplot(aes(income)) + 
  geom_bar(fill="plum4") + 
  labs(title="Young Adult Observations by Income",x="Income",y="Count") +
  theme_light()

ggsave(incomecount,filename="figures/1_incomecount.png",scale=1.3)

#alcohol frequency month
alcmonth <- YA_19_21 %>%
  ggplot(aes(iralcfm)) + 
  geom_histogram(fill="plum4") + 
  labs(title="Distribution of Monthly Alcohol Use Among Young Adults",x= "Times Drank in Past Month",y="Count") +
  theme_light()

ggsave(alcmonth,filename="figures/1_alcmonth.png")

#marijuana frequency month
mjmonth <-YA_19_21 %>%
  ggplot(aes(irmjfm)) + 
  geom_histogram(fill="plum4") + 
  labs(title="Distribution of Monthly Marijuana Use Among Young Adults",x= "Times Used in Past Month",y="Count") +
  theme_light()

ggsave(mjmonth,filename="figures/1_mjmonth.png")

