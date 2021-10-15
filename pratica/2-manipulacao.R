# Ler IMDB e gerar uma tabela com apenas as colunas titulo e ano,
# ordenada por ano

library(readxl)
library(dplyr)
library(writexl)
imdb <- read_excel("dados/imdb.xlsx")

# Crescente
imdb %>% 
  select(titulo, ano) %>% 
  arrange(ano)

# Descrescente
imdb_selecionado <- imdb %>% 
  select(titulo, ano) %>% 
  arrange(desc(ano))

# Salvar base
write_xlsx(imdb_selecionado, "dados_output/imdb_selecionado.xlsx")

# Outra forma
imdb %>% 
  select(titulo, ano) %>% 
  arrange(ano) %>% 
  write_xlsx("dados_output/imdb_selecionado.xlsx")


# -------------------------------------------------------------------------
# descobrir qual o filme mais caro e qual o filme 
# com melhor nota dos anos 2000

library(stringr)

# filtrar filmes anos 2000
imdb %>% 
  filter(ano >= 2000 & ano <=2010) %>% View()

# outra forma de fazer
imdb_anos_2000 <- imdb %>% 
  filter(ano %in% 2000:2010) 

# Filme mais caro
imdb_anos_2000 %>% 
  filter(orcamento == max(orcamento, na.rm = TRUE)) %>% View()

# outra forma
imdb_anos_2000 %>% 
  arrange(desc(orcamento)) %>% 
  slice(1)

# Melhor nota
imdb_anos_2000 %>% 
  filter(nota_imdb == max(nota_imdb, na.rm = TRUE)) %>% View()

# o que a gente fez
imdb %>% 
  filter(ano %in% 2000:2010) %>% 
  filter(nota_imdb == max(nota_imdb, na.rm = TRUE))

# da certo assim?
imdb %>% 
  filter(ano %in% 2000:2010 & nota_imdb == max(nota_imdb, na.rm = TRUE))
# NOOOOO

# -------------------------------------------------------------------------

# Duvida - como filtrar character
imdb %>% #distinct(titulo)
  filter(str_detect(titulo, "Pirates of th"))
