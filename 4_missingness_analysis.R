# Final Project 4_missingness_analysis ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(ggthemes)

##load datasets ----
YA_2021 <- read_rds(file="data/NSDUH_2021_YA.rds")
YA_2020 <- read_rds(file="data/NSDUH_2020_YA.rds")
YA_2019 <- read_rds(file="data/NSDUH_2019_YA.rds")

# bind-years, create year and incollege variable
YA_2021 <- YA_2021 %>%
  rename(MI_CAT_U = MICATPY,
         MHSUITHK=IRSUICTHNK,
         K6SCMON=KSSLR6MON, 
         SPDMON=SPDPSTMON, 
         K6SCYR=KSSLR6YR, 
         K6SCMAX=KSSLR6MAX,
         SPDYR= SPDPSTYR
  )

YA_19_21_unclean <- bind_rows(YA_2021,YA_2020,YA_2019) %>%
  relocate(IRVAPNICREC, .after=IRSTMNMREC)

YA_19_21_unclean <-YA_19_21_unclean %>%
  separate_wider_regex(
    FILEDATE,
    patterns = c(
      "../../",
      year = "[0-9]+"
    )
  ) %>%
  mutate(year = as.numeric(year)-1)

YA_19_21_unclean <-YA_19_21_unclean %>%
  mutate(incollege = ifelse(EDUSCHGRD2==9|EDUSCHGRD2==10|EDUSCHGRD2==11,
                            "Enrolled",
                            "Not Enrolled"))

#missingness before factorizing variables, checking IRVAPNICREC only missing in 2019

YA_19_21_unclean %>%
  miss_var_summary(order = TRUE) %>%
  slice_head(n=10) %>%
  kable()

YA_19_21_unclean %>%
  group_by(year) %>%
  miss_var_summary() %>%
  filter(variable=="IRVAPNICREC"|variable=="K6SCYR") %>%
  kable()

#missingness after factorizing variables, eduschgrd2 fix

missingafterfactor <-YA_19_21 %>%
  gg_miss_var() + 
  labs(title="Missingness After Factorizing") +
  theme_light()

  ggsave(missingafterfactor, filename="figures/4_missingafterfactor.png")

YA_19_21 %>%
  group_by(year) %>%
  miss_var_summary() %>%
  filter(variable=="eduschgrd2") %>%
  kable()


