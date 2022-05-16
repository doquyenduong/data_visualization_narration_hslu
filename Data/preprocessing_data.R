library(tidyverse)
library(readxl)
library("writexl")

# Prepocessing data before tableau
## Load two datasets
df1 <- read_excel("Appendix_2_Data_for_Figure_2.1_latest.xls")
glimpse(df1)

## Clean the * after country names to join later with the previous year
df1 <- df1 %>% 
  mutate(Country = str_remove_all(Country, "\\*"))

df2 <- read_excel("DataForFigure2.1WHR2021C2.xls")
df2

## Keeping region column from previous year data 
df3 <- df1 %>% 
  left_join(df2 %>% select(`Country name`, `Regional indicator`), 
                  by = c("Country" = "Country name")
                  )
## Check the new created dataframe
df3 %>% View()

## Remove NA row with country called xx
df3 <- df3 %>% 
  filter(!Country == "xx")

## Check again 
glimpse(df3)

## Export the file to excel file
write_xlsx(df3,"data_after_preprocess.xlsx")

