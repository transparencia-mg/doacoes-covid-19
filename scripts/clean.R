library(magrittr); library(purrr); library(data.table); library(jsonlite)

source("scripts/lib/utils.R")

# If warn is two (or larger, coercible to integer), all warnings are turned into errors.
options(warn = 2) # getOption("warn")

datapackage <- read_json("datapackage.json")

input <- chuck(datapackage, "sources", 1, "path")

output <- datapackage$resources %>% map("path")

result <- input %>% read() %>% map(recode)

walk2(result, output, fwrite, sep = ";", dec = ",", bom = TRUE, na = "")
