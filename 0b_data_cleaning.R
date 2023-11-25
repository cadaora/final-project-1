# Final Project 0b_data_cleaning ----
# Stat 301-1

## load packages ----
library(tidyverse)

# creating clean dataset -----
YA_2021 <- read_rds(file="data/NSDUH_2021_YA.rds")
YA_2020 <- read_rds(file="data/NSDUH_2020_YA.rds")
YA_2019 <- read_rds(file="data/NSDUH_2019_YA.rds")

# bind-years, create year and incollege variable
YA_2021 <- YA_2021 %>%
  rename(MI_CAT_U = MICATPY)

YA_19_21 <- bind_rows(YA_2021,YA_2020,YA_2019) %>%
  relocate(IRVAPNICREC, .after=IRSTMNMREC)

YA_19_21 <-YA_19_21 %>%
  separate_wider_regex(
    FILEDATE,
    patterns = c(
      "../../",
      year = "[0-9]+"
    )
  ) %>%
  mutate(year = as.numeric(year)-1)

YA_19_21 <-YA_19_21 %>%
  mutate(incollege = ifelse(EDUSCHGRD2==9|EDUSCHGRD2==10|EDUSCHGRD2==11,
                            "Enrolled",
                            "Not Enrolled"))