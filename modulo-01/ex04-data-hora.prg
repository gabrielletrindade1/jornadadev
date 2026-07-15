REQUEST HB_CODEPAGE_PT850

FUNCTION Main()


    LOCAL cNome   := "Gabrielle"
    LOCAL cCidade := "Campinas"
    LOCAL cCurso  := "Harbour/ADVPL"
    LOCAL cData   := DToC(DATE())
    LOCAL cHora   := Time()
 
    hb_cdpSelect("PT850")
    QOut("==============================")
    QOut("FICHA DE APRESENTA€ÇO")
    QOut("==============================")
    QOut("Nome:" + cNome)
    QOut("Cidade:" + cCidade)
    QOut("Curso:" + cCurso)
    QOut("Data:" + cData + " - Hora:" + cHora)
   

RETURN NIL