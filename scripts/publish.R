source("scripts/lib/utils.R")

datapackage <- jsonlite::read_json("datapackage.json")

id <- datapackage$resources %>% purrr::map_chr("id")
output <- datapackage$resources %>% purrr::map_chr("path")

res <- purrr::map2(id, output, ckanr::resource_update, 
                  url = Sys.getenv("DADOSMG_DEV_HOST"), 
                  key = Sys.getenv("DADOSMG_DEV"))

map2(output, purrr::map(res, "url"), check_upload)
