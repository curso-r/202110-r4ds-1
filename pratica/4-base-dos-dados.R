library(dplyr)
library(bigrquery)
library(dplyr)

id_conta_do_google <- "live-curso-r-bd-2"

con <- dbConnect(
  bigquery(),
  "basedosdados",
  dataset = "br_me_rais",
  billing = id_conta_do_google
)

# tabela
tabela_vinculos <- tbl(con, "microdados_vinculos") 

# aqui vira um data.frame normal
tabela_vinculos_no_r <- tabela_vinculos %>% 
  filter(id_municipio == "61778") %>% 
  select(ano, sigla_uf, tipo_vinculo, tipo_admissao, mes_admissao) %>% 
  collect()

