REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL nValor
    LOCAL nTotal := 0
    LOCAL nQtd := 0

    hb_cdpSelect("PT850")

    WHILE .T.

        ACCEPT "Digite um valor (0 para finalizar): " TO nValor
        nValor := Val(nValor)

        // Encerra quando o usuário digitar 0
        IF nValor == 0
            EXIT
        ENDIF

        // Acumula o valor e conta quantos foram informados
        nTotal += nValor
        nQtd++

    ENDDO

    QOut("")
    QOut("Resultado")
    QOut("---------")
    QOut("Soma total: " + Str(nTotal))
    QOut("Quantidade de valores: " + Str(nQtd))

RETURN NIL