# Final Project 0a_data_collection ----
# Stat 301-1

## load packages ----
library(tidyverse)
library(readxl)
#load datasets ----
NSDUH_2021 <-read.delim(file="data/raw/NSDUH_2021_Tab.txt",na.strings = ".")
NSDUH_2020 <-read.delim(file="data/raw/NSDUH_2020_Tab.txt",na.strings = ".")
NSDUH_2019 <-read.delim(file="data/raw/NSDUH_2019_Tab.txt",na.strings = ".")

# write filtered young adult datasets -----

# list of comparable variables
comparability <- read_excel("data/raw/RDAS_Comparability.xlsx") %>%
  filter(!is.na(`2019-2020`)) %>%
  select(Variable) %>%
  deframe()


NSDUH_2021 %>%
  filter(CATAGE==2) %>%
  select((QUESTID2|FILEDATE|STMRSSTDY|#id,filedate,stimulant study
            IRCIGRC| IRALCRC| IRMJRC| IRCOCRC| IRPNRNMREC| IRSTMNMREC| #recency
            IRCIGFM| IRALCFM| IRALCBNG30D| IRMJFM|IRCOCFM| IRPNRNM30FQ| IRSTMNM30FQ|#freq in last month
            IRSUICTHNK| KSSLR6MON|SPDPSTMON| KSSLR6MAX|SPDPSTYR|MICATPY|#mental health
            AMDEYR|ASDSHOM2:ASDSSOC2| #adult depression
            IRSEX|IREDUHIGHST2|AGE3|ENRLCOLLFT2| EDUSCHGRD2|GOVTPROG| INCOME), #demographics         
         IRVAPNICREC) %>%              #vaping
  write_rds(file="data/NSDUH_2021_YA.rds")

NSDUH_2020 %>%
  filter(CATAGE==2) %>%
  select((FILEDATE|STMRSSTDY|
            IRCIGRC| IRALCRC| IRMJRC| IRCOCRC| IRPNRNMREC| IRSTMNMREC| 
            IRCIGFM| IRALCFM| IRALCBNG30D| IRMJFM|IRCOCFM| IRPNRNM30FQ| IRSTMNM30FQ|
            MHSUITHK|K6SCMON|SPDMON|K6SCMAX|SPDYR|MI_CAT_U|
            AMDEYR|ASDSHOM2:ASDSSOC2| 
            IRSEX|IREDUHIGHST2|AGE2|COLLENRLFT|EDUSCHGRD2|GOVTPROG| INCOME)&          
           any_of(comparability),
         IRVAPNICREC,
         QUESTID2) %>%
  write_rds(file="data/NSDUH_2020_YA.rds")

NSDUH_2019 %>%
  filter(CATAGE==2) %>%
  select((QUESTID2|FILEDATE|STMRSSTDY|
            IRCIGRC| IRALCRC| IRMJRC| IRCOCRC| IRPNRNMREC| IRSTMNMREC| 
            IRCIGFM| IRALCFM| IRALCBNG30D| IRMJFM|IRCOCFM| IRPNRNM30FQ| IRSTMNM30FQ|
            MHSUITHK|K6SCMON|SPDMON|K6SCMAX|SPDYR| MI_CAT_U|
            AMDEYR|ASDSHOM2:ASDSSOC2| 
            IRSEX|IREDUHIGHST2|AGE2| COLLENRLFT|EDUSCHGRD2|GOVTPROG| INCOME)&          
           any_of(comparability),
         QUESTID2) %>%
  write_rds(file="data/NSDUH_2019_YA.rds")
