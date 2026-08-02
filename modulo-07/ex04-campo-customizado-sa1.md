
# Módulo 7 — Exercício 4: Campo customizado na SA1

## Passo a passo para criar o campo A1_XAPELID

### 1. Abrir o Configurador

- Entrar no SIGACFG > Dicionário > Banco de Dados > Dicionário de Dados
- Procurar a tabela SA1 e clicar pra editar os campos dela

### 2. Incluir o campo novo

- Clicar em Incluir e preencher:
  - **Campo:** A1_XAPELID
  - **Tipo:** C (Caractere)
  - **Tamanho:** 20
  - **Título:** Apelido
  - **Descrição:** Apelido do cliente
  - **Obrigatório:** Não

### 3. Atualizar a estrutura

- Confirmar a inclusão e deixar o Configurador atualizar a tabela

### 4. Conferir no SmartClient

- Abrir o módulo de Faturamento (ou qualquer módulo que use a SA1)
- Entrar no cadastro de Clientes e abrir um registro pra editar ou visualizar
- O campo "Apelido" já aparece na tela sem precisar programar nada — só a configuração no dicionário já fez ele aparecer


