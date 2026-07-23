FUNCTION Main()

   LOCAL aDias := {"Domingo", "Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira", "Sábado"}
   LOCAL cInput
   LOCAL nDia

   // Loop de consistência — repete até receber valor válido
   WHILE .T.
      ACCEPT "Digite um número de 1 a 7 (0 para sair): " TO cInput
      nDia := Val(cInput)

      IF nDia == 0
         QOut("Encerrando. Até logo!")
         EXIT
      ENDIF

      IF nDia < 1 .OR. nDia > Len(aDias)
         QOut("Número inválido! Tente novamente.")
         QOut("")
         LOOP
      ENDIF

      QOut("Dia " + Str(Int(nDia)) + " = " + aDias[nDia])
      QOut("")
   ENDDO

RETURN NIL

