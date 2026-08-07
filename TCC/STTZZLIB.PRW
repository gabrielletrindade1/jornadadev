
#include "protheus.ch"

// ================================================================
// STTZZLIB.PRW
// Biblioteca de funcoes comuns do sistema de Controle ISO 9001
// Modulo: SIGACOM (Compras)
// Autor: Gabrielle
// Data: 07/08/2026
// Descricao: Funcoes reutilizaveis pelas rotinas STTZZ1 e STTZZ2.
//            Principio DRY — nenhuma logica duplicada nos fontes.
// ================================================================

// ------------------------------------------------------------
// NomeFornecedor
// Retorna o nome do fornecedor a partir do codigo e loja
// Parametros: cFornec (C6), cLoja (C2)
// Retorno: string com o nome (ou vazio se nao encontrar)
// ------------------------------------------------------------
USER FUNCTION NomeFornec(cFornec, cLoja)
    LOCAL cNome := ""

    IF Empty(cFornec)
        RETURN ""
    ENDIF

    cNome := Posicione("SA2", 1, xFilial("SA2") + cFornec + cLoja, "A2_NOME")

RETURN AllTrim(cNome)

// ------------------------------------------------------------
// NomeProduto
// Retorna a descricao do produto a partir do codigo
// Parametros: cCodPro (C15)
// Retorno: string com a descricao (ou vazio)
// ------------------------------------------------------------
USER FUNCTION NomeProd(cCodPro)
    LOCAL cDesc := ""

    IF Empty(cCodPro)
        RETURN ""
    ENDIF

    cDesc := Posicione("SB1", 1, xFilial("SB1") + cCodPro, "B1_DESC")

RETURN AllTrim(cDesc)

// ------------------------------------------------------------
// PercNaoConf
// Calcula o percentual de nao conformidade
// Parametros: nQtdOk (numerico), nQtdNok (numerico)
// Retorno: numerico (percentual arredondado em 2 casas)
// Regra: %NC = (nQtdNok / (nQtdOk + nQtdNok)) * 100
// ------------------------------------------------------------
USER FUNCTION PercNaoConf(nQtdOk, nQtdNok)
    LOCAL nTotal := nQtdOk + nQtdNok

    IF nTotal <= 0
        RETURN 0
    ENDIF

RETURN Round((nQtdNok / nTotal) * 100, 2)

// ------------------------------------------------------------
// CertVencendo
// Verifica se o certificado vence em ate 30 dias
// Parametros: dValCer (data de validade)
// Retorno: .T. se vence em 30 dias ou menos (sem estar vencido)
// ------------------------------------------------------------
USER FUNCTION CertVencendo(dValCer)

    IF Empty(dValCer)
        RETURN .F.
    ENDIF

    // Vence em ate 30 dias, mas ainda nao venceu
    IF dValCer >= dDataBase .AND. dValCer <= (dDataBase + 30)
        RETURN .T.
    ENDIF

RETURN .F.

// ------------------------------------------------------------
// CertVencido
// Verifica se o certificado ja venceu
// Parametros: dValCer (data de validade)
// Retorno: .T. se ja passou da data atual
// ------------------------------------------------------------
USER FUNCTION CertVencido(dValCer)

    IF Empty(dValCer)
        RETURN .T.  // sem data = considerar vencido
    ENDIF

RETURN (dValCer < dDataBase)

// ------------------------------------------------------------
// GravarLogTCC
// Grava log tecnico de erro em arquivo texto
// Usado por todas as rotinas de gravacao protegida
// Parametros: cFuncao (nome da funcao), oErro (objeto de erro)
// Cria/atualiza: \logs\tcc_AAAAMMDD.log
// ------------------------------------------------------------
USER FUNCTION GravarLogTCC(cFuncao, oErro)
    LOCAL cArqLog  := "\logs\tcc_" + DToS(Date()) + ".log"
    LOCAL nHandle  := 0
    LOCAL cLinha   := ""

    Default cFuncao := "Nao informada"

    // Monta a linha do log
    cLinha := DToS(Date()) + " " + Time() + " | "
    cLinha += "Funcao: " + cFuncao + " | "
    cLinha += "Usuario: " + cNomUsr + " | "
    cLinha += "Empresa: " + cEmpAnt + " Filial: " + cFilAnt + " | "

    // Detalha conforme o tipo recebido
    IF ValType(oErro) == "O"
        cLinha += "Descricao: " + cValToChar(oErro:Description) + " | "
        cLinha += "Local: " + cValToChar(oErro:ProcName) + ":" + cValToChar(oErro:ProcLine) + " | "
        cLinha += "SubSistema: " + cValToChar(oErro:SubSystem) + " | "
        cLinha += "Operacao: " + cValToChar(oErro:Operation)
    ELSEIF ValType(oErro) == "C"
        cLinha += "Mensagem: " + oErro
    ELSE
        cLinha += "Erro nao identificado no fluxo."
    ENDIF

    // Cria o diretorio de logs se nao existir
    IF !ExistDir("\logs\")
        MakeDir("\logs\")
    ENDIF

    // Abre ou cria o arquivo e escreve no final
    IF File(cArqLog)
        nHandle := FOpen(cArqLog, FO_READWRITE + FO_SHARED)
    ELSE
        nHandle := FCreate(cArqLog)
    ENDIF

    IF nHandle > 0
        FSeek(nHandle, 0, FS_END)
        FWrite(nHandle, cLinha + CRLF)
        FClose(nHandle)
    ENDIF

RETURN NIL

