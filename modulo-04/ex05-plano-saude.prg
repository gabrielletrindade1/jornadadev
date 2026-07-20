REQUEST HB_CODEPAGE_PT850
FUNCTION Main()

    LOCAL nIdade
    LOCAL nDep
    LOCAL nPlano
    LOCAL nTotal
hb_cdpSelect("PT850")
    ACCEPT "Idade: " TO nIdade
    nIdade := Val(nIdade)

    ACCEPT "Dependentes: " TO nDep
    nDep := Val(nDep)

    DO CASE
        CASE nIdade <= 25
            nPlano := 180
        CASE nIdade <= 40
            nPlano := 260
        CASE nIdade <= 60
            nPlano := 380
        OTHERWISE
            nPlano := 520
    ENDCASE

    nTotal := nPlano + (nDep * 90)

    QOut("Valor mensal total: R$ " + Str(nTotal,8,2))

RETURN NIL