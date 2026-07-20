REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL nSecreto
    LOCAL nPalpite
    LOCAL nTentativa

    hb_cdpSelect("PT850")

    nSecreto := HB_RandomInt(1,100)

    QOut("====================================")
    QOut("     JOGO: ADIVINHE O NÚMERO")
    QOut("====================================")
    QOut("Pensei em um número entre 1 e 100.")
    QOut("Você tem 7 tentativas.")
    QOut("")

    FOR nTentativa := 1 TO 7

        ACCEPT "Digite seu palpite: " TO nPalpite
        nPalpite := Val(nPalpite)

        IF nPalpite == nSecreto

            QOut("")
            QOut("====================================")
            QOut("      PARABÉNS! VOCÊ ACERTOU!")
            QOut("====================================")
            QOut("Número secreto: " + Str(nSecreto))
            QOut("Tentativas utilizadas: " + Str(nTentativa))
            QOut("Excelente trabalho!")
            EXIT

        ENDIF

        IF nPalpite < nSecreto
            QOut("Dica: o número secreto é MAIOR.")
        ELSE
            QOut("Dica: o número secreto é MENOR.")
        ENDIF

        QOut("")

    NEXT

    // Só executa se o jogador não acertou
    IF nPalpite <> nSecreto

        QOut("")
        QOut("====================================")
        QOut("      FIM DE JOGO")
        QOut("====================================")
        QOut("Você utilizou todas as 7 tentativas.")
        QOut("O número secreto era: " + Str(nSecreto))
        QOut("Mais sorte na próxima!")

    ENDIF

RETURN NIL