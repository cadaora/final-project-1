# Final Project 2a_year_bivariate_analysis ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(ggthemes)
## load dataset
YA_19_21 <-read_rds("data/YA_clean_19_21.rds")

#sex vs year
sex_year <-YA_19_21 %>%
  ggplot(aes(x=year,fill=fct_relevel(irsex,"Female"))) + 
  geom_bar(position = "dodge") +
  labs(title="Count of Sex of Young Adults (18-25) from 2019-2021",
        subtitle="There have been more females than males every year",
        x="Year",
        y="Count",
       fill="Sex") +
  theme_light()
ggsave(sex_year,filename="figures/2a_sex_year.png")

YA_19_21 %>%
  group_by(year,irsex) %>%
  summarise(count=n())

#K6 vs year
YA_19_21 %>%
  filter(postin_coll=="In College") %>%
  ggplot(aes(x=factor(year),y=k6scmax)) + geom_boxplot()

YA_19_21 %>%
  filter(postin_coll=="In College") %>%
  ggplot(aes(x=year,fill=spdyr)) + geom_bar(position="fill")

YA_19_21 %>%
  filter(postin_coll=="In College") %>%
  ggplot(aes(x=year,fill=mhsuithk)) + geom_bar(position="fill")
