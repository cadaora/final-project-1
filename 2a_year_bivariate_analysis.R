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




#suicidal thoughts vs year
suithk_year <- YA_19_21 %>%
  filter(!is.na(mhsuithk)) %>%
  ggplot(aes(x=year,fill=mhsuithk)) + 
  geom_bar(position="fill") +
  labs(title="Young Adults (18-25) Reporting Suicidal Thoughts in Past Year from 2019-2021",
       x="Year",
       y="Proportion",
       fill="Suicidal Thoughts") +
  theme_light()

ggsave(suithk_year,filename="figures/2a_suithk_year.png")

#SDShome year
sdshome_year <- YA_19_21 %>%
  filter(!is.na(asdshom2)) %>%
  ggplot(aes(x=year,fill=asdshom2)) +
  geom_bar(position="fill") +
  labs(title="Functional Impairment in Home Tasks for Young Adults",
       x="Year",
       y="Proportion") + 
  theme_light()
ggsave(sdshome_year,filename="figures/2a_sdshome_year.png",scale=1.3)

#SDSwork year
sdswork_year <- YA_19_21 %>%
  filter(!is.na(asdswrk2)) %>%
  ggplot(aes(x=year,fill=asdswrk2)) +
  geom_bar(position="fill") +
  labs(title="Functional Impairment in Work Tasks for Young Adults",
       x="Year",
       y="Proportion")+ 
  theme_light()
ggsave(sdswork_year,filename="figures/2a_sdswork_year.png",scale=1.3)

#SDS close relationships year
sdsrel_year <- YA_19_21 %>%
  filter(!is.na(asdsrel2)) %>%
  ggplot(aes(x=year,fill=asdsrel2)) +
  geom_bar(position="fill") +
  labs(title="Functional Impairment in Relationships for Young Adults",
       x="Year",
       y="Proportion")+ 
  theme_light()
ggsave(sdsrel_year,filename="figures/2a_sdsrel_year.png",scale=1.3)

#SDS social year
sdssoc_year <- YA_19_21 %>%
  filter(!is.na(asdssoc2)) %>%
  ggplot(aes(x=year,fill=asdssoc2)) +
  geom_bar(position="fill") +
  labs(title="Functional Impairment in Social Life for Young Adults",
       x="Year",
       y="Proportion")+ 
  theme_light()
ggsave(sdssoc_year,filename="figures/2a_sdssoc_year.png",scale=1.3)
