
# Exercício 7 — A brincadeira do CEP (Gatilho)

## a) Qual a diferença entre campo, contra-domínio e regra num gatilho?

- **Campo:** é o campo que dispara o gatilho (o que o usuário acabou de preencher, tipo `A1_CEP`)
- **Contra-domínio:** é o campo que vai ser preenchido automaticamente (tipo `A1_BAIRRO`)
- **Regra:** é a expressão ou função que calcula o valor que vai ser colocado no contra-domínio

## b) Por que usa M->A1_CEP e não SA1->A1_CEP?

Porque `M->` pega o valor que o usuário está digitando agora na tela, antes de salvar. Já `SA1->` pegaria o valor que já está gravado no banco — e na hora de incluir um cliente novo, esse valor ainda não existe. Então usamos `M->` pra trabalhar com o dado atual do formulário.

## c) Problemas de ter os CEPs dentro do código-fonte

1. **Fica desatualizado rápido:** se um CEP novo é criado ou muda de bairro, tem que mexer no código, compilar de novo e colocar em produção. Isso é trabalhoso e lento.
2. **Não cobre todos os CEPs:** é impossível colocar todos os CEPs do Brasil dentro do código. Qualquer CEP que não estiver ali não vai funcionar.

**Como resolver:** poderia usar uma tabela no dicionário (tipo SX5 ou uma tabela customizada) com os CEPs cadastrados, ou melhor ainda, consultar um serviço externo (tipo a API do ViaCEP) que retorna o endereço completo em tempo real.

## d) Se pedissem pra preencher também o A1_COD_MUN?

Eu criaria mais um gatilho no campo `A1_CEP` com sequência 004, colocando `A1_COD_MUN` como contra-domínio e uma regra tipo `U_STCEP(M->A1_CEP,"COD_MUN")`. Também teria que atualizar a função `U_STCEP` pra retornar o código do município quando receber esse parâmetro.

