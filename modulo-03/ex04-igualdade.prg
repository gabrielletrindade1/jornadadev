REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cCompleto := "Harbour"
    LOCAL cParcial  := "Harb"

    hb_cdpSelect("PT850")

    QOut("Compara‡Æo entre '=' e '=='")
    QOut("")

    QOut("Palavra completa: " + cCompleto)
    QOut("Palavra parcial : " + cParcial)
    QOut("")

    QOut("Usando '=':")
    QOut(cCompleto = cParcial)

    QOut("Usando '==':")
    QOut(cCompleto == cParcial)

RETURN NIL