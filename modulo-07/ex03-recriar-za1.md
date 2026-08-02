
# Módulo 7 — Exercício 3: Recriando a ZA1 no Configurador

## Passos que eu seguiria para criar a tabela ZA1

### 1. Cadastrar a tabela no SX2

- Abrir o Configurador (SIGACFG) > Dicionário > Banco de Dados > Dicionário de Dados
- Clicar em Incluir e preencher: Prefixo = `ZA1`, Nome = `Pets`, Modo = `C` (Compartilhado)
- No caminho do arquivo, seguir o mesmo padrão usado pelas outras tabelas (tipo a SA1), pra não dar erro

### 2. Criar os campos no SX3

Adicionar os campos um por um:

| Campo       | Tipo | Tamanho | Obrigatório |
|-------------|------|---------|-------------|
| ZA1_FILIAL  | C    | 2       | Sim         |
| ZA1_COD     | C    | 6       | Sim         |
| ZA1_NOME    | C    | 30      | Não         |
| ZA1_RACA    | C    | 20      | Não         |
| ZA1_DTNASC  | D    | 8       | Não         |

**Cuidado:** o título do campo que aparece no Browse tem um limite de caracteres — se colocar um título muito grande, ele não aceita. Descobrimos isso na aula na prática.

### 3. Criar o índice no SIX

- Índice 1: `ZA1_FILIAL + ZA1_COD` — é a chave primária que identifica cada pet de forma única

### 4. Forçar o reconhecimento da tabela

- Depois de cadastrar tudo, a tabela ainda não aparece "de verdade" pro sistema
- Usamos a rotina de fórmulas do Protheus pra forçar o framework a reconhecer a ZA1

### 5. Conferir no MPSDU

- Abrir o MPSDU e procurar a tabela ZA1
- Verificar se todos os campos aparecem com o tipo e tamanho certos
- Se tudo estiver lá, a tabela foi criada com sucesso!

## Dificuldades

- **Erro na declaração de chaves primárias:** na hora de configurar o índice, deu erro na declaração das chaves — precisei ajustar a expressão do índice até funcionar
- **Erro ao incluir um novo Pet:** quando tentei adicionar um pet novo pelo AxCadastro, dava erro. A solução foi refazer o AxCadastro assim: AxCadastro("ZA1,"Pets")
- O título do campo no Browse não pode ser muito longo (restrição de tamanho )

