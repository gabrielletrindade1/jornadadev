
# Exercício 2 — Completando a tabela ZA1 (o pet ganha um dono)

## Campos da ZA1

| Campo       | Tipo | Tam | Dec | Contexto | Descrição            |
|-------------|------|-----|-----|----------|----------------------|
| ZA1_FILIAL  | C    | 2   | 0   | Real     | Filial               |
| ZA1_COD     | C    | 6   | 0   | Real     | Código do pet        |
| ZA1_CLIENT  | C    | 6   | 0   | Real     | Código do cliente (dono) |
| ZA1_LOJA    | C    | 2   | 0   | Real     | Loja do cliente      |
| ZA1_NOMCLI  | C    | 40  | 0   | Virtual  | Nome do cliente      |
| ZA1_NOME    | C    | 30  | 0   | Real     | Nome do pet          |
| ZA1_RACA    | C    | 20  | 0   | Real     | Raça do pet          |
| ZA1_DTNASC  | D    | 8   | 0   | Real     | Data de nascimento   |
| ZA1_OBS     | C    | 60  | 0   | Real     | Observação           |

## Campo Virtual ZA1_NOMCLI

Configurado no X3_RELACAO com a seguinte expressao:

POSICIONE("SA1",1,xFilial("SA1")+M->ZA1_CLIENT+M->ZA1_LOJA,"A1_NOME")

Essa funcao busca o nome do cliente na tabela SA1 automaticamente usando o codigo e a loja que o usuario digitou. Como eh virtual, nao grava nada no banco — so mostra na tela.

## Indices (SIX)

- **Indice 1:** ZA1_FILIAL + ZA1_COD — chave primaria, identifica cada pet de forma unica
- **Indice 2:** ZA1_FILIAL + ZA1_CLIENT + ZA1_LOJA — busca todos os pets de um cliente especifico

