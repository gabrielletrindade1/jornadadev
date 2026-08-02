
# Módulo 7 — Exercícios Conceituais

## Exercício 1 — Conceitos Fundamentais 

### a) Qual é a função do AppServer?

O AppServer é o servidor que roda o código ADVPL e acessa o banco de dados. Quando o usuário faz algo no SmartClient, a solicitação vai pro AppServer — ele processa tudo e devolve o resultado. Toda a lógica roda nele, não na máquina do usuário.

### b) O que é o RPO?

O RPO é o arquivo onde ficam guardados todos os programas ADVPL compilados. Quando a gente compila um `.PRW` com F9, ele vai pro RPO — e é de lá que o AppServer puxa as rotinas pra executar. É tipo o `.exe` do Harbour, só que centralizado no servidor.

### c) Para que serve o Configurador (SIGACFG)?

O Configurador é onde a gente mexe nas configurações do Protheus: tabelas, campos, índices, menus e permissões. O legal é que dá pra mudar o comportamento do sistema sem programar — tipo tornar um campo obrigatório ou criar uma tabela nova.

### d) Qual a diferença entre campo Real e campo Virtual no SX3?

- **Campo Real:** fica gravado no banco de dados. O valor dele persiste depois que você salva.
- **Campo Virtual:** não é gravado — é calculado na hora de exibir, buscando dados de outra tabela com `POSICIONE`. Serve pra mostrar info sem duplicar dados.

