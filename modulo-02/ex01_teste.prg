REQUEST HB_CODEPAGE_UTF8

FUNCTION Soma (num1, num2)
    LOCAL nResult := num1 + num2
    Qout(str(nResult))
RETURN NIL

FUNCTION Main ()
    hb_cdpSet("UTF8")
    Soma ("10","qoi")
RETURN NIL

