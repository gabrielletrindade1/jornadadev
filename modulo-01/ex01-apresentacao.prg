REQUEST HB_CODEPAGE_PT850

FUNCTION Main()


    LOCAL cNome   := "Gabrielle"
    LOCAL cCidade := "Campinas"
    LOCAL cCurso  := "Harbour/ADVPL"
 
    hb_cdpSelect("PT850")
    QOut("==============================")
    QOut("FICHA DE APRESENTA€ÇO")
    QOut("==============================")
    QOut("Nome:" + cNome)
    QOut("Cidade:" + cCidade)
    QOut("Curso:" + cCurso)

RETURN NIL