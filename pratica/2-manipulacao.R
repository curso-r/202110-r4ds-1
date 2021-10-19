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



# analise massa x altura base star wars -----------------------------------

library(dplyr)

# library(magrittr)
# o pipe mora aqui ^

# estou fazendo a linha abaixo para que a base starwars que vem
# silenciosamente do pacote dplyr apareça na minha aba Environment
starwars <- dplyr::starwars

# meu primeiro objetivo vai ser calcular o peso (que na é verdade é masse) médio

tabela <- starwars %>% 
  summarise(peso_medio = mean(mass, na.rm = TRUE))

modelo <- lm(mpg~cyl, data = mtcars)
modelo

# install.packages("writexl")
library(writexl)

write_xlsx(tabela, "tabela_peso_medio.xlsx")

# install.packages("clipr")
library(clipr)

write_clip(tabela, dec = ",")
write_clip(mtcars, dec = ",")


# tabela do peso por sexo do personagem

tabela_peso_por_sexo <- starwars %>% 
  group_by(sex) %>% 
  summarise(peso_medio = mean(mass, na.rm = TRUE),
            numero_de_casos = n())

# se eu usasse não daria pra colocar o peso_medio...
starwars %>% 
  group_by(sex) %>% 
  count()

# se eu usasse o summarise com o n() teria o mesmo resultado,
# podendo expandir se eu quisesse
starwars %>% 
  group_by(sex) %>% 
  summarise(
    #n = n()
    n = n_distinct(name)
  )

tabela_peso_por_sexo

tabela_peso_por_sexo %>% 
  write_clip(dec = ",")

starwars %>%
  filter(is.na(sex)) %>% 
  View()

starwars_recodificada <- starwars %>% 
  mutate(
    sex_recodificada = case_when(
      is.na(sex) ~ "Está faltando",
      sex == "male" ~ "Masculino",
      sex == "female" ~ "Feminino",
      sex == "none" ~ "Não se aplica",
      sex == "hermaphroditic" ~ "Hermafrodita",
      TRUE ~ "Outros"
  ))

# com os nomes arrumadinhos fica assim:
starwars_recodificada %>% 
  group_by(sexo = sex_recodificada) %>% 
  summarise(
    peso_medio = mean(mass, na.rm = TRUE),
    altura_media = mean(height, na.rm = TRUE)
  ) %>% 
  write_clip(dec = ",")

# outro jeito
starwars_recodificada %>% 
  group_by(sex_recodificada) %>% 
  summarise(
    peso_medio = mean(mass, na.rm = TRUE),
    altura_media = mean(height, na.rm = TRUE)
  ) %>% 
  mutate(sexo = sex_recodificada) %>% 
  select(sexo, peso_medio, altura_media)

starwars_recodificada %>% 
  group_by(sex_recodificada) %>% 
  summarise(
    peso_medio = mean(mass, na.rm = TRUE),
    altura_media = mean(height, na.rm = TRUE)
  ) %>% 
  mutate(sexo = sex_recodificada) %>% 
  select(-sex_recodificada) %>% 
  select(sexo, everything())

starwars_recodificada %>% 
  mutate(
    peso = mass,
    peso_acima = lag(mass)
  ) %>% 
  select(name, peso, peso_acima)
  
