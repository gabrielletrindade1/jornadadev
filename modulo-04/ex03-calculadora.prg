REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cValorA
    LOCAL cValorB
    LOCAL cOperacao

    LOCAL nA
    LOCAL nB
    LOCAL nResultado

    hb_cdpSelect("PT850")

    ACCEPT "Digite o primeiro número: " TO cValorA
    nA := Val(cValorA)

    ACCEPT "Operação (+, -, *, /, ^, R): " TO cOperacao

    IF Upper(cOperacao) <> "R"
        ACCEPT "Digite o segundo número: " TO cValorB
        nB := Val(cValorB)
    ENDIF

    DO CASE

    CASE cOperacao == "+"
        nResultado := nA + nB
        QOut("Resultado: " + AllTrim(Str(nResultado,10,2)))

    CASE cOperacao == "-"
        nResultado := nA - nB
        QOut("Resultado: " + AllTrim(Str(nResultado,10,2)))

    CASE cOperacao == "*"
        nResultado := nA * nB
        QOut("Resultado: " + AllTrim(Str(nResultado,10,2)))

    CASE cOperacao == "/"
        IF nB == 0
            QOut("Erro: divisão por zero!")
        ELSE
            nResultado := nA / nB
            QOut("Resultado: " + AllTrim(Str(nResultado,10,2)))
        ENDIF

    CASE cOperacao == "^"
        nResultado := nA ^ nB
        QOut("Resultado: " + AllTrim(Str(nResultado,10,2)))

    CASE Upper(cOperacao) == "R"
        nResultado := Sqrt(nA)
        QOut("Raiz quadrada: " + AllTrim(Str(nResultado,10,2)))

    OTHERWISE
        QOut("Operação inválida!")

    ENDCASE

RETURN NIL