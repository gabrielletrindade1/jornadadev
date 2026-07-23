FUNCTION Main ()

    Local nX :=5

    nX := Dobrar(nX) //5 -> 10 (preciso reatribuir o retorno)
    DobrarRef(@nX) //10 -> 20 (o @ altera a variável original)
    ? nX //20

RETURN NIL

FUNCTION Dobrar(nValor) //Por VALOR (padrão)
    nValor *= 2
    nValor := 1
 RETURN nValor

FUNCTION DobrarRef(nValor) //Por Referencia
    nValor *=2
RETURN NIL

nX := Dobrar(nX) //5 -> 10 (preciso reatribuir o retorno)
    DobrarRef(@nX) //10 -> 20 (o @ altera a variável original)
