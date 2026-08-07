
#include "protheus.ch"

// ================================================================
// STTZZ1.PRW
// Rotina de manutencao da tabela ZZ1 - Controle de Fornecimento
// Modulo: SIGACOM (Compras)
// Autor: Gabrielle
// Data: 07/08/2026
// Descricao: Browse (mBrowse) com legendas coloridas por validade
//            do certificado, validacoes de negocio e gravacao
//            protegida com BEGIN SEQUENCE + transacao.
// ================================================================

// ------------------------------------------------------------
// STTZZ1 - Browse principal do Controle de Fornecimento
// Legenda:
//   Verde    = certificado valido (vence em mais de 30 dias)
//   Amarelo  = certificado proximo do vencimento (ate 30 dias)
//   Vermelho = certificado vencido
// ------------------------------------------------------------
USER FUNCTION STTZZ1()
    LOCAL aLegenda := {}
    LOCAL cFiltro  := ""

    PRIVATE cCadastro := "Controle de Fornecimento"
    PRIVATE aRotina   := {;
        {"Pesquisar"   , "AxPesqui" , 0, 1},;
        {"Visualizar"  , "AxVisual" , 0, 2},;
        {"Incluir"     , "AxInclui" , 0, 3},;
        {"Alterar"     , "AxAltera" , 0, 4},;
        {"Excluir"     , "AxDeleta" , 0, 5},;
        {"Ocorrencias" , "U_STTZZ2FLT" , 0, 6};
    }

    // Legenda por validade do certificado
    aLegenda := {;
        {"ZZ1->ZZ1_VALCER >= dDataBase + 30" , "BR_VERDE"   },;
        {"ZZ1->ZZ1_VALCER >= dDataBase"      , "BR_AMARELO" },;
        {".T."                               , "BR_VERMELHO"};
    }

    dbSelectArea("ZZ1")
    dbSetOrder(1)
    dbSeek(xFilial("ZZ1"))

    mBrowse(1, 1, 22, 75, "ZZ1", , , , , , aLegenda, , , , , .F., , , cFiltro)

RETURN NIL

// ------------------------------------------------------------
// VALFOR001 - Valida existencia do fornecedor na SA2
// Configurar no X3_VALID de ZZ1_FORNEC = "U_VALFOR001()"
// ------------------------------------------------------------
USER FUNCTION VALFOR001()

    IF Empty(M->ZZ1_FORNEC)
        MsgAlert("Informe o codigo do fornecedor.", "Campo obrigatorio")
        RETURN .F.
    ENDIF

    IF !ExistCpo("SA2", xFilial("SA2") + M->ZZ1_FORNEC + M->ZZ1_LOJAFO, 1)
        MsgAlert("Fornecedor nao encontrado na tabela SA2. Verifique o codigo e a loja.", "Validacao")
        RETURN .F.
    ENDIF

RETURN .T.

// ------------------------------------------------------------
// VALTOL001 - Valida que a tolerancia esta entre 0 e 100
// Configurar no X3_VALID de ZZ1_TOLERA = "U_VALTOL001()"
// ------------------------------------------------------------
USER FUNCTION VALTOL001()

    IF M->ZZ1_TOLERA < 0 .OR. M->ZZ1_TOLERA > 100
        MsgAlert("A tolerancia deve ser um valor entre 0 e 100%.", "Validacao")
        RETURN .F.
    ENDIF

RETURN .T.

// ------------------------------------------------------------
// VALCER001 - Valida que a data do certificado nao e passada
// Configurar no X3_VALID de ZZ1_VALCER = "U_VALCER001()"
// ------------------------------------------------------------
USER FUNCTION VALCER001()

    IF M->ZZ1_VALCER < dDataBase
        MsgAlert("A validade do certificado nao pode ser anterior a data atual.", "Validacao")
        RETURN .F.
    ENDIF

RETURN .T.

// ------------------------------------------------------------
// VALEXCZZ1 - Impede exclusao de ZZ1 com ZZ2 vinculada
// Integridade referencial: nao pode excluir "mae" com "filhos"
// Configurar como validacao de exclusao da ZZ1
// ------------------------------------------------------------
USER FUNCTION VALEXCZZ1()

    dbSelectArea("ZZ2")
    dbSetOrder(1)

    IF dbSeek(xFilial("ZZ2") + ZZ1->ZZ1_CODIGO)
        MsgAlert("Este controle possui ocorrencias vinculadas!" + CRLF + ;
                 "Exclua as ocorrencias antes de remover o controle.", "Exclusao bloqueada")
        RETURN .F.
    ENDIF

RETURN .T.

// ------------------------------------------------------------
// STTZZ1GRV - Gravacao protegida do Controle de Fornecimento
// Quatro camadas de protecao:
//   1. Validacao de negocio
//   2. Transacao (BeginTran / CommitTran / RollBackTran)
//   3. BEGIN SEQUENCE para capturar erros inesperados
//   4. Log tecnico via GravarLogTCC()
// ------------------------------------------------------------
USER FUNCTION STTZZ1GRV()
    LOCAL lSucesso := .T.
    LOCAL oErro

    // Inicia transacao — garante "tudo ou nada"
    BeginTran()

    BEGIN SEQUENCE

        // --- Camada 1: validacoes de negocio ---
        IF Empty(M->ZZ1_FORNEC)
            MsgAlert("O fornecedor e obrigatorio para salvar o controle.", "Atencao")
            lSucesso := .F.
            Break()
        ENDIF

        IF M->ZZ1_TOLERA < 0 .OR. M->ZZ1_TOLERA > 100
            MsgAlert("Tolerancia fora da faixa permitida (0 a 100).", "Atencao")
            lSucesso := .F.
            Break()
        ENDIF

        IF !ExistCpo("SA2", xFilial("SA2") + M->ZZ1_FORNEC + M->ZZ1_LOJAFO, 1)
            MsgAlert("Fornecedor informado nao existe na SA2.", "Atencao")
            lSucesso := .F.
            Break()
        ENDIF

        // --- Camada 2: operacao no banco com lock ---
        dbSelectArea("ZZ1")

        IF INCLUI
            RecLock("ZZ1", .T.)  // .T. = novo registro
            ZZ1->ZZ1_FILIAL := xFilial("ZZ1")
            ZZ1->ZZ1_CODIGO := GetSXENum("ZZ1", "ZZ1_CODIGO")
        ELSE
            RecLock("ZZ1", .F.)  // .F. = altera registro existente
        ENDIF

        ZZ1->ZZ1_FORNEC := M->ZZ1_FORNEC
        ZZ1->ZZ1_LOJAFO := M->ZZ1_LOJAFO
        ZZ1->ZZ1_CERTIF := M->ZZ1_CERTIF
        ZZ1->ZZ1_VALCER := M->ZZ1_VALCER
        ZZ1->ZZ1_TOLERA := M->ZZ1_TOLERA
        ZZ1->ZZ1_TOTOK  := M->ZZ1_TOTOK
        ZZ1->ZZ1_TOTNOK := M->ZZ1_TOTNOK

        MsUnLock()  // salva e libera o lock

    RECOVER USING oErro

        // --- Camada 3: tratamento do erro inesperado ---
        lSucesso := .F.
        RollBackTran()
        MsgStop("Ocorreu um erro ao salvar o controle de fornecimento." + CRLF + ;
                "A operacao foi desfeita. Tente novamente ou contate o suporte.", "Erro")
        U_GravarLogTCC("STTZZ1GRV", oErro)
        RETURN lSucesso

    END SEQUENCE

    // --- Camada 4: confirma ou desfaz ---
    IF lSucesso
        CommitTran()
    ELSE
        RollBackTran()
    ENDIF

RETURN lSucesso

