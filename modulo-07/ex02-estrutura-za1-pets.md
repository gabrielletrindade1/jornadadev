
# Módulo 7 — Exercício 2: A tabela ZA1 (Pets)

## a) Campos da ZA1

| Campo       | Tipo | Tamanho | Descrição         |
|-------------|------|---------|-------------------|
| ZA1_FILIAL  | C    | 2       | Filial (obrigatório em toda tabela) |
| ZA1_COD     | C    | 6       | Código do pet     |
| ZA1_NOME    | C    | 30      | Nome do pet       |
| ZA1_RACA    | C    | 20      | Raça do pet       |
| ZA1_DTNASC  | D    | 8       | Data de nascimento |

## b) Que índice faria sentido?

O índice principal seria `ZA1_FILIAL + ZA1_COD`, porque é a chave que identifica cada pet de forma única. É tipo a lista telefônica: em vez de procurar página por página, o índice organiza os registros em ordem e o sistema acha o pet direto pelo código, sem percorrer a tabela inteira.

## c) Por que o prefixo é Z?

No Protheus, o prefixo `Z` é reservado pra tabelas customizadas — ou seja, tabelas que não vêm de fábrica com o sistema. A gente criou a ZA1 pra um uso nosso (cadastro de Pets), então ela usa o `Z` pra não conflitar com as tabelas padrão (tipo SA1, SB1, etc).

## d) Por que os campos começam com ZA1_?

Porque é a convenção do Protheus: todo campo começa com o prefixo da tabela a que pertence. Assim, só de olhar o nome `ZA1_NOME`, já sei que esse campo é da tabela ZA1. Se fosse só "NOME" solto, não daria pra saber de qual tabela ele é — e isso viraria uma bagunça enorme num sistema com milhares de campos.

