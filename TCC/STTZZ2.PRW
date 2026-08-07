
#include "protheus.ch"

// ================================================================
// STTZZ2.PRW
// Rotina de manutencao da tabela ZZ2 - Ocorrencias do Fornecedor
// Modulo: SIGACOM (Compras)
// Autor: Gabrielle
// Data: 07/08/2026
// Descricao: Browse com legenda comparando % de nao conformidade
//            contra a tolerancia do certificado (ZZ1_TOLERA).
//            Possui versao filtrada (chamada pelo botao da ZZ1).
// ================================================================

// ------------------------------------------------------------
// STTZZ2 - Browse geral das Ocorrencias (acesso pelo menu)
// Legenda:
//   Verde    = % nao conforme dentro da tolerancia
//   Vermelho = % nao conforme acima da tolerancia
// ------------------------------------------------------------
USER FUNCTION STTZZ2()
    LOCAL aLegenda := {}
    LOCAL cFiltro  := ""

    PRIVATE cCadastro := "Ocorrencias do Fornecedor"
    PRIVATE aRotina   := {;
        {"Pesquisar"  , "AxPesqui" , 0, 1},;
        {"Visualizar" , "AxVisual" , 0, 2},;
        {"Incluir"    , "AxInclui" , 0, 3},;
        {"Alterar"    , "AxAltera" , 0, 4},;
        {"Excluir"    , "AxDeleta" , 0, 5};
    }

    // Legenda: compara % NC com a tolerancia do certificado
    // % NC = (ZZ2_QTDNOK / (ZZ2_QTDOK + ZZ2_QTDNOK)) * 100
    // Se ultrapassa ZZ1_TOLERA → vermelho; senao → verde
    aLegenda := {;
        {"U_PercOcorr() > U_TolerCert()", "BR_VERMELHO"},;
        {".T."                          , "BR_VERDE"   };
    }

    dbSelectArea("ZZ2")
    dbSetOrder(1)
    dbSeek(xFilial("ZZ2"))

    mBrowse(1, 1, 22, 75, "ZZ2", , , , , , aLegenda, , , , , .F., , , cFiltro)

RETURN NIL

// ------------------------------------------------------------
// STTZZ2FLT - Browse filtrado (chamado pelo botao "Ocorrencias"
// da STTZZ1, exibe apenas ZZ2 do controle selecionado)
// ------------------------------------------------------------
USER FUNCTION STTZZ2FLT()
    LOCAL aLegenda   := {}
    LOCAL cFiltro    := ""
    LOCAL cCodigoZZ1 := ZZ1->ZZ1_CODIGO

    PRIVATE cCadastro := "Ocorrencias - Controle " + AllTrim(cCodigoZZ1)
    PRIVATE aRotina   := {;
        {"Pesquisar"  , "AxPesqui" , 0, 1},;
        {"Visualizar" , "AxVisual" , 0, 2},;
        {"Incluir"    , "AxInclui" , 0, 3},;
        {"Alterar"    , "AxAltera" , 0, 4},;
        {"Excluir"    , "AxDeleta" , 0, 5};
    }

    aLegenda := {;
        {"U_PercOcorr() > U_TolerCert()", "BR_VERMELHO"},;
        {".T."                          , "BR_VERDE"   };
    }

    // Filtro: mostra apenas ocorrencias deste controle
    cFiltro := "ZZ2_CONFOR == '" + cCodigoZZ1 + "'"

    dbSelectArea("ZZ2")
    dbSetOrder(1)
    dbSeek(xFilial("ZZ2") + cCodigoZZ1)

    mBrowse(1, 1, 22, 75, "ZZ2", , , , , , aLegenda, , , , , .F., , , cFiltro)

RETURN NIL

// ------------------------------------------------------------
// PercOcorr - Calcula o % de nao conformidade da linha atual
// Usada pela legenda do browse
// ------------------------------------------------------------
USER FUNCTION PercOcorr()
    LOCAL nTotal := ZZ2->ZZ2_QTDOK + ZZ2->ZZ2_QTDNOK

    IF nTotal <= 0
        RETURN 0
    ENDIF

RETURN Round((ZZ2->ZZ2_QTDNOK / nTotal) * 100, 2)

// ------------------------------------------------------------
// TolerCert - Retorna a tolerancia do certificado vinculado
// Usada pela legenda do browse para comparacao
// ------------------------------------------------------------
USER FUNCTION TolerCert()
    LOCAL nToler := 0

    nToler := Posicione("ZZ1", 1, xFilial("ZZ1") + ZZ2->ZZ2_CONFOR, "ZZ1_TOLERA")

RETURN nToler

// ------------------------------------------------------------
// VALCON001 - Valida que o controle (ZZ1) existe
// Configurar no X3_VALID de ZZ2_CONFOR = "U_VALCON001()"
// ------------------------------------------------------------
USER FUNCTION VALCON001()

    IF Empty(M->ZZ2_CONFOR)
        MsgAlert("Informe o codigo do controle de fornecimento.", "Campo obrigatorio")
        RETURN .F.
    ENDIF

    IF !ExistCpo("ZZ1", xFilial("ZZ1") + M->ZZ2_CONFOR, 1)
        MsgAlert("Controle de fornecimento nao encontrado na ZZ1.", "Validacao")
        RETURN .F.
    ENDIF

RETURN .T.

// ------------------------------------------------------------
// VALPROD01 - Valida que o produto existe na SB1
// Configurar no X3_VALID de ZZ2_CODPRO = "U_VALPROD01()"
// ------------------------------------------------------------
USER FUNCTION VALPROD01()

    IF Empty(M->ZZ2_CODPRO)
        MsgAlert("Informe o codigo do produto.", "Campo obrigatorio")
        RETURN .F.
    ENDIF

    IF !ExistCpo("SB1", xFilial("SB1") + M->ZZ2_CODPRO, 1)
        MsgAlert("Produto nao encontrado na tabela SB1.", "Validacao")
        RETURN .F.
    ENDIF

RETURN .T.

// ------------------------------------------------------------
// VALDATZZ2 - Valida que a data da ocorrencia nao e futura
// Configurar no X3_VALID de ZZ2_DATA = "U_VALDATZZ2()"
// ------------------------------------------------------------
USER FUNCTION VALDATZZ2()

    IF M->ZZ2_DATA > dDataBase
        MsgAlert("A data da ocorrencia nao pode ser futura.", "Validacao")
        RETURN .F.
    ENDIF

RETURN .T.

// ------------------------------------------------------------
// STTZZ2GRV - Gravacao protegida das Ocorrencias
// Mesma estrutura de 4 camadas da STTZZ1GRV
// ------------------------------------------------------------
USER FUNCTION STTZZ2GRV()
    LOCAL lSucesso := .T.
    LOCAL oErro

    BeginTran()

    BEGIN SEQUENCE

        // Validacoes de negocio
        IF Empty(M->ZZ2_CONFOR)
            MsgAlert("O controle de fornecimento e obrigatorio.", "Atencao")
            lSucesso := .F.
            Break()
        ENDIF

        IF Empty(M->ZZ2_CODPRO)
            MsgAlert("O produto e obrigatorio.", "Atencao")
            lSucesso := .F.
            Break()
        ENDIF

        IF (M->ZZ2_QTDOK + M->ZZ2_QTDNOK) <= 0
            MsgAlert("Informe ao menos uma quantidade (conforme ou nao conforme).", "Atencao")
            lSucesso := .F.
            Break()
        ENDIF

        // Gravacao
        dbSelectArea("ZZ2")

        IF INCLUI
            RecLock("ZZ2", .T.)
            ZZ2->ZZ2_FILIAL := xFilial("ZZ2")
            ZZ2->ZZ2_DATA   := dDataBase
            ZZ2->ZZ2_HORA   := Time()
        ELSE
            RecLock("ZZ2", .F.)
        ENDIF

        ZZ2->ZZ2_CONFOR := M->ZZ2_CONFOR
        ZZ2->ZZ2_FORNEC := M->ZZ2_FORNEC
        ZZ2->ZZ2_LOJAFO := M->ZZ2_LOJAFO
        ZZ2->ZZ2_CODPRO := M->ZZ2_CODPRO
        ZZ2->ZZ2_QTDOK  := M->ZZ2_QTDOK
        ZZ2->ZZ2_QTDNOK := M->ZZ2_QTDNOK
        ZZ2->ZZ2_VLRUNI := M->ZZ2_VLRUNI

        MsUnLock()

    RECOVER USING oErro

        lSucesso := .F.
        RollBackTran()
        MsgStop("Erro ao registrar a ocorrencia." + CRLF + ;
                "A operacao foi desfeita. Tente novamente.", "Erro")
        U_GravarLogTCC("STTZZ2GRV", oErro)
        RETURN lSucesso

    END SEQUENCE

    IF lSucesso
        CommitTran()
    ELSE
        RollBackTran()
    ENDIF

RETURN lSucesso

