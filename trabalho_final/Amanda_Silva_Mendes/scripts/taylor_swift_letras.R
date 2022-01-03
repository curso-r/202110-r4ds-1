# Abrir pacotes -----------------------------------------------------------

library(dplyr)
library(tidyverse)
library(ggplot2)
library(readr)
library(lubridate)
library(forcats)
library(grDevices)
library(ggrepel)


# Importar tabela ---------------------------------------------------------

ts_folklore <- read_csv("dados/taylorswift_folklore.csv")
ts_evermore <- read.csv("dados/taylorswift_evermore.csv")

# Explorar tabela ---------------------------------------------------------

View()
gilmpse()



# Letras em Folklore ------------------------------------------------------


cores_folklore <- c("#67223F", "#9C3E5D", "#CB627B", 
           "#D97C8C", "#E6959F", "#F4ADB3")


ts_folklore %>%
  group_by(track_title) %>% 
  filter(track_title %in% c("my tears ricochet", 
                            "seven", "this is me trying", 
                            "​epiphany",  "​peace", "​the lakes")) %>%
  count(lyric, track_title, sort = TRUE) %>%
  slice_max(n, n = 2) %>% 
  mutate(lyric = forcats::fct_reorder(lyric, track_title)) %>% 
  ggplot() +
  geom_col(aes(y = lyric, x = n, fill = track_title))+
  scale_fill_manual(values =  cores_folklore,
                    name = "Músicas Favoritas") +
  labs(x = "Quantidade de vezes repetidas", 
       y = "Letras",
       title = "Letras frequentes em folklore",
       subtitle = "Minhas favoritas") +
  theme(plot.title = element_text(hjust = 0.5),
        title = element_text(family = "Morden Love"),
        panel.grid.major = element_blank()) +
  theme_minimal()



# Letras em evermore ------------------------------------------------------


cores_evermore <- c("#67223F", "#9C3E5D", "#9C3E5D", "#CB627B", 
           "#D97C8C", "#E6959F", "#F4ADB3")


ts_evermore %>%
  group_by(track_title) %>% 
  filter(track_title %in% c("champagne problems",
                           "​tolerate it", "​happiness",
                            "​coney island", 
                            "​ivy", "cowboy like me", 
                            "​evermore")) %>%
  count(lyric, track_title, sort = TRUE) %>%
  slice_max(n, n = 2) %>% 
  mutate(lyric = forcats::fct_reorder(lyric, track_title)) %>% 
  ggplot() +
  geom_col(aes(y = lyric, x = n, fill = track_title))+
  scale_fill_manual(values =  cores_evermore,
                    name = "Músicas Favoritas") +
  labs(x = "Quantidade de vezes repetidas", 
       y = "Letras",
       title = "Letras frequentes em folklore",
       subtitle = "Minhas favoritas") +
  theme(plot.title = element_text(hjust = 0.5),
        title = element_text(family = "Morden Love"),
        panel.grid.major = element_blank()) +
  theme_minimal()






