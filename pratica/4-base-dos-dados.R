library(dplyr)
library(bigrquery)

# seguindo exatamente o que tem no site

install.packages("basedosdados")
library("basedosdados")
# Defina o seu projeto no Google Cloud
set_billing_id("<YOUR_PROJECT_ID>")
# Para carregar o dado direto no R
query <- "SELECT * FROM `basedosdados.br_inep_ideb.escola`"
df <- read_sql(query)

id_conta_do_google <- "live-curso-r-bd-2"

con <- dbConnect(
  bigquery(),
  "basedosdados",
  dataset = "br_inep_ideb",
  billing = id_conta_do_google
)

escola_no_r_passo1 <- tbl(con, "escola") %>% 
  filter(sigla_uf == "SP") %>% 
  select(id_escola, sigla_uf, ano, id_municipio, ideb)

analise_direto_na_nuvem <- tbl(con, "escola") %>% 
  sample_n(size = 100)

analise_direto_na_nuvem

escola_no_r_passo1

escola_no_r_passo2 <- collect(escola_no_r_passo1)

escola_no_r_passo2

# tabela
escola <- tbl(con, "escola") %>%
  filter(sigla_uf == "SP") %>% 
  group_by(ano, estado_abrev, municipio) %>%
  summarise(ideb = mean(ideb, na.rm = TRUE)) %>%
  ungroup() %>%
  collect()

