library(datapackage.r)

read <- function(path) {
  
  datapackage <- Package.load("datapackage.json", basePath = ".")
  
  col_names <- datapackage$resourceNames %>% 
    map(datapackage$getResource) %>% 
    map(~.$schema$fieldNames) %>% 
    map(unlist)
  
  cols_spec_entrada <- c(
    ITEM = "numeric",
    TIPO_DOACAO = "text",
    DOADOR = "text",
    CNPJ_DOADOR = "text",
    ORGAO_ENTIDADE = "text",
    CNPJ_ORGAO_ENTIDADE = "text",
    LOCAL_RECEBIMENTO = "text",
    DATA_DOACAO = "date",
    CLASSIFICACAO_PRODUTO = "text",
    PRODUTO = "text",
    UNIDADE_MEDIDA = "text",
    QUANTIDADE = "numeric",
    VALOR_UNITARIO = "numeric",
    VALOR_TOTAL = "numeric")
  
  cols_spec_saida <- c(
    ITEM = "numeric",
    DESTINATARIO_DOACAO = "text",
    CNPJ_DESTINATARIO_DOACAO = "text",
    DATA_ENTREGA = "date",
    CIDADE_DESTINATARIO = "text",
    PRODUTO = "text",
    QUANTIDADE = "numeric",
    UNIDADE_MEDIDA = "text",
    VALOR_UNITARIO = "numeric",
    VALOR_TOTAL = "numeric")
  
  cols_spec <- list(cols_spec_entrada, cols_spec_saida)
  
  sheets <- readxl::excel_sheets(path)
  
  return <- pmap(list(sheet = sheets, col_names = col_names, col_types = cols_spec),
                .f = readxl::read_excel, 
                path = path, skip = 1, na = c("-", ""))
  
  return
}

recode <- function(x) {
  
  return <- x %>% 
    dplyr::mutate_if(lubridate::is.POSIXct, lubridate::as_date)
  
  return
  
}

check_upload <- function(file, url) {
  file_hash <- digest::digest(file, file = TRUE)
  
  tmp <- tempfile()
  download.file(url, tmp)
  url_hash <- digest::digest(tmp, file = TRUE)
  unlink(tmp)  
  
  file_hash == url_hash
}
