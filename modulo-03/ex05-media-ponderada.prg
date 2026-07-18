REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL nNota1, nNota2, nNota3, nNota4, nMedia
    LOCAL cAux

    hb_cdpSelect("PT850")

    ACCEPT "Digite a 1¦ nota: " TO cAux
    nNota1 := Val(cAux)

    ACCEPT "Digite a 2¦ nota: " TO cAux
    nNota2 := Val(cAux)

    ACCEPT "Digite a 3¦ nota: " TO cAux
    nNota3 := Val(cAux)

    ACCEPT "Digite a 4¦ nota: " TO cAux
    nNota4 := Val(cAux)

    // M‚dia ponderada com pesos 1, 2, 3 e 4
    nMedia := ((nNota1 * 1) + (nNota2 * 2) + (nNota3 * 3) + (nNota4 * 4)) / (1 + 2 + 3 + 4)

    ? "=============================="
    ? "RESULTADO"
    ? "=============================="
    ? "M‚dia ponderada: " + AllTrim(Str(nMedia, 10, 2))

RETURN NIL