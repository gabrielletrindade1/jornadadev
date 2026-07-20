REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cNome
    LOCAL cDisc
    LOCAL nNota1
    LOCAL nNota2
    LOCAL nMedia

    hb_cdpSelect("PT850")

    // Nome
    DO WHILE .T.

        ACCEPT "Nome Aluno (a): " TO cNome
        cNome := AllTrim(cNome)

        IF Len(cNome) > 0
            EXIT
        ENDIF

        QOut("Nome inválido!")

    ENDDO


    // Disciplina
    DO WHILE .T.

        ACCEPT "Disciplina (3 letras): " TO cDisc
        cDisc := AllTrim(cDisc)

        IF Len(cDisc) == 3 .AND. cDisc == Upper(cDisc)  // Verifica se possui 3 letras e se todas estão em maiúsculas
            EXIT
        ENDIF

        QOut("Disciplina inválida!")

    ENDDO


    // Primeira nota
    DO WHILE .T.

        ACCEPT "Primeira nota: " TO nNota1
        nNota1 := Val(nNota1)

        IF nNota1 >= 0 .AND. nNota1 <= 10
            EXIT
        ENDIF

        QOut("Nota inválida!")

    ENDDO


    // Segunda nota
    DO WHILE .T.

        ACCEPT "Segunda nota: " TO nNota2
        nNota2 := Val(nNota2)

        IF nNota2 >= 0 .AND. nNota2 <= 10
            EXIT
        ENDIF

        QOut("Nota inválida!")

    ENDDO


    nMedia := (nNota1 + nNota2) / 2

    QOut("")
    QOut("Dados do aluno")
    QOut("--------------------------")
    QOut("Nome: " + cNome)
    QOut("Disciplina: " + cDisc)
    QOut("Nota 1: " + Str(nNota1, 6, 2))
    QOut("Nota 2: " + Str(nNota2, 6, 2))
    QOut("Média: " + Str(nMedia, 6, 2))

RETURN NIL