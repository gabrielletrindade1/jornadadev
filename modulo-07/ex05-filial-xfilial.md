
# Módulo 7 — Exercício 5: A1_FILIAL e xFilial()

## a) Por que existe o campo A1_FILIAL (e por que toda tabela precisa de um campo de filial)?

O campo de filial existe porque o Protheus é um sistema multiempresa — várias filiais podem usar o mesmo banco de dados. O campo `A1_FILIAL` é o que separa os registros de uma filial dos de outra. Sem ele, não teria como saber qual cliente pertence a qual filial. Por isso toda tabela, incluindo a ZA1 que a gente criou, precisa desse campo.

## b) O que a função xFilial() tem a ver com isso?

A `xFilial()` retorna automaticamente o código da filial certa dependendo se a tabela é compartilhada ou exclusiva. Se a gente escrevesse a filial na mão (tipo colocar "01" direto no código), o programa ia funcionar só naquela filial específica — em outra filial ou em tabela compartilhada ia dar erro ou trazer dados errados. O `xFilial()` resolve isso pra gente de forma automática e segura.

