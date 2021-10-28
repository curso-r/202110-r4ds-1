library(ggplot2)
library(tidyverse)

# theme_set(theme_minimal())

imdb_com_lucro <- read_rds("dados/imdb.rds") %>% 
  mutate(
    lucro = receita-orcamento
  )

imdb <- imdb_com_lucro

# ideia: posso fazer vários gráficos em uma mesma
# imagem?

imdb_com_lucro %>% 
  filter(!is.na(diretor)) %>% 
  group_by(ator_1) %>% 
  filter(n() > 25) %>% 
  ggplot(aes(x = orcamento, y = receita)) + 
  geom_point() +
  facet_wrap(~ator_1, scales = 'free')

# install.packages("patchwork")
library(patchwork)

p1 <- imdb %>% 
  filter(!is.na(diretor)) %>% 
  group_by(diretor) %>% 
  filter(n() > 15) %>% 
  ggplot(aes(x = orcamento, y = receita)) + 
  geom_point() + 
  labs(
    title = "Orçamento X Receita dos diretores com mais filmes"
  )

p2 <- imdb %>% 
  filter(!is.na(ator_1)) %>% 
  group_by(ator_1) %>% 
  filter(n() > 25) %>% 
  ggplot(aes(x = orcamento, y = receita)) + 
  geom_point() + 
  labs(
    title = "Orçamento X Receita dos atores com mais filmes"
  )

p_todos_os_filmes <- imdb %>% 
  ggplot(aes(x = orcamento, y = receita, text = titulo)) + 
  geom_point() + 
  labs(
    title = "Orçamento X Receita todos os filmes"
  )

# aqui entra o patchwork:
p1+p2
(p1/p2)

((p1/p2)|p_todos_os_filmes)

# ideia: quero destacar um ponto ou alguns pontos
# no meu gráfico?

filmes_para_destacar <- imdb %>% 
  filter(
     titulo %in% c("Titanic", "The Avengers")
  )

library(ggrepel)

imdb %>% 
  ggplot(aes(x = orcamento, y = receita)) +
  geom_point() +
  geom_point(data = filmes_para_destacar, aes(col = titulo),
             size = 3) + 
  geom_label_repel(data = filmes_para_destacar,
                   aes(label = titulo, col = titulo)) + 
  #geom_smooth(method = 'lm') + 
  theme_minimal()

# ideia: como desenhar curvas num histograma?

imdb

# como fazer um gráfico interativo?

library(plotly)

ggplotly(p_todos_os_filmes)
