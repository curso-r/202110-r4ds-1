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

tabela_da_nota_media_do_de_niro_por_ano <- imdb %>%
  filter(ator_1 == "Robert De Niro" |
         ator_2 == "Robert De Niro" |
         ator_3 == "Robert De Niro") %>% 
  group_by(ano) %>% 
  summarise(
    nota_media = mean(nota_imdb, na.rm = TRUE)
  )

ggplot(tabela_da_nota_media_do_de_niro_por_ano,
       aes(x = ano, y = nota_media)) +
  geom_line() +
  geom_point(color = 'red') +
  geom_col() +
  geom_point(color = 'red') 
  #geom_line()

# Colocando pontos no gráfico

# FAZER NO COMEÇO DA AULA  DO DIA 25/10

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

library(tidyr)
library(forcats)

imdb %>% 
  drop_na(diretor) %>% 
  count(diretor, sort = TRUE) %>% 
  head(10) %>% 
  mutate(diretor_fator = fct_reorder(diretor, n)) %>% 
  ggplot() +
  geom_col(aes(y = diretor_fator, x = n, fill = diretor_fator),
           color = "gray",
           alpha = 1,
           show.legend = FALSE) +
  scale_fill_viridis_d() +
  theme_light() +
  labs(x = "Número de filmes", y = "Diretor")


# Histogramas e boxplots --------------------------------------------------

# Histograma do lucro dos filmes do Steven Spielberg 

imdb_com_lucro <- imdb %>% 
  mutate(
    lucro = receita-orcamento
  )

imdb_com_lucro %>% 
  filter(diretor == "Steven Spielberg") %>% 
  ggplot(aes(x = lucro)) +
  geom_histogram()

# Arrumando o tamanho das bases

imdb_com_lucro %>% 
  filter(diretor == "Steven Spielberg") %>% 
  ggplot(aes(x = lucro)) + 
  geom_histogram(color = 'white', binwidth = 100000000)

imdb_com_lucro %>% 
  filter(diretor == "Steven Spielberg") %>% 
  ggplot(aes(x = lucro)) +
  geom_histogram(color = 'white', binwidth = 1000000)

# Boxplot do lucro dos filmes dos diretores
# fizeram mais de 15 filmes

contagem_filmes_diretor <- imdb_com_lucro %>% 
  filter(!is.na(diretor)) %>% 
  group_by(diretor) %>% 
  count(sort = TRUE) %>% 
  ungroup()

# jeito 1: TOP!

imdb_com_lucro %>% 
  filter(!is.na(diretor)) %>% 
  filter(diretor %in% contagem_filmes_diretor$diretor[1:5]) %>% 
  ggplot(aes(x = lucro, y= diretor)) + 
  geom_boxplot()

# jeito 2: usando join

imdb_com_lucro %>% 
  filter(!is.na(diretor)) %>% 
  left_join(contagem_filmes_diretor) %>% 
  filter(n > 15) %>% 
  ggplot(aes(x = lucro, y = diretor)) +
  geom_boxplot()

# jeito 3: 

# vamos lembras:

# o que é o count?

# isso aqui
imdb %>% 
  count(diretor)

# é igual a isso aqui
imdb %>% 
  group_by(diretor) %>% 
  summarise(n = n())

# a mesma lógica se aplica a
imdb %>% 
  group_by(diretor) %>% 
  # esse mutate funciona de modo parecido 
  # com o summarise
  mutate(
    n = n()
  ) %>% 
  filter(n > 15) %>% 
  ggplot(aes(x = lucro, y = diretor)) +
  geom_boxplot()

# jeito 4: RESUMIDAÇO

imdb_com_lucro %>% 
  filter(!is.na(diretor)) %>% 
  group_by(diretor) %>% 
  filter(n() > 15) %>% 
  ggplot(aes(x = lucro, y = diretor)) + 
  geom_boxplot()

# Ordenando pela mediana

library(forcats)

objeto_para_grafico <- imdb_com_lucro %>% 
  filter(!is.na(diretor)) %>% 
  group_by(diretor) %>% 
  mutate(
    lucro_mediano = median(lucro, na.rm = TRUE),
    n = n()
  ) %>% 
  ungroup() %>% 
  filter(n > 15) %>%
  mutate(diretor_fator = fct_reorder(diretor, lucro_mediano, na.rm = TRUE))

objeto_para_grafico %>% 
  select(diretor, diretor_fator)

objeto_para_grafico %>% 
  filter(!is.na(diretor)) %>% 
  ggplot(aes(x = lucro, y = diretor_fator)) + 
  geom_boxplot()

# Título e labels ---------------------------------------------------------

# Labels

p <- imdb_com_lucro %>% 
  ggplot(aes(x = orcamento, y = receita, color = lucro,
             size = lucro)) +
  geom_point() +
  labs(
    x = "Orçamento (Milhões de USD)",
    y = "Receita (Milhões de USD)",
    color = "Lucro (USD)",
    title = "Gráfico de dispersão",
    caption = "Fonte: IMDB acessado no dia ddmmYYYY em imdb.com",
    subtitle = "Muito filmes lucram"
  )

# Escalas

library(scales)

p_com_escala_certa <- p + 
  scale_x_continuous(
    breaks = seq(0, 300000000, 50000000),
    labels = label_comma(
      scale = 1/1000000,
      big.mark = ".", decimal.mark = ","),
  ) +
  scale_y_continuous(
    labels = label_comma(
      scale = 1/1000000,
      big.mark = ".", decimal.mark = ",")
  ) +
  scale_color_continuous(
    labels = label_comma(
      scale = 1/1000000,
      big.mark = ".", decimal.mark = ",")
  ) 

# Visão do gráfico

# e se eu quiser dar zoom?
p_com_escala_certa +
  coord_cartesian(xlim = c(0, 50000000), ylim = c(0, 500000000))

# Cores -------------------------------------------------------------------

# Escolhendo cores pelo nome

imdb %>% 
  count(diretor) %>% 
  filter(!is.na(diretor)) %>% 
  top_n(5, n) %>% 
  ggplot(aes(x = n, y = diretor, fill = diretor)) +
  geom_col() +
  scale_fill_manual(values = c("orange",
                                "royalblue",
                                "red",
                                "green",
                                "yellow"))

# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# Escolhendo pelo hexadecimal

imdb %>% 
  count(diretor) %>% 
  filter(!is.na(diretor)) %>% 
  top_n(5, n) %>% 
  ggplot(aes(x = n, y = diretor, fill = diretor)) +
  geom_col() +
  scale_fill_manual(values = c("#8080ff",
                               "#ff0000",
                               "#00cc00",
                               "#0099ff",
                               "#0000ff"))

# Mudando textos da legenda

imdb %>% 
  filter(!is.na(cor)) %>% 
  group_by(ano, cor) %>% 
  summarise(
    num_filmes = n()
  ) %>% 
  ggplot(aes(x = ano, y = num_filmes, col = cor)) +
  geom_line() +
  scale_color_discrete(
    labels = c("Preto e branco", "Colorido")
  )

# Definindo cores das formas geométricas

imdb %>% 
  ggplot(aes(x = orcamento, y = receita)) +
  geom_point() +
  geom_abline(col = 'red', size = 4, intercept = 0,
              slope = 1)
  #geom_smooth(method = 'lm')

# Tema --------------------------------------------------------------------

# Temas prontos

p_com_escala_certa +
  theme_minimal(20)
  #theme_bw()
  #theme_classic()
  #theme_dark()
  #theme_light()
  
# A função theme()

p_com_escala_certa +
  theme(
    plot.title = element_text(hjust = .5),
    legend.position = 'none'
  )
