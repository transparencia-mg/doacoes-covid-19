.PHONY: help all clean test sync build publish

#====================================================================
# PHONY TARGETS

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

all: clean sync publish # Limpeza, upload e sincronizacao git

clean: ## Limpeza data-raw/ para data/
	Rscript --verbose scripts/clean.R 2> logs/log.Rout

test: ## Executa testes
	Rscript --verbose tests/testthat.R 2> logs/log.Rout

build: ## Compilação datapackage.json para buid/
	Rscript --verbose scripts/build.R 2> logs/log.Rout

sync: ## Stage, commit e push das alterações
	git add -u
	git commit -m "Atualiza conjunto de dados"
	git push origin master

publish: ## Upload data/ para dados.mg.gov.br/
	Rscript --verbose scripts/publish.R 2> logs/log.Rout