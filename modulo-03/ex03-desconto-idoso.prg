REQUEST HB_CODEPAGE_PT850

FUNCTION Main()

    LOCAL cNome
    LOCAL cData
    LOCAL dNasc
    LOCAL nIdade
    LOCAL cPreco
    LOCAL nPreco
    LOCAL nDesconto := 0
    LOCAL nTotal

    hb_cdpSelect("PT850")

    ACCEPT "Nome do cliente: " TO cNome
    ACCEPT "Data de nascimento (dd/mm/aaaa): " TO cData
    ACCEPT "Pre‡o do produto: " TO cPreco

    dNasc := CToD(cData)  // Converte o texto digitado para uma data
    nPreco := Val(cPreco) // Converte o pre‡o de texto para n£mero

    nIdade := Int((Date() - dNasc) / 365) // Calcula a idade aproximada em anos

    IF nIdade > 60
        nDesconto := nPreco * 0.125
    ENDIF

    nTotal := nPreco - nDesconto

    ? "=============================="
    ? "RESUMO DA COMPRA"
    ? "=============================="
    ? "Cliente   : " + cNome
    ? "Idade     : " + AllTrim(Str(nIdade)) + " anos"
    ? "Pre‡o     : R$ " + AllTrim(Str(nPreco, 10, 2))
    ? "Desconto  : R$ " + AllTrim(Str(nDesconto, 10, 2))
    ? "Total     : R$ " + AllTrim(Str(nTotal, 10, 2))

RETURN NIL