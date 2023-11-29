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

#micat vs year in school
grademicat <- YA_19_21 %>%
  filter(eduschgrd2=="12th grade"|
           eduschgrd2=="1st year"|
           eduschgrd2=="2nd or 3rd year"|
           eduschgrd2=="4th year or higher"|
           eduschgrd2=="Not in school") %>%
  ggplot(aes(x=eduschgrd2,fill=mi_cat_u)) + 
  geom_bar(position="fill") +
  labs(title="Grade in School vs Mental Illness Indicator",
       fill="Indicated Mental Illness",
       x="Grade",
       y="Proportion") +
  theme_light()

ggsave(grademicat,filename="figures/2b_grademicat.png",scale=1.5)

#collen vs stimrec
collen_stimrec <-YA_19_21 %>%
  filter(irstmnmrec!="Never") %>%
  ggplot(aes(x=collenrlft,fill=irstmnmrec)) +
  geom_bar(position="fill") +
  labs(title="Last Stimulant Use for Users by College Enrollment",
       x="College Enrollment",
       y="Proportion",
       fill="Last Stimulant Use") +
  theme_light()

ggsave(collen_stimrec,filename="figures/2b_collen_stimrec.png",scale=1.3)

#collen vs stimstudy
collen_stimstud <- YA_19_21 %>%
  filter(!is.na(stmrsstdy)) %>%
  ggplot(aes(x=collenrlft,fill=stmrsstdy)) +
  geom_bar(position="fill")+
  labs(title="Stimulant Use for Studying of Users by College Enrollment",
       x="College Enrollment",
       y="Proportion",
       fill="Last Used Stimulants to Study") +
  theme_light()
ggsave(collen_stimstud,filename="figures/2b_collen_stimstud.png",scale=1.3)

#stimstudy vs stim recency
stimstud_rec <- YA_19_21 %>%
  filter(!is.na(stmrsstdy)) %>%
  ggplot(aes(x=stmrsstdy,fill=irstmnmrec)) +
  geom_bar(position="fill")+
  labs(title="Stimulant Studing Use vs Recency of Use",
       x="Last Used Stimulants to Study",
       y="Proportion",
       fill="Last Stimulant Use") +
  theme_light()
ggsave(stimstud_rec,filename="figures/2b_stimstud_rec.png",scale=1.3)


