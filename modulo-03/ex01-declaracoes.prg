REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

   LOCAL cNomeFuncionario := "Gabrielle"
   LOCAL nSalarioBruto := 5000.00
   LOCAL lAtivo := .T.
   LOCAL dDataAdmissao := SToD("20260315")
   LOCAL nCodigoDepartamento := 15

   hb_cdpSelect("PT850")

   SET DATE BRITISH

   ? "Funcion†rio: " + cNomeFuncionario
   ? "Sal†rio: " + hb_ntos(nSalarioBruto)
   ? "Ativo:", lAtivo
   ? "Admiss∆o: " + DToC(dDataAdmissao)
   ? "Departamento: " + hb_ntos(nCodigoDepartamento)

RETURN NIL