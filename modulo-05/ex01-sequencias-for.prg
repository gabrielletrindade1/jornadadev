REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL nNumero

    hb_cdpSelect("PT850")

    // a) De 1 até 100
    QOut("=== De 1 a 100 ===")

    FOR nNumero := 1 TO 100
        QOut(nNumero)
    NEXT

    QOut("")

    // b) De -50 até 50
    QOut("=== De -50 a 50 ===")

    FOR nNumero := -50 TO 50
        QOut(nNumero)
    NEXT

    QOut("")

    // c) De 80 até 5 (ordem decrescente)
    QOut("=== De 80 a 5 ===")

    // STEP -1 faz o contador diminuir de 1 em 1
    FOR nNumero := 80 TO 5 STEP -1
        QOut(nNumero)
    NEXT

RETURN NIL