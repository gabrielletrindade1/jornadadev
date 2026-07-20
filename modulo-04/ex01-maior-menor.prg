FUNCTION Main()

    LOCAL nValor1
    LOCAL nValor2

    ACCEPT "Digite o primeiro valor: " TO nValor1
    ACCEPT "Digite o segundo valor: " TO nValor2

    nValor1 := Val(nValor1)
    nValor2 := Val(nValor2)

    IF nValor1 == nValor2

        QOut("Os dois valores sÆo iguais.")

    ELSEIF nValor1 > nValor2

        QOut("Maior valor: " + Str(nValor1))
        QOut("Menor valor: " + Str(nValor2))

    ELSE

        QOut("Maior valor: " + Str(nValor2))
        QOut("Menor valor: " + Str(nValor1))

    ENDIF

RETURN NIL