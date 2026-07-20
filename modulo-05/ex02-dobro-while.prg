REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL nValor

    hb_cdpSelect("PT850")

    WHILE .T.

        ACCEPT "Digite um número inteiro: " TO nValor
        nValor := Val(nValor)

        IF nValor <= 0
            EXIT
        ENDIF

        QOut("Dobro: " + Str(nValor * 2))

    ENDDO

    QOut("")
    QOut("Programa encerrado.")

RETURN NIL