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

#month by drug per year coll complete
mondrugcomp <- YA_19_21 %>%
  filter(postin_coll!="Neither")%>%
  pivot_longer(
    cols = contains("fm"),
    names_to = "drug",
    values_to = "frequency"
  ) %>%
  group_by(drug,year,postin_coll) %>%
  summarise(meanfq = mean(frequency,na.rm=TRUE)) %>%
  mutate(drug=fct_recode(factor(drug),
                         "Alcohol"="iralcfm",
                         "Cigarettes"="ircigfm",
                         "Cocaine"="ircocfm",
                         "Marijuana"="irmjfm")) %>%
  ggplot(aes(x=year,y=meanfq,color=drug)) +
  geom_line() +
  scale_x_continuous(breaks = c(2019, 2020,2021)) +
  facet_wrap(~postin_coll) +
  labs(title="Monthly Drug Use Among Graduated and In College from 2019-2021",
       x="Year",
       y="Average Times Used in Past Month",
       color="Drug") +
  theme_light()
ggsave(mondrugcomp,filename="figures/3_mondrugcomp.png",scale=1.3)

#month by drug per year 18-22
mondrugft <- YA_19_21 %>%
  filter(collenrlft!="Unknown or not 18-22")%>%
  pivot_longer(
    cols = contains("fm"),
    names_to = "drug",
    values_to = "frequency"
  ) %>%
  group_by(drug,year,collenrlft) %>%
  summarise(meanfq = mean(frequency,na.rm=TRUE)) %>%
  mutate(drug=fct_recode(factor(drug),
                         "Alcohol"="iralcfm",
                         "Cigarettes"="ircigfm",
                         "Cocaine"="ircocfm",
                         "Marijuana"="irmjfm")) %>%
  ggplot(aes(x=year,y=meanfq,color=drug)) +
  geom_line() +
  scale_x_continuous(breaks = c(2019, 2020,2021)) +
  facet_wrap(~collenrlft)+
  labs(title="Monthly Drug Use Among College Aged Adults from 2019-2021",
       x="Year",
       y="Average Times Used in Past Month",
       color="Drug") +
  theme_light()
ggsave(mondrugft,filename="figures/3_mondrugft.png",scale=1.3)

#vape without never

vapewonever <- YA_19_21 %>%
  filter(!is.na(irvapnicrec),irvapnicrec!="Never") %>%
  ggplot(aes(x=year,fill=irvapnicrec)) +
  geom_bar(position="fill") +
  scale_x_continuous(breaks = c(2020,2021)) + 
  facet_wrap(~postin_coll) +
  labs(title="Nicotine Vaping Recency in College Aged Adult Users",
       x="Year",
       y="Proportion",
       fill="Vaping Recency")+ 
  theme_light()
ggsave(vapewonever,filename="figures/3_vapewonever.png")
#vape with never
vapewnever <-YA_19_21 %>%
  filter(!is.na(irvapnicrec)) %>%
  ggplot(aes(x=year,fill=irvapnicrec)) +
  geom_bar(position="fill") +
  scale_x_continuous(breaks = c(2020,2021)) + 
  facet_wrap(~postin_coll)+
  labs(title="Nicotine Vaping Recency in College Aged Adults",
       x="Year",
       y="Proportion",
       fill="Vaping Recency")+ 
  theme_light()
ggsave(vapewnever,filename="figures/3_vapewnever.png")