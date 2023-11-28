# Final Project 4_data_quality_analysis ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(ggthemes)

##load datasets ----
NSDUH_2021 <-read.delim(file="data/raw/NSDUH_2021_Tab.txt",na.strings = ".")
NSDUH_2020 <-read.delim(file="data/raw/NSDUH_2020_Tab.txt",na.strings = ".")
NSDUH_2019 <-read.delim(file="data/raw/NSDUH_2019_Tab.txt",na.strings = ".")


YA_2021 <- read_rds(file="data/NSDUH_2021_YA.rds")
YA_2020 <- read_rds(file="data/NSDUH_2020_YA.rds")
YA_2019 <- read_rds(file="data/NSDUH_2019_YA.rds")

# total observations by year
n_year <- tibble(
  year = 2019:2021,
  raw_count = c(0,0,0)
)
n_rawYA <- function(df) {
  curyear <-parse_number(deparse(substitute(df)))
  x <- curyear - 2018
  n_year[x,2] <<- nrow(df)
}
n_raw(NSDUH_2019)
n_raw(NSDUH_2020)
n_raw(NSDUH_2021)

totalobs <- n_year %>%
  ggplot(aes(x=year,y=raw_count)) + 
  geom_col(fill="plum4") +
  labs(title="Total NSDUH Observations by Year",
       subtitle="In 2020, there was a decrease in observations due to COVID-19",
       x="Year",
       y="Count") +
  theme_light()
ggsave(totalobs,filename="figures/4_totalobs.png",scale=1.3)

# bind-years, create year and incollege variable
YA_2021 <- YA_2021 %>%
  rename(MI_CAT_U = MICATPY,
         MHSUITHK=IRSUICTHNK,
         K6SCMON=KSSLR6MON, 
         SPDMON=SPDPSTMON, 
         K6SCYR=KSSLR6YR, 
         K6SCMAX=KSSLR6MAX,
         SPDYR= SPDPSTYR,
         COLLENRLFT=ENRLCOLLFT2,
         AGE2=AGE3
  )

YA_19_21_unfact <- bind_rows(YA_2021,YA_2020,YA_2019) %>%
  relocate(IRVAPNICREC, .after=IRSTMNMREC) %>%
  relocate(QUESTID2)

YA_19_21_unfact <-YA_19_21_unfact %>%
  separate_wider_regex(
    FILEDATE,
    patterns = c(
      "../../",
      year = "[0-9]+"
    )
  ) %>%
  mutate(year = as.numeric(year)-1)



#missingness before factorizing variables, checking IRVAPNICREC only missing in 2019

YA_19_21_unfact %>%
  miss_var_summary(order = TRUE) %>%
  slice_head(n=10) %>%
  kable()

YA_19_21_unfact %>%
  group_by(year) %>%
  miss_var_summary() %>%
  filter(variable=="IRVAPNICREC"|variable=="K6SCYR"|variable=="AGE2"|variable=="COLLENRLFT") %>%
  kable()

#missingness after factorizing variables

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


