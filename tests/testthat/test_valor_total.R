context("Cálculo Valor Total") 

test_that("Valor total doacoes saida", {
  doacoes_destino <- readr::read_csv2(here::here("data", "doacoes-saida.csv"))
  expect_equal(doacoes_destino$VALOR_UNITARIO*doacoes_destino$QUANTIDADE, doacoes_destino$VALOR_TOTAL)
})


test_that("Valor total doacoes entrada", {
  doacoes_recebidas <- readr::read_csv2(here::here("data", "doacoes-entrada.csv"))
  expect_equal(doacoes_recebidas$VALOR_UNITARIO*doacoes_recebidas$QUANTIDADE, doacoes_recebidas$VALOR_TOTAL)
})
