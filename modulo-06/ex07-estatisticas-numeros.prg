FUNCTION Main()
   LOCAL aNumeros := {}
   LOCAL cInput
   LOCAL nI, nSoma := 0

   // --- Entrada: lê 10 números e armazena no array ---
   QOut("=== ESTATÍSTICAS DE 10 NÚMEROS ===")
   QOut("")

   FOR nI := 1 TO 10
      ACCEPT "Número " + Str(nI, 2) + ": " TO cInput
      AADD(aNumeros, Val(cInput))
   NEXT

   ASORT(aNumeros)                    // ordena crescente

   FOR nI := 1 TO Len(aNumeros)
      nSoma += aNumeros[nI]           // acumula a soma
   NEXT

   QOut("")
   QOut("=== RESULTADOS ===")
   QOut("Ordem crescente: ")

   FOR nI := 1 TO Len(aNumeros)
      QQOut(Str(aNumeros[nI], 6, 1) + " ")
   NEXT

   QOut("")
   QOut("Soma:   " + Str(nSoma, 10, 2))
   QOut("Média:  " + Str(nSoma / Len(aNumeros), 10, 2))
   QOut("Menor:  " + Str(aNumeros[1], 10, 2))
   QOut("Maior:  " + Str(aNumeros[Len(aNumeros)], 10, 2))

RETURN NIL

