REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL nSecreto
    LOCAL nPalpite
    LOCAL nTentativa

    hb_cdpSelect("PT850")

    nSecreto := HB_RandomInt(1,100)

    QOut("====================================")
    QOut("     JOGO: ADIVINHE O N�MERO")
    QOut("====================================")
    QOut("Pensei em um n�mero entre 1 e 100.")
    QOut("Voc� tem 7 tentativas.")
    QOut("")

    FOR nTentativa := 1 TO 7

        ACCEPT "Digite seu palpite: " TO nPalpite
        nPalpite := Val(nPalpite)

        IF nPalpite == nSecreto

            QOut("")
            QOut("====================================")
            QOut("      PARAB�NS! VOC� ACERTOU!")
            QOut("====================================")
            QOut("N�mero secreto: " + Str(nSecreto))
            QOut("Tentativas utilizadas: " + Str(nTentativa))
            QOut("Excelente trabalho!")
            EXIT

        ENDIF

        IF nPalpite < nSecreto
            QOut("Dica: o n�mero secreto � MAIOR.")
        ELSE
            QOut("Dica: o n�mero secreto � MENOR.")
        ENDIF

        QOut("")

    NEXT

    // S� executa se o jogador n�o acertou
    IF nPalpite <> nSecreto

        QOut("")
        QOut("====================================")
        QOut("      FIM DE JOGO")
        QOut("====================================")
        QOut("Voc� utilizou todas as 7 tentativas.")
        QOut("O n�mero secreto era: " + Str(nSecreto))
        QOut("Mais sorte na pr�xima!")

    ENDIF

RETURN NIL