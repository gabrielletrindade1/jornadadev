
FUNCTION Main()

    LOCAL aDias := {"Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"}
    LOCAL aQualquerCoisa := {}
    LOCAL nI := 0

    // Preenche o array com 2000 números aleatórios
    FOR nI := 1 TO 2000
        AAdd(aQualquerCoisa, hb_RandomInt(1, 2000))
    NEXT

    // Altera o último elemento
    aDias[7] := "Sabado"

    // Separador visual + percorre o array de dias
    QOut("")
    QOut("=== DIAS DA SEMANA ===")
    FOR nI := 1 TO Len(aDias)
        QOut(Str(nI, 2) + ". " + aDias[nI])
    NEXT

RETURN NIL

