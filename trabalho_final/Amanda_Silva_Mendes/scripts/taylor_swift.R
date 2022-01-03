# Abrir pacotes -----------------------------------------------------------

library(dplyr)
library(tidyverse)
library(ggplot2)
library(readr)
library(lubridate)
library(forcats)
library(grDevices)
library(ggrepel)
# library(extrafont)
# extrafont::font_import()
# extrafont::loadfonts()



# Importar tabela ---------------------------------------------------------

taylors_spotify <- read.csv("dados/taylorswift_spotify.csv")

# Explorar tabela ---------------------------------------------------------

View(taylors_spotify)
str(taylors_spotify)

# Criar coluna ano na tabela ts_spotify

ts_spotify <- taylors_spotify %>% 
mutate(as.Date(release_date, format("%Y-%m-%d"))) %>% 
  mutate(ano = year(release_date))

View(ts_spotify)
str(ts_spotify)

# Criar tabela com ano de cada álbum e quantidade de músicas

tabela1 <- ts_spotify %>% 
  group_by(ano, album) %>% 
  summarise(n = n_distinct(name)) %>% 
  rename(`Ano` = ano, `Álbum` = album, `Qunatidade de Músicas` = n)

# Popularidade ------------------------------------------------------------

## Popularidade por album

# Gráfico de Barras *** cola data de label****
cores <- grDevices::hcl.colors(n= 9, palette = 'Burg')

ts_spotify %>% 
  group_by(album) %>% 
  summarise(media_pop = mean(popularity)) %>%
  mutate(album = forcats::fct_reorder(album, media_pop)) %>% 
  ggplot() +
  geom_col(aes(x = media_pop, y = album), 
           fill = c("#E6959F", "#B74D6C", "#9C3E5D",
                    "#CB627B", "#67223F", "#D97C8C",
                    "#81304E",  "#FFC5C7",  "#F4ADB3"),
           show.legend = FALSE) +
  labs(x = "Popularidade", y = "Álbum",
  title = "Popularidade no Spotify",
  caption = "Fonte: Kaggle") +
  theme_minimal()

# Gárifico de linhas

lista_album <- c("Taylor Swift", "Speak Now (Deluxe Package)",
                 "Red (Deluxe Edition)", "1989 (Deluxe)",
                 "reputation", "Lover", 
                 "folklore (deluxe version)", 
                 "evermore (deluxe version)",
                 "Fearless (Taylor's Version)") 

ts_spotify %>% 
  group_by(ano, album) %>% 
  summarise(media_pop = mean(popularity)) %>%
  mutate(album = forcats::fct_reorder(album, media_pop)) %>% 
  ggplot(aes(x = ano, y = media_pop)) +
  geom_line(color = "#67223F") +
  scale_x_continuous(breaks = seq(2006, 2021, 2)) +
  scale_y_continuous(breaks = seq(0, 100, 20)) +
  coord_cartesian(xlim = c(2006, 2026), ylim = c(0, 100))+
  geom_point(color = "#67223F") +
  geom_label_repel(aes(label = album),
                   color = "black",
                   size = 3.1,
                   alpha = 0.8) +
  labs(x = "Ano de Lançamento", y = "Popularidade",
       title = "Popularidade no Spotify",
       caption = "Fonte: Kaggle") +
  theme_minimal()



## Popularidade e dançabilidade

ordem_cores_fortes <-  c("#67223F", "#81304E", "#9C3E5D",
                         "#B74D6C", "#CB627B", "#D97C8C",
                         "#E6959F", "#F4ADB3", "#FFC5C7")

ts_spotify %>% 
  filter(popularity != 0) %>% 
  group_by(name) %>% 
  ggplot() +
  geom_point(aes(x = popularity, y = danceability, color = album), size = 3) +
  scale_color_manual(values = ordem_cores_fortes,
                        breaks = c("Taylor Swift", "Speak Now (Deluxe Package)",
                                   "Red (Deluxe Edition)", "1989 (Deluxe)",
                                   "reputation", "Lover", 
                                   "folklore (deluxe version)", 
                                   "evermore (deluxe version)",
                                   "Fearless (Taylor's Version)")) +
  labs(x = "Popularidade", y = "Dançabilidade", color = "Álbum",
       title = "Popularidade x Dançabilidade",
       caption = "Fonte: Kaggle") +
  theme_minimal()

# versão com labels

destaque_danca <- ts_spotify %>% 
  select(name, danceability) %>%
  arrange(desc(danceability)) %>% 
  slice(1:3)

destaque_pop <- ts_spotify %>% 
  select(name,popularity) %>%
  arrange(desc(popularity)) %>% 
  slice(1:3)

destaque_danca_pop <- ts_spotify %>% 
  filter(name %in% c("Blank Space", "Shake It Off", "Lover",
                     "I Think He Knows", "Treacherous - Original Demo Recording",
                     "Cornelia Street"))

ts_spotify %>% 
  filter(popularity != 0) %>% 
  group_by(name) %>% 
  ggplot(aes(x = popularity, y = danceability, color = album)) +
  geom_point(size = 3) +
  scale_color_manual(values = ordem_cores_fortes,
                     breaks = c("Taylor Swift", "Speak Now (Deluxe Package)",
                                "Red (Deluxe Edition)", "1989 (Deluxe)",
                                "reputation", "Lover", 
                                "folklore (deluxe version)", 
                                "evermore (deluxe version)",
                                "Fearless (Taylor's Version)")) +
  geom_label_repel(data = destaque_danca_pop, 
                   aes(label = name), 
                   color = "black",
                   size = 3.1,
                   alpha = 0.8,
  ) +
  labs(x = "Popularidade", y = "Dançabilidade", 
       color = "Álbum",
       size = 3.1,
       title = "Popularidade x Dançabilidade",
       caption = "Fonte: Kaggle") +
  theme_minimal()


## Popularidade e energia

ts_spotify %>% 
  filter(popularity != 0) %>% 
  group_by(name) %>% 
  ggplot() +
  geom_point(aes(x = popularity, y = energy, color = album), size = 1.3) +
  facet_wrap(~ album, scales = "free") +
  scale_color_manual(values = ordem_cores_fortes,
                     breaks = c("Taylor Swift", "Speak Now (Deluxe Package)",
                                "Red (Deluxe Edition)", "1989 (Deluxe)",
                                "reputation", "Lover", 
                                "folklore (deluxe version)", 
                                "evermore (deluxe version)",
                                "Fearless (Taylor's Version)")) +
  labs(x = "Popularidade", y = "Energia", color = "Álbum",
       title = "Popularidade x Energia",
       caption = "Fonte: Kaggle") +
  theme_minimal()


# versão com labels

destaque_energia <- ts_spotify %>% 
  select(name,energy) %>%
  arrange(desc(energy)) %>% 
  slice(1:3)

destaque_energia_pop <- ts_spotify %>% 
  filter(name %in% c("Blank Space", "Shake It Off", "Lover",
                     "Haunted", "I'm Only Me When I'm With You", 
                     "Better Than Revenge"))


ts_spotify %>% 
  filter(popularity != 0) %>% 
  group_by(name) %>% 
  ggplot(aes(x = popularity, y = energy, color = album)) +
  geom_point(size = 3) +
  scale_color_manual(values = ordem_cores_fortes,
                     breaks = c("Taylor Swift", "Speak Now (Deluxe Package)",
                                "Red (Deluxe Edition)", "1989 (Deluxe)",
                                "reputation", "Lover", 
                                "folklore (deluxe version)", 
                                "evermore (deluxe version)",
                                "Fearless (Taylor's Version)")) +
  geom_label_repel(data = destaque_energia_pop, 
                   aes(label = name), 
                   color = "black",
                   size = 3.1,
                   alpha = 0.8) +
  labs(x = "Popularidade", y = "Energia", 
       color = "Álbum",
       size = 3.1,
       title = "Popularidade x Energia",
       caption = "Fonte: Kaggle") +
  theme_minimal()


# Versão por albúm
ts_spotify %>% 
  filter(popularity != 0) %>% 
  mutate(album = forcats::fct_reorder(album, ano)) %>%
  group_by(name) %>% 
  ggplot() +
  geom_point(aes(x = popularity, y = energy, color = album), 
             size = 2.6, 
             show.legend = FALSE) +
  facet_wrap(~ album, scales = "fixed") +
  scale_color_manual(values = ordem_cores_fortes) +
  labs(x = "Popularidade", y = "Energia", color = "Álbum",
       title = "Popularidade x Energia",
       caption = "Fonte: Kaggle") +
  theme_minimal()




# Batida ------------------------------------------------------------------






# Valência ----------------------------------------------------------------

# versão barras
ts_spotify %>% 
  group_by(ano, album) %>% 
  summarise(media_valencia = mean(valence)) %>%
  mutate(album = forcats::fct_reorder(album, ano)) %>% 
  ggplot(aes(x = media_valencia, y = album)) +
  geom_col(fill = ordem_cores_fortes,
           show.legend = FALSE) +
  geom_label(aes(label = ano),
            size = 2.6) +
  labs(x = "Valência", y = "Álbum",
       title = "Valência",
       caption = "Fonte: Kaggle") +
  theme_minimal()


# versão boxplot
ts_spotify %>% 
  mutate(album = forcats::fct_reorder(album, ano)) %>%
  group_by(album) %>% 
  ggplot() +
  geom_boxplot(aes(x = valence, y = album),
    fill = ordem_cores_fortes, color = "#636363") +
  labs(x = "Valência", y = "Álbuns",
       title = "Valência x Álbum",
       caption = "Fonte: Kaggle") +
  theme_minimal()

# valência e acusticidade por álbum

ts_spotify %>% 
  mutate(album = forcats::fct_reorder(album, ano)) %>%
  group_by(name) %>% 
  ggplot() +
  geom_point(aes(x = acousticness, y = valence, color = album), 
             size = 2.6, 
             show.legend = FALSE) +
  facet_wrap(~ album, scales = "fixed") +
  scale_color_manual(values = ordem_cores_fortes) +
  labs(x = "Nível de acusticidade", y = "Valência", color = "Álbum",
       title = "Acústica x Valência",
       caption = "Fonte: Kaggle") +
  theme_minimal()

# Valência x Acústica Folklore e evermore



destaque_folklore_evermore <-  ts_spotify %>% 
  filter(name %in%  c("my tears ricochet", 
                      "seven", "this is me trying",
                      "epiphany",  "peace", 
                      "the lakes - bonus track",
                      "champagne problems",
                      "tolerate it", 
                      "happiness", 
                      "coney island (feat. The National)", 
                      "ivy", "cowboy like me", 
                      "evermore (feat. Bon Iver)"))

ts_spotify %>% 
  filter(album %in% c("folklore (deluxe version)", 
                      "evermore (deluxe version)")) %>% 
  ggplot(aes(x = acousticness, y = valence, color = album)) +
  geom_point(size = 2.6, 
             show.legend = FALSE) +
  scale_color_manual(values = c("#67223F", "#B74D6C"))+ 
  geom_label_repel(data = destaque_folklore_evermore, 
                   aes(label = name), 
                   color = "black",
                   size = 3.1,
                   alpha = 0.8)+ 
  labs(x = "Nível de acusticidade", y = "Valência", color = "Álbum",
       title = "Acústica x Valência",
       caption = "Fonte: Kaggle") +
  theme_minimal()




# Duração das músicas -----------------------------------------------------

# Versão boxplot

ts_spotify %>% 
  mutate(album = forcats::fct_reorder(album, ano)) %>%
  group_by(album) %>% 
  ggplot() +
  geom_boxplot(aes(x = length, y = album),
               fill = ordem_cores_fortes, color = "#636363") +
  labs(x = "Tempo(ms)", y = "Álbuns",
       title = "Tempo de Álbum",
       caption = "Fonte: Kaggle") +
  theme_minimal()

# versão barras
ts_spotify %>% 
  group_by(ano, album) %>% 
  summarise(media_duracao = mean(length)) %>%
  mutate(album = forcats::fct_reorder(album, ano)) %>% 
  ggplot() +
  geom_col(aes(x = media_duracao, y = album), 
           fill = ordem_cores_fortes,
           show.legend = FALSE) +
  labs(x = "Tempo (ms)", y = "Álbum",
       title = "Duração das músicas",
       caption = "Fonte: Kaggle") +
  theme_minimal()





# theme(plot.title = element_text(hjust = 0.5), # h just altera a posição do titulo
 # plot.subtitle = element_text(hjust = 0.5)

# theme(legend.position = "bottom")

