REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL nMes

    // Array com os nomes dos meses.
    // A posi‡Æo corresponde ao n£mero do mˆs.
    LOCAL aMeses := { ;
        "Janeiro", "Fevereiro", "Mar‡o", "Abril", ;
        "Maio", "Junho", "Julho", "Agosto", ;
        "Setembro", "Outubro", "Novembro", "Dezembro" }

    hb_cdpSelect("PT850")

    ACCEPT "Digite o n£mero do mˆs (1 a 12): " TO nMes

    // Converte o valor digitado (texto) para n£mero.
    nMes := Val(nMes)

    // Verifica se o mˆs est  dentro do intervalo v lido.
    IF nMes >= 1 .AND. nMes <= 12

        // Exibe o mˆs que est  na posi‡Æo informada.
        // Ex.: nMes = 5 ? aMeses[5] ? "Maio"
        QOut(aMeses[nMes])

    ELSE

        QOut("Mˆs inv lido!")

    ENDIF

RETURN NIL