library(testthat)

purrr:::walk(list.files("code/lib/", full.names = TRUE), source)

test_dir("tests/testthat/")
