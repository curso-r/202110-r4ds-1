# Carregar pacotes --------------------------------------------------------

library(tidyverse)
# aqui mora o ggplot2

# Ler base IMDB -----------------------------------------------------------

imdb <- read_rds("dados/imdb.rds")

imdb <- imdb %>% mutate(lucro = receita - orcamento)

# Gráfico de pontos (dispersão) -------------------------------------------

ggplot(imdb)

# Apenas o canvas
imdb %>% 
  ggplot()

# Salvando em um objeto
p <- imdb %>% 
  ggplot()

# Gráfico de dispersão da receita contra o orçamento
imdb %>% 
  ggplot() +
  geom_point(aes(x = orcamento, y = receita))

# Inserindo a reta x = y
imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita)) +
  geom_abline(intercept = 0, slope = 1, color = "red")

# Observe como cada elemento é uma camada do gráfico.
# Agora colocamos a camada da linha antes da camada
# dos pontos.
imdb %>%
  ggplot() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  geom_point(aes(x = orcamento, y = receita))

# Atribuindo a variável lucro aos pontos
imdb %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucro))

# Categorizando o lucro antes
imdb %>%
  mutate(
    lucrou = ifelse(lucro <= 0, "Não", "Sim")
  ) %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucrou))

# Salvando um gráfico em um arquivo
imdb %>%
  mutate(
    lucrou = ifelse(lucro <= 0, "Não", "Sim")
  ) %>%
  ggplot() +
  geom_point(aes(x = orcamento, y = receita, color = lucrou))

ggsave("meu_grafico.png", dpi = 300)


# Filosofia ---------------------------------------------------------------

# Um gráfico estatístico é uma representação visual dos dados 
# por meio de atributos estéticos (posição, cor, forma, 
# tamanho, ...) de formas geométricas (pontos, linhas,
# barras, ...). Leland Wilkinson, The Grammar of Graphics

# Layered grammar of graphics: cada elemento do 
# gráfico pode ser representado por uma camada e 
# um gráfico seria a sobreposição dessas camadas.
# Hadley Wickham, A layered grammar of graphics 

# Gráfico de linhas -------------------------------------------------------

# Nota média dos filmes ao longo dos anos

dados_que_vao_pro_grafico <- imdb %>% 
  group_by(ano) %>% 
  summarise(
    nota_media = mean(nota_imdb)
  )

# aqui embaixo vai o gráfico

dados_que_vao_pro_grafico %>% 
  ggplot() +
  geom_line(aes(x = ano, y = nota_media))

dados_que_vao_pro_grafico %>% 
  ggplot() +
  geom_point(aes(x = ano, y = nota_media))

# Número de filmes coloridos e preto e branco por ano 

imdb %>% 
  group_by(ano, cor) %>% 
  summarise(
    num_filmes = n()
  ) %>% 
  ggplot() +
  geom_line(aes(x = ano, y = num_filmes, group = cor))

# Nota média do Robert De Niro por ano

# Colocando pontos no gráfico

# Gráfico de barras -------------------------------------------------------

# Número de filmes dos diretores da base

imdb %>% 
  group_by(diretor) %>% 
  summarise(n = n())

imdb %>% 
  count(diretor)


imdb %>% 
  filter(!is.na(diretor)) %>% 
  #group_by(diretor) %>% 
  #summarise(
  #  num_filmes = n()
  #) %>% 
  #arrange(desc(num_filmes)) %>% 
  # esse código em cima é igual ao de baixo:
  count(diretor, sort = TRUE) %>% 
  head(10) %>% 
  ggplot() +
  geom_col(aes(y = diretor, x = n))

# Tirando NA e pintando as barras

# Invertendo as coordenadas
  
# Ordenando as barras

# Histogramas e boxplots --------------------------------------------------

# Histograma do lucro dos filmes do Steven Spielberg 

# Arrumando o tamanho das bases

# Boxplot do lucro dos filmes dos diretores
# fizeram mais de 15 filmes

# Ordenando pela mediana

# Título e labels ---------------------------------------------------------

# Labels

# Escalas

# Visão do gráfico

# Cores -------------------------------------------------------------------

# Escolhendo cores pelo nome

# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# Escolhendo pelo hexadecimal

# Mudando textos da legenda

# Definiando cores das formas geométricas

# Tema --------------------------------------------------------------------

# Temas prontos

# A função theme()
