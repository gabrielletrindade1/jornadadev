
// ============================================
// PROGRAMA: principal.prg
// DESCRIÇÃO: Testa a biblioteca matematica.prg
// COMPILAR:  hbmk2 principal.prg
// ============================================

SET PROCEDURE TO matematica.prg

FUNCTION Main()

   QOut("=========================================")
   QOut("  TESTE — BIBLIOTECA MATEMATICA.PRG")
   QOut("=========================================")

   TestarFatorial()
   TestarPrimo()
   TestarMDC()
   TestarMMC()

   QOut("")
   QOut("=========================================")
   QOut("  Todos os testes concluidos!")
   QOut("=========================================")

RETURN NIL


// ---- Funções de teste (uma por bloco) ----

FUNCTION TestarFatorial()

   QOut("")
   QOut("--- FATORIAL ---")
   QOut("0! = " + Str(FatorialN(0), 8))      // 1
   QOut("1! = " + Str(FatorialN(1), 8))      // 1
   QOut("5! = " + Str(FatorialN(5), 8))      // 120
   QOut("7! = " + Str(FatorialN(7), 8))      // 5040
   QOut("10! = " + Str(FatorialN(10), 8))    // 3628800

RETURN NIL


FUNCTION TestarPrimo()
   LOCAL aTestar := {1, 2, 3, 7, 10, 13, 25, 29}
   LOCAL nI

   QOut("")
   QOut("--- EH PRIMO? ---")

   FOR nI := 1 TO Len(aTestar)
      QOut(Str(aTestar[nI], 4) + " -> " + IIF(EhPrimo(aTestar[nI]), "SIM", "NAO"))
   NEXT

RETURN NIL


FUNCTION TestarMDC()

   QOut("")
   QOut("--- MDC ---")
   QOut("MDC(12, 8)   = " + Str(MDC(12, 8), 4))     // 4
   QOut("MDC(15, 25)  = " + Str(MDC(15, 25), 4))    // 5
   QOut("MDC(7, 3)    = " + Str(MDC(7, 3), 4))      // 1
   QOut("MDC(100, 75) = " + Str(MDC(100, 75), 4))   // 25

RETURN NIL


FUNCTION TestarMMC()

   QOut("")
   QOut("--- MMC ---")
   QOut("MMC(4, 6)   = " + Str(MMC(4, 6), 4))      // 12
   QOut("MMC(3, 5)   = " + Str(MMC(3, 5), 4))      // 15
   QOut("MMC(12, 8)  = " + Str(MMC(12, 8), 4))     // 24
   QOut("MMC(7, 3)   = " + Str(MMC(7, 3), 4))      // 21

RETURN NIL

