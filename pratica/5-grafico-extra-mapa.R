# carrega os pacotes magrittr e ggplot2
library(magrittr)
library(ggplot2)

# baixa os dados das ufs
sf_state <- geobr::read_state()

# contagens de municipios por UF
dados_estados <- abjData::muni %>% 
  dplyr::count(uf_sigla)

# monta o gráfico
dados_estados %>% 
  dplyr::left_join(sf_state, c("uf_sigla" = "abbrev_state")) %>% 
  # transforma em um objeto do tipo sf (sem isso, precisaria colocar)
  # aes(geometry=geom) dentro do geom_sf()
  sf::st_as_sf() %>% 
  ggplot(aes(fill = n)) +
  geom_sf() +
  # adiciona labels das ufs
  geom_sf_label(aes(label = uf_sigla), colour = "white")
