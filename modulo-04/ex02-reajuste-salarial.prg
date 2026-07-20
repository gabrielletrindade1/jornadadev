REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cSalario
    LOCAL nSalario
    LOCAL nReajuste
    LOCAL nNovoSalario

    hb_cdpSelect("PT850")

    ACCEPT "Digite o sal rio atual: R$ " TO cSalario
    nSalario := Val(cSalario)

    IF nSalario < 1000
        nReajuste := 0.15

    ELSEIF nSalario <= 2000
        nReajuste := 0.12

    ELSEIF nSalario <= 4000
        nReajuste := 0.08

    ELSE
        nReajuste := 0.05

    ENDIF

    nNovoSalario := nSalario + (nSalario * nReajuste)

    QOut("Sal rio atual: R$ " + AllTrim(Str(nSalario, 10, 2)))
    QOut("Reajuste aplicado: " + AllTrim(Str(nReajuste * 100, 5, 2)) + "%")
    QOut("Novo sal rio: R$ " + AllTrim(Str(nNovoSalario, 10, 2)))

RETURN NIL