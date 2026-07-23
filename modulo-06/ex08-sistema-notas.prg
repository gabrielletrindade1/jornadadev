FUNCTION Main()
   LOCAL aAlunos := {}
   LOCAL cNome, cInput
   LOCAL nN1, nN2, nN3, nN4
   LOCAL nQtd, nI, nMedia

   ACCEPT "Quantos alunos? " TO cInput
   nQtd := Val(cInput)

   FOR nI := 1 TO nQtd
      QOut("")
      QOut("--- Aluno " + Str(nI, 2) + " ---")
      ACCEPT "Nome: " TO cNome

      ACCEPT "Nota 1: " TO cInput
      nN1 := Val(cInput)
      ACCEPT "Nota 2: " TO cInput
      nN2 := Val(cInput)
      ACCEPT "Nota 3: " TO cInput
      nN3 := Val(cInput)
      ACCEPT "Nota 4: " TO cInput
      nN4 := Val(cInput)

      AADD(aAlunos, {cNome, nN1, nN2, nN3, nN4})
   NEXT

   QOut("")
   QOut("========================================")
   QOut("         RESULTADO FINAL")
   QOut("========================================")

   QOut("")
   QOut(">>> APROVADOS (média >= 7):")
   FOR nI := 1 TO Len(aAlunos)
      nMedia := CalcularMedia(aAlunos[nI])
      IF nMedia >= 7
         QOut("  " + aAlunos[nI][1] + " - Média: " + Str(nMedia, 5, 1))
      ENDIF
   NEXT

   QOut("")
   QOut(">>> REPROVADOS (média < 7):")
   FOR nI := 1 TO Len(aAlunos)
      nMedia := CalcularMedia(aAlunos[nI])
      IF nMedia < 7
         QOut("  " + aAlunos[nI][1] + " - Média: " + Str(nMedia, 5, 1))
      ENDIF
   NEXT

RETURN NIL

// --- Função: calcula média de um aluno (recebe a linha do array) ---
FUNCTION CalcularMedia(aAluno)
   // aAluno = {nome, n1, n2, n3, n4}
   // Posições: [1]=nome, [2]=n1, [3]=n2, [4]=n3, [5]=n4
RETURN (aAluno[2] + aAluno[3] + aAluno[4] + aAluno[5]) / 4

