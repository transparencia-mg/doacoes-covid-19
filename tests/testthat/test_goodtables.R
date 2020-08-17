context("Cálculo Valor Total") 

test_that("Valor total doacoes destino (saida)", {
  library(reticulate)
  
  use_virtualenv("frictionless", required = TRUE)
  
  source_python(here::here("scripts", "lib", "utils.py"))
  
  report <- validate_(here::here("datapackage.json"))
  
  expect_true(report$valid)
})



