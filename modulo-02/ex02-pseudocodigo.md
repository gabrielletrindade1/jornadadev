# Exercício 2 — Pseudocódigo

## A. Calcular a área de um retângulo.

### Pseudocódigo

```text
Início

Leia base
Leia altura

area ← base * altura

Escreva "A área do retângulo é:", area

Fim
```

**Como funciona:**
- Recebe a base e a altura do retângulo.
- Calcula a área multiplicando os dois valores.
- Exibe o resultado.

---

## B. Verificar se um número é par ou ímpar.

### Pseudocódigo

```text
Início

Leia numero

Se numero divide por 2 e o resto é igual a 0 Então
    Escreva "O número é par."
Senão
    Escreva "O número é ímpar."
FimSe

Fim
```

**Como funciona:**
- Lê um número informado pelo usuário.
- Verifica se o resto da divisão por 2 é igual a zero.
- Exibe se o número é par ou ímpar.

---

## C. Encontrar o maior entre três números.

### Pseudocódigo

```text
Início

Leia num1
Leia num2
Leia num3

Se num1 >= num2 E num1 >= num3 Então
    Escreva "O maior número é:", num1
Senão
    Se num2 >= num1 E num2 >= num3 Então
        Escreva "O maior número é:", num2
    Senão
        Escreva "O maior número é:", num3
    FimSe
FimSe

Fim
```

**Como funciona:**
- Lê três números.
- Compara os valores utilizando estruturas condicionais.
- Exibe qual deles possui o maior valor.