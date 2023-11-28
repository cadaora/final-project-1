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


#micat grade
YA_19_21 %>%
  filter(eduschgrd2=="12th grade"|
           eduschgrd2=="1st year"|
           eduschgrd2=="2nd or 3rd year"|
           eduschgrd2=="4th year or higher") %>%
  ggplot(aes(x=eduschgrd2,fill=mi_cat_u)) + geom_bar(position="fill")

YA_19_21 %>%
  filter(postin_coll=="In College") %>%
  ggplot(aes(x=year,fill=mhsuithk)) + geom_bar(position="fill")
