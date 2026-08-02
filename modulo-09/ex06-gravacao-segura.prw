#include "protheus.ch"

USER FUNCTION STTIP003SALVAR()

    LOCAL lOk   := .T.
    LOCAL oErro := NIL

    // Inicia a transacao (tudo ou nada)
    BeginTran()

    BEGIN SEQUENCE

        // Valida se o cliente foi preenchido
        IF Empty(M->Z1_CLIENTE)
            MsgAlert("Preencha o campo Cliente!", "Atencao")
            lOk := .F.
            Break()
        ENDIF

        // Valida se o assunto foi preenchido
        IF Empty(M->Z1_ASSUNTO)
            MsgAlert("Preencha o campo Assunto!", "Atencao")
            lOk := .F.
            Break()
        ENDIF

        // Grava o registro na SZ1
        dbSelectArea("SZ1")

        IF INCLUI
            RecLock("SZ1", .T.)
        ELSE
            RecLock("SZ1", .F.)
        ENDIF

        SZ1->Z1_CODIGO  := M->Z1_CODIGO
        SZ1->Z1_CLIENTE := M->Z1_CLIENTE
        SZ1->Z1_ASSUNTO := M->Z1_ASSUNTO
        SZ1->Z1_DATA    := M->Z1_DATA
        SZ1->Z1_HORA    := M->Z1_HORA

        MsUnLock()

    RECOVER USING oErro

        // Deu erro inesperado: desfaz e avisa
        lOk := .F.
        RollBackTran()
        MsgStop("Erro na gravacao: " + oErro:Description, "Erro")
        U_GRAVARLOG("STTIP003SALVAR", oErro)
        RETURN lOk

    END SEQUENCE

    // Se deu tudo certo, confirma. Senao, desfaz.
    IF lOk
        CommitTran()
    ELSE
        RollBackTran()
    ENDIF

RETURN lOk


// ============================================
// Funcao de log - grava detalhes do erro em arquivo
// ============================================

USER FUNCTION GRAVARLOG(cFuncao, oErro)

    LOCAL cArqLog := "\logs\advpl_" + DToS(Date()) + ".log"
    LOCAL nHandle
    LOCAL cLinha

    cLinha := DToS(Date()) + " " + Time() + " | "
    cLinha += cFuncao + " | "
    cLinha += cNomUsr + " | "

    IF oErro != NIL
        cLinha += "ERRO: " + oErro:Description + " | "
        cLinha += "Local: " + oErro:ProcName + ":" + cValToChar(oErro:ProcLine)
    ENDIF

    nHandle := FOpen(cArqLog, FO_READWRITE + FO_SHARED)
    IF nHandle < 0
        nHandle := FCreate(cArqLog)
    ENDIF

    FSeek(nHandle, 0, FS_END)
    FWrite(nHandle, cLinha + CRLF)
    FClose(nHandle)

RETURN NIL

