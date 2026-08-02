FUNCTION Main()

    LOCAL nNum1     := 10
    LOCAL nNum2     := 0
    LOCAL nResult   := 0
    LOCAL oErro     := NIL
    LOCAL bErrAntes := NIL

    QOut("=== Exercicio 5 - Tratamento de Erros ===")
    QOut("")

    // Guarda o ErrorBlock antigo e instala o nosso
    bErrAntes := ErrorBlock({|e| Break(e)})

    BEGIN SEQUENCE

        QOut("Dividindo " + AllTrim(Str(nNum1)) + " por " + AllTrim(Str(nNum2)) + "...")
        nResult := nNum1 / nNum2
        QOut("Deu certo! Resultado: " + AllTrim(Str(nResult)))

    RECOVER USING oErro

        IF oErro != NIL
            QOut("Ops! Erro capturado:")
            QOut("  -> " + AllTrim(oErro:Description))
        ELSE
            QOut("Erro capturado, mas sem detalhes disponiveis.")
        ENDIF

    END SEQUENCE

    // Restaura o ErrorBlock que estava antes
    IF bErrAntes != NIL
        ErrorBlock(bErrAntes)
    ENDIF

    QOut("")
    QOut("Programa seguiu normalmente apos o erro!")

RETURN NIL

