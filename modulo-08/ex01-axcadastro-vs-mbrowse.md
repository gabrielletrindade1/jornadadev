
# Exercício 1 — AxCadastro × mBrowse

## a) Quando usar cada um?

Eu usaria o **AxCadastro** pra tabelas simples que só precisa do CRUD básico funcionando rápido — tipo um cadastro de categorias com poucos campos. Já o **mBrowse** eu usaria pra rotinas de produção que precisam de mais recursos — tipo um cadastro de Pets onde quero legendas coloridas e filtros.

## b) Três coisas que o mBrowse faz e o AxCadastro não faz

- Legendas coloridas (pintar linhas de cores diferentes conforme uma regra)
- Filtros dinâmicos (o usuário pode filtrar os dados na própria tela)
- Colunas personalizadas (escolher quais campos aparecem no browse)

## c) Por que a regra ".T." deve ficar por último no aColors?

Porque as regras do `aColors` são avaliadas de cima pra baixo — a primeira que der verdadeira define a cor da linha. Se colocar `.T.` primeiro, ela sempre vai ser verdadeira e todas as linhas ficam da mesma cor, ignorando as outras regras. Então `.T.` fica por último como a "cor padrão".

## d) Diferença entre campo Virtual e gatilho (SX7)

- **Campo Virtual:** calcula o valor na hora de exibir na tela, mas não grava nada no banco. Toda vez que abre a tela, ele busca de novo.
- **Gatilho (SX7):** preenche um campo Real no momento da digitação. O valor é gravado no banco e fica lá permanente.

