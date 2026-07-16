# Exercício 2 — Pseudocódigo

Escreva em pseudocódigo um algoritmo para cada item.

---

## a. Calcular a área de um retângulo (base × altura)

### Pseudocódigo

```text
Início

Leia base
Leia altura

area ← base * altura

Escreva area

Fim
```

**Descrição:**
- Lê o valor da base.
- Lê o valor da altura.
- Calcula a área multiplicando a base pela altura.
- Exibe o resultado.

---

## b. Verificar se um número é par ou ímpar

### Pseudocódigo

```text
Início

Leia numero

Se numero % 2 = 0 Então
    Escreva "Par"
Senão
    Escreva "Ímpar"
FimSe

Fim
```

**Descrição:**
- Lê um número.
- Verifica se o resto da divisão por 2 é igual a zero.
- Se for, informa que o número é **Par**.
- Caso contrário, informa que o número é **Ímpar**.

---

## c. Encontrar o maior entre três números

### Pseudocódigo

```text
Início

Leia num1
Leia num2
Leia num3

maior ← num1

Se num2 > maior Então
    maior ← num2
FimSe

Se num3 > maior Então
    maior ← num3
FimSe

Escreva maior

Fim
```

**Descrição:**
- Lê três números.
- Considera inicialmente o primeiro como o maior.
- Compara o segundo e o terceiro número com o maior atual.
- Atualiza a variável `maior` quando encontrar um valor maior.
- Exibe o maior número informado.