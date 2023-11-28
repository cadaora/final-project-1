# Final Project 0b_data_cleaning ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(janitor)
##load datasets ----
YA_2021 <- read_rds(file="data/NSDUH_2021_YA.rds")
YA_2020 <- read_rds(file="data/NSDUH_2020_YA.rds")
YA_2019 <- read_rds(file="data/NSDUH_2019_YA.rds")

# bind-years, create year variable

YA_2021 <- YA_2021 %>%
  mutate(AGE3=case_when(AGE3==4 ~ 7,
                        AGE3==5 ~ 10,
                        AGE3==6 ~ 12)) %>%
  rename(MI_CAT_U = MICATPY,
         MHSUITHK=IRSUICTHNK,
         K6SCMON=KSSLR6MON, 
         SPDMON=SPDPSTMON, 
         K6SCMAX=KSSLR6MAX,
         SPDYR= SPDPSTYR,
         COLLENRLFT=ENRLCOLLFT2,
         AGE2=AGE3
         ) 

YA_19_21 <- bind_rows(YA_2021,YA_2020,YA_2019) %>%
  relocate(IRVAPNICREC, .after=IRSTMNMREC) %>%
  relocate(QUESTID2)

YA_19_21 <-YA_19_21 %>%
  separate_wider_regex(
    FILEDATE,
    patterns = c(
      "../../",
      year = "[0-9]+"
    )
  ) %>%
  mutate(year = as.numeric(year)-1)


#| label: convert variables

factor_yesno <- function(x) {
  fct_recode(factor(x, levels = c("1","2")),
             "Yes"="1",
             "No"="2") 
}
factor_recency <- function(x) {
  fct_recode(factor(x),
             "≤ 30 days"="1",
             "> 30 days, ≤ 12 months"="2",
             "> 12 months"="3",
             "Never"="9")
}
numeric_frequency <- function(x) {
  case_when(
    x == 91 ~ NA,
    x == 93 ~ 0,
    .default = x)
}
factor_ASDS <- function(x) {
  fct_recode(factor(x),
             "None"="1",
             "Mild"="2",
             "Moderate"="3",
             "Severe"="4",
             "Very Severe"="5")
}
#Alter NA in COLLENRLFT
YA_19_21<-YA_19_21 %>%
  mutate(COLLENRLFT=ifelse(is.na(COLLENRLFT),
                           3,
                           COLLENRLFT))
#convert variables
YA_19_21 <- YA_19_21 %>%
  mutate(
    across(c(STMRSSTDY,SPDMON,SPDYR, MHSUITHK,AMDEYR,GOVTPROG),factor_yesno),
    IRCIGRC = fct_recode(factor(IRCIGRC),
                         "≤ 30 days"="1",
                         "> 30 days, ≤ 12 months"="2",
                         "> 12 months, ≤ 3 years"="3",
                         "> 3 years"="4",
                         "Never"="9"),
    across(IRALCRC:IRVAPNICREC,factor_recency),
    across(IRCIGFM:IRSTMNM30FQ,numeric_frequency),
    MI_CAT_U = fct_recode(factor(MI_CAT_U),
                          "None"="0",
                          "Mild"="1",
                          "Moderate"="2",
                          "Serious"="3"),
    across(ASDSHOM2:ASDSSOC2,factor_ASDS),
    IRSEX = fct_recode(factor(IRSEX),
                       "Male"="1",
                       "Female"="2"),
    IREDUHIGHST2 = fct_recode(factor(IREDUHIGHST2),
                              "5th grade or less"="1",
                              "6th grade"="2",
                              "7th grade"="3",
                              "8th grade"="4",
                              "9th grade"="5",
                              "10th grade"="6",
                              "11th or 12th grade, no GED"="7",
                              "GED"="8",
                              "Some college"="9",
                              "Associate's degree"="10",
                              "College graduate or higher"="11"),
    AGE2 = fct_collapse(factor(AGE2),
                        "18-20"=c("7","8","9"),
                        "21-23"=c("10","11"),
                        "24-25"=c("12")),
    COLLENRLFT= fct_recode(factor(COLLENRLFT),
                           "Student 18-22"="1",
                           "Other 18-22"="2",
                           "Unknown or not 18-22"="3"),
    EDUSCHGRD2 = fct_recode(factor(EDUSCHGRD2),
                            "5th grade or lower"="1",
                            "6th grade"="2",
                            "7th grade"="3",
                            "8th grade"="4",
                            "9th grade"="5",
                            "10th grade"="6",
                            "11th grade"="7",
                            "12th grade"="8",
                            "1st year"="9",
                            "2nd or 3rd year"="10",
                            "4th year or higher"="11",
                            NULL="98",
                            "Not in school"="99"),
    INCOME = fct_recode(factor(INCOME),
                        "Less than $20,000"="1",
                        "$20,000 - 49,999"="2",
                        "$50,000 - 74,999"="3",
                        "$75,000 or more"="4"))


YA_19_21 <-YA_19_21 %>%
  clean_names()

#create post/in college variable
YA_19_21 <-YA_19_21 %>%
  mutate(postin_coll = factor(case_when(
    (eduschgrd2=="1st year"|
      eduschgrd2=="2nd or 3rd year"|
      eduschgrd2=="4th year or higher")&
      ireduhighst2 =="Some college" ~ "In College",
    ireduhighst2 =="College graduate or higher" ~ "Graduated",
    .default = "Neither"
  )),.after=eduschgrd2)

#write clean rds
YA_19_21 %>%
  write_rds("data/YA_clean_19_21.rds")
