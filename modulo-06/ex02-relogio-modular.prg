FUNCTION Main()
   LOCAL nInicio   // momento em que o rel¢gio comeáou (segundos)
   LOCAL cHora     // hora "crua" vinda do sistema
   LOCAL cFormatada 

   QOut("=== REL‡GIO DIGITAL ===")
   QOut("Exibindo por 30 segundos...")
   QOut("")

   nInicio := Seconds()   // marca o "ponto zero"

   // Loop: repete enquanto n∆o passaram 30 segundos
   WHILE (Seconds() - nInicio) < 30

      cHora      := ObterHora()          // 1. obtÇm
      cFormatada := FormatarHora(cHora)   // 2. formata
      ExibirHora(cFormatada)              // 3. exibe

      hb_idleSleep(1)   // pausa ~1 segundo antes de repetir

   ENDDO

   QOut("")
   QOut("Rel¢gio encerrado ap¢s 30 segundos.")

RETURN NIL

FUNCTION ObterHora()
RETURN Time()

FUNCTION FormatarHora(cHora)
   LOCAL cFormatada
   cFormatada := "[ " + cHora + " ]"
RETURN cFormatada


FUNCTION ExibirHora(cHoraFmt)
   QQOut(Chr(13) + cHoraFmt)   // Chr(13) = carriage return (sobrescreve a linha)
RETURN NIL

