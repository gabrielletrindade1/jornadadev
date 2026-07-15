REQUEST HB_CODEPAGE_PT850

FUNCTION Main ()

LOCAL nValor := 250
LOCAL nDesconto := 0
LOCAL nTotal := 0

hb_cdpSelect("PT850")

    if nValor > 100
            nDesconto := nValor * 0.10

    ENDIF
    nTotal := nValor - nDesconto
    QOut ("O Valor com desconto ‚: " + str(nDesconto))

RETURN NIL