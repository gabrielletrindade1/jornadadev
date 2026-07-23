REQUEST HB_CODEPAGE_PT850

FUNCTION Main()
   LOCAL nA, nB, nResultado
   LOCAL cOp
   LOCAL lSucesso

   hb_cdpSelect("PT850")

   ExibirCabecalho()

   nA  := LerNumero("Digite o primeiro n£mero: ")
   cOp := LerOperacao()

   // 2. Se nÆo for raiz quadrada, pedir o segundo n£mero
   IF Upper(cOp) <> "R"
      nB := LerNumero("Digite o segundo n£mero: ")
   ELSE
      nB := 0   // nÆo ser  usado, mas fica inicializado
   ENDIF

   // 3. Calcular (retorna .T. se deu certo, .F. se houve erro)
   lSucesso := Calcular(nA, nB, cOp, @nResultado)

   // 4. Mostrar resultado ou erro
   IF lSucesso
      MostrarResultado(nA, nB, cOp, nResultado)
   ENDIF

RETURN NIL


FUNCTION ExibirCabecalho()
   QOut("===========================")
   QOut("   CALCULADORA MODULAR     ")
   QOut("===========================")
   QOut("")
RETURN NIL

/*
 * LerNumero ? lˆ uma entrada do usu rio e converte para n£mero
 * Parƒmetros: cMensagem (texto exibido antes da leitura)
 * Retorno: num‚rico (o valor digitado)
 */
FUNCTION LerNumero(cMensagem)
   LOCAL cInput
   ACCEPT cMensagem TO cInput
RETURN Val(cInput)

/*
 * LerOperacao ? lˆ a opera‡Æo desejada pelo usu rio
 * Parƒmetros: nenhum
 * Retorno: string com a opera‡Æo escolhida
 */
FUNCTION LerOperacao()
   LOCAL cOp
   ACCEPT "Opera‡Æo (+, -, *, /, ^, R): " TO cOp
RETURN cOp

/*
 * Calcular ? realiza a opera‡Æo matem tica
 * Parƒmetros:
 *   nA         ? primeiro n£mero
 *   nB         ? segundo n£mero
 *   cOp        ? opera‡Æo (+, -, *, /, ^, R)
 *   nResultado ? passado por REFERÒNCIA, recebe o resultado
 * Retorno: .T. se o c lculo deu certo, .F. se houve erro
 */
FUNCTION Calcular(nA, nB, cOp, nResultado)

   DO CASE
      CASE cOp == "+"
         nResultado := nA + nB

      CASE cOp == "-"
         nResultado := nA - nB

      CASE cOp == "*"
         nResultado := nA * nB

      CASE cOp == "/"
         IF nB == 0
            QOut("Erro: divisÆo por zero!")
            RETURN .F.    // sinaliza falha
         ENDIF
         nResultado := nA / nB

      CASE cOp == "^"
         nResultado := nA ^ nB

      CASE Upper(cOp) == "R"
         IF nA < 0
            QOut("Erro: raiz quadrada de n£mero negativo!")
            RETURN .F.
         ENDIF
         nResultado := Sqrt(nA)

      OTHERWISE
         QOut("Opera‡Æo inv lida: " + cOp)
         RETURN .F.    // opera‡Æo nÆo reconhecida

   ENDCASE

RETURN .T.   // tudo certo

/*
 * MostrarResultado ? exibe o resultado formatado
 * Parƒmetros:
 *   nA         ? primeiro n£mero
 *   nB         ? segundo n£mero
 *   cOp        ? opera‡Æo realizada
 *   nResultado ? valor calculado
 * Retorno: NIL (procedimento)
 */
FUNCTION MostrarResultado(nA, nB, cOp, nResultado)

   QOut("")
   QOut("--- Resultado ---")

   IF Upper(cOp) == "R"
      QOut("?" + AllTrim(Str(nA, 10, 2)) + " = " + AllTrim(Str(nResultado, 10, 2)))
   ELSE
      QOut(AllTrim(Str(nA, 10, 2)) + " " + cOp + " " + ;
           AllTrim(Str(nB, 10, 2)) + " = " + ;
           AllTrim(Str(nResultado, 10, 2)))
   ENDIF

RETURN NIL

