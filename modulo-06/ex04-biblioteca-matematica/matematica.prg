
// ============================================
// BIBLIOTECA: matematica.prg
// DESCRIÇÃO:  Funções matemáticas reutilizáveis
// ============================================

/*
 * FatorialN(nN) — Calcula N!
 * Retorno: numérico (fatorial) ou -1 se inválido
 */
FUNCTION FatorialN(nN)
   LOCAL nI, nResult := 1

   IF nN < 0
      RETURN -1
   ENDIF

   FOR nI := 2 TO nN
      nResult *= nI
   NEXT

RETURN nResult


/*
 * EhPrimo(nN) — Verifica se N é primo
 * Retorno: .T. se primo, .F. se não
 */
FUNCTION EhPrimo(nN)
   LOCAL nI, nLimite

   IF nN <= 1
      RETURN .F.
   ENDIF

   IF nN == 2
      RETURN .T.
   ENDIF

   IF Mod(nN, 2) == 0
      RETURN .F.
   ENDIF

   nLimite := Int(Sqrt(nN))
   FOR nI := 3 TO nLimite STEP 2
      IF Mod(nN, nI) == 0
         RETURN .F.
      ENDIF
   NEXT

RETURN .T.


/*
 * MDC(nA, nB) — Máximo Divisor Comum (Euclides)
 * Retorno: numérico
 */
FUNCTION MDC(nA, nB)
   LOCAL nResto

   nA := Abs(nA)
   nB := Abs(nB)

   WHILE nB != 0
      nResto := Mod(nA, nB)
      nA := nB
      nB := nResto
   ENDDO

RETURN nA


/*
 * MMC(nA, nB) — Mínimo Múltiplo Comum
 * Fórmula: (A * B) / MDC(A, B)
 * Retorno: numérico
 */
FUNCTION MMC(nA, nB)

   nA := Abs(nA)
   nB := Abs(nB)

   IF nA == 0 .OR. nB == 0
      RETURN 0
   ENDIF

RETURN (nA * nB) / MDC(nA, nB)

