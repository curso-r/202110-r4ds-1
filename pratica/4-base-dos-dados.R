library(dplyr)
library(bigrquery)
library(dplyr)

id_conta_do_google <- "live-curso-r-bd-2"

con <- dbConnect(
  bigquery(),
  "basedosdados",
  dataset = "br_inep_ideb",
  billing = id_conta_do_google
)

# tabela
escola <- tbl(conexao_ideb, "escola") %>%
  filter(sigla_uf == "SP") %>% 
  group_by(ano, estado_abrev, municipio) %>%
  summarise(ideb = mean(ideb, na.rm = TRUE)) %>%
  ungroup() %>%
  collect()

