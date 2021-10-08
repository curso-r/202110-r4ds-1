# Objetivo: investigar descritivamente a base imdb

# carregar o tidyverse
library(tidyverse) 

# importar a base imdb.csv para o R, em um objeto chamado imdb
imdb <- read.csv("dados/imdb.csv")

# Estrutura da base (colunas)
str(imdb)

# Podemos ver também a estrutura da base usando o glimpse, do pacote dplyr
glimpse(imdb)

# Resumo de todas as variáveis
summary(imdb)

# Algumas funções não retornam o que esperamos quando 
# o vetor tem NA, por exemplo:
min(imdb$receita)

# Podemos remover os NAs em algumas funções com o argumento na.rm = TRUE

# valor mínimo do vetor
min(imdb$receita, na.rm = TRUE)

# valor máximo do vetor
max(imdb$receita, na.rm = TRUE)

# média do vetor
mean(imdb$receita, na.rm = TRUE)

# desvio padrão do vetor
sd(imdb$receita, na.rm = TRUE)

