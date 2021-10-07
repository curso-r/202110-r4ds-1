# Rodando códigos (o R como calculadora) ----------------------------------

# ATALHO para rodar o código: CTRL + ENTER

# adição
1 + 1

# subtração
4 - 2

# multiplicação
2 * 3

# divisão
5 / 3

# potência
4 ^ 2 
# = 4 * 4

4^7
# = 4*4*4*4*4*4*4

# Objetos -----------------------------------------------------------------

valor_da_pizza <- 170

# As bases de dados serão o nosso objeto de trabalho 
mtcars

# O objeto mtcars já vem com a instalação do R
# Ele está sempre disponível

# Outros exemplos 
pi
letters
LETTERS

# Na prática, vamos precisar trazer nossas bases
# para dentro do R. Como faremos isso?

# Funções -----------------------------------------------------------------

# Funções são nomes que guardam um código de R. Esse código é
# avaliado quando rodamos uma função.

nrow(mtcars)
ncol(mtcars)

# exemplo metáfora:
# um ralador é um objeto que se comporta tipo uma função... 
ralador(queijo)
# isso aqui é queijo ralado

nrow()
# nrow = instrumento que eu uso para extrair o numero de linhas de uma tabela
# mtcars é um exemplo de tabela que eu posso passar para o nrow

# Podemos usar a função help para ver
# a documentação de um objeto ou função
help(mtcars)
help(nrow)

nrow

# Uma função muito útil para data frames é a View
View(mtcars)

# Uma função pode ter mais de um argumento
# Argumentos são sempre separados por vírgulas

help(sum)

sum(1, 2)
sum(2, 3, 4)

# Existem funções para ler bases de dados

imdb <- read.csv("dados/imdb.csv")

# Como "salvar" a base dentro do R?

# Criando objetos ---------------------------------------------------------

# No dia-a-dia, a gente vai precisar criar os 
# nossos próprios objetos

# Salvando o valor 1 no objeto "obj"
obj <- 1
obj

# Também dizemos 'guardando as saídas'
soma <- 2 + 2
soma

# ATALHO para a <- : ALT - (alt menos)

# Em geral, começaremos a nossa análise com:
nossa_base <- funcao_que_carrega_uma_base("caminho/ate/arquivo")

# O erro "could not find function" significa que 
# você pediu para o R avaliar uma função que
# não existe. O mesmo vale para objetos:

nossa_base

nossa_base <- read.csv2("caminho/ate/arquivo")

# Dicas:
# - sempre leia as mensagens de erro
# - verifique no Environment se um objeto existe

# No nosso caso:
imdb <- read.csv("dados/imdb.csv")
nossa_base <- read.csv("dados/imdb.csv")

# salvar saída versus apenas executar
33 / 11
resultado <- 33 / 11

# atualizar um objeto
resultado <- resultado * 5
resultado * 5

# A nossa base imdb só será alterada quando salvarmos
# uma operação em cima do objeto imdb

imdb <- read.csv("dados/imdb.csv")

help(na.exclude)
na.exclude(imdb)
imdb <- na.exclude(imdb)
imdb_sem_na <- na.exclude(imdb)

# Os nomes devem começar com uma letra.
# Podem conter letras, números, _ e .

# Permitido

x <- 1
x1 <- 2
objeto <- 3
meu_objeto <- 4
meu.objeto <- 5

# Não permitido

1x <- 1
_objeto <- 2

raed.csv("dados/imdb.csv")

meu-objeto <- 3

# Estilo de nomes

eu_uso_snake_case
outrasPessoasUsamCamelCase
algumas.pessoas.usam.pontos.mas.nao.deviam
E_algumasPoucas.Pessoas_RENUNCIAMconvenções


# checkpoint --------------------------------------------------------------

# 1. Escrevam (não copiem e colem) o código que lê a base e 
# a salva num objeto imdb_2. Rodem o código e observem 
# na aba environment se o objeto imdb apareceu.

imdb_2 <- read.csv("dados/imdb.csv")

# Classes -----------------------------------------------------------------

imdb

# Cada coluna da base representa uma variável
# Cada variável pode ser de um tipo (classe) diferente

# Podemos somar dois números
1 + 2

texto_exemplo <- "_meu-objeto"

# Não podemos somar duas letras (texto)
"a" + "b"

##############################
# Use aspas para criar texto #
##############################

a <- 10

# O objeto a, sem aspas
a

# A letra (texto) a, com aspas
"a"

# Numéricos (numeric)

a <- 10
class(a)

# Caracteres (character, strings)

obj <- "a"
obj2 <- "masculino"

class(obj)
class(obj2)

# lógicos (logical, booleanos)

verdadeiro <- TRUE
falso <- FALSE

class(verdadeiro)
class(falso)

# datas (Date)

class(Sys.Date())

# Data frames

class(nrow)

class(mtcars)
class(imdb)

# Como vemos a classe de uma coluna?
# Como acessar as colunas de uma base?

resultado <- 1+1

resultado+1
resultado+2

imdb <- read.csv("dados/imdb.csv")





nrow()

# Vetores -----------------------------------------------------------------

# Vetores são conjuntos de valores

help(c)

vetor1 <- c(1, 4, 3.1, 10, 5, 7, 9)
vetor2 <- c("a", "b", "z", "fernando")

vetor1
vetor2

# Uma maneira fácil de criar um vetor com uma sequência de números
# é utilizar o operador `:`

# Vetor de 1 a 10
1:10

# Vetor de 10 a 1
10:1

# Vetor de -3 a 3
-3:3

# As colunas de data.frames são vetores
mtcars$mpg
imdb$titulo

imdb <- read.csv("dados/imdb.csv")

class(mtcars$mpg)
class(imdb$titulo)

# O operador $ pode ser utilizado para selecionar
# uma coluna da base

# Um vetor só pode guardar um tipo de objeto e ele terá sempre
# a mesma classe dos objetos que guarda

vetor1 <- c(1, 5, 3, -10)
vetor2 <- c("a", "b", "c")

vetor1 <- c(1L, 5L)

class(vetor1)
class(vetor2)

# Se tentarmos misturar duas classes, o R vai apresentar o
# comportamento conhecido como coerção

vetor <- c(1, 2, "a")

vetor
class(vetor)

# esse vetor é igual a
vetor_sem_coercao <- c("1", "2", "a")

vetor_de_numeros <- c(2, 1L)

class(vetor_de_numeros)

# character > numeric > integer > logical

# coerções forçadas por você
texto_para_logico <- as.logical("TRUE")

class(texto_para_logico)

as.numeric(c(TRUE, FALSE, FALSE))
as.character(c(TRUE, FALSE, FALSE))

as.numeric(c("1", "2", "3"))

as.numeric("1a")

# Por consquência, cada coluna de uma base 
# guarda valores de apenas uma classe.

# Naturalmente, podemos fazer operações matemáticas com vetores

vetor <- c(0, 5, 20, -3)

vetor + 1
vetor - 1
vetor / 2
vetor * 10

vetor_sem_coercao + 1

# Você também pode fazer operações que envolvem mais de um vetor:

vetor1 <- c(1, 2, 3)
vetor2 <- c(10, 20, 30)

vetor1  + vetor2

# Pacotes -----------------------------------------------------------------

# Para instalar pacotes

install.packages("tidyverse")

library(tidyverse)
library(dplyr)

# Também é possível acessar as funções usando ::

# As formas de escrever são equivalentes:
# readr::read_csv("dados/imdb.csv")

# library(readr)
# read_csv("dados/imdb.csv")

dplyr::filter_at()
dplyr::transmute()
