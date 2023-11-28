# Final Project 3_multivariate_analysis ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(ggthemes)
## load dataset
YA_19_21 <-read_rds("data/YA_clean_19_21.rds")

#k6mon over year for grad/in
k6mon_comp_year <-YA_19_21 %>%
  filter(postin_coll!="Neither") %>%
  ggplot(aes(x=factor(year),y=k6scmon)) + 
  geom_boxplot() +
  facet_wrap(~postin_coll) +
  labs(title="Distribution of Current K6 Scores 2019-2021 vs College Completion",
       x="Year",
       y="K6 Score for Current Month") +
  theme_light()
ggsave(k6mon_comp_year,filename="figures/3_k6mon_comp_year.png", scale=1.3)
#k6max over year for grad/in
k6max_comp_year <- YA_19_21 %>%
  filter(postin_coll!="Neither") %>%
  ggplot(aes(x=factor(year),y=k6scmax)) + 
  geom_boxplot() +
  facet_wrap(~postin_coll) +
  labs(title="Distribution of Worst K6 Scores 2019-2021 vs College Completion",
       x="Year",
       y="K6 Score for Worst Month")+
  theme_light()
ggsave(k6max_comp_year,filename="figures/3_k6max_comp_year.png", scale=1.3)

#k6mon over year for ft
k6mon_ft_year <- YA_19_21 %>%
  filter(collenrlft!="Unknown or not 18-22") %>%
  ggplot(aes(x=factor(year),y=k6scmon)) + 
  geom_boxplot() +
  facet_wrap(~collenrlft) +
  labs(title="Distribution of Worst K6 Scores 2019-2021 for College-Aged Adults",
       x="Year",
       y="K6 Score for Worst Month")+
  theme_light()
ggsave(k6mon_ft_year,filename="figures/3_k6mon_ft_year.png", scale=1.3)
#k6max over year for ft
k6max_ft_year <- YA_19_21 %>%
  filter(collenrlft!="Unknown or not 18-22") %>%
  ggplot(aes(x=factor(year),y=k6scmax)) + 
  geom_boxplot() +
  facet_wrap(~collenrlft) +
  labs(title="Distribution of Worst K6 Scores 2019-2021 for College-Aged Adults",
       x="Year",
       y="K6 Score for Worst Month")+
  theme_light()
ggsave(k6max_ft_year,filename="figures/3_k6max_ft_year.png", scale=1.3)
