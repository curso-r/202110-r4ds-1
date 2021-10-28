# ver a relação de peso e altura dos personagens

library(tidyverse)

starwars %>% 
  ggplot(aes(x = mass, y = height)) +
  geom_point()

starwars %>% 
  ggplot() +
  geom_point(aes(x = mass, y = height))

View(starwars)

starwars %>% 
  filter(mass < 500) %>% 
  ggplot() +
  geom_point(aes(x = mass, y = height, color = sex, size = height)) +
  labs(x = "Massa (kg)", y = "Altura (cm)", color = "Sexo",
       title = "Gráfico da relação entre altura e massa \n dos personagens"
  ) +
  theme_light()


# ------
# mananciais

library(readr)
library(lubridate)
mananciais <- read_delim("https://raw.githubusercontent.com/beatrizmilz/mananciais/master/inst/extdata/mananciais.csv", 
                         delim = ";", escape_double = FALSE, col_types = cols(data = col_date(format = "%Y-%m-%d")), 
                         locale = locale(decimal_mark = ",", grouping_mark = "."), 
                         trim_ws = TRUE)
View(mananciais)


mananciais %>% 
  mutate(ano = year(data), mes = month(data)) %>% 
  filter(ano == 2021, mes == 10 ) %>% 
  ggplot() +
  geom_line(aes(x = data, y = volume_porcentagem, color = sistema)) +
  theme_bw() +
  labs(x = "Mês", y = "Volume operacional (%)",
       color = "Sistema", 
       title = "Volume operacional armazenado nos \n sistemas que abastecem a RMSP em 2021",
       caption = "Fonte: Dados da SABESP - https://mananciais.sabesp.com.br/Situacao")
