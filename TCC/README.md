
# TCC — Sistema de Controle de Não Conformidades ISO 9001

## Integrantes
- Gabrielle (individual)

## Descrição do Sistema

Sistema desenvolvido para monitorar não conformidades na entrada de materiais dos fornecedores, em conformidade com o processo de certificação **ISO 9001**, integrado ao módulo de Compras (SIGACOM) do Protheus.

O sistema é composto por duas tabelas relacionadas (1:N):
- **ZZ1 — Controle de Fornecimento:** registra os certificados de qualidade dos fornecedores, com tolerância máxima de não conformidade (%) e validade do certificado.
- **ZZ2 — Ocorrências do Fornecedor:** registra cada inspeção de produto recebido, com quantidades conformes/não conformes e valor unitário.

A comparação entre o percentual real de não conformidade e a tolerância definida no certificado é feita automaticamente pelo browse (legenda colorida), permitindo ação imediata do time de Qualidade.

---

## Funcionalidades

- Browse (mBrowse) da ZZ1 com legenda colorida:
  - 🟢 Verde = certificado válido (vence em mais de 30 dias)
  - 🟡 Amarelo = certificado próximo do vencimento (até 30 dias)
  - 🔴 Vermelho = certificado vencido
- Browse da ZZ2 com legenda comparando % não conformidade × tolerância:
  - 🟢 Verde = dentro da tolerância
  - 🔴 Vermelho = acima da tolerância
- Botão "Ocorrências" na ZZ1 → abre a ZZ2 filtrada pelo controle selecionado
- Gravação protegida com `BEGIN SEQUENCE` + `BeginTran/CommitTran/RollBackTran`
- Log técnico de erros em arquivo texto (pasta `\logs\`)
- Biblioteca de funções comuns — princípio DRY, sem código duplicado
- Integridade referencial: impede excluir ZZ1 que possua ZZ2 vinculada

---

## Dicionário de Dados

### Tabelas (SX2)

| Prefixo | Descrição | Modo |
|---|---|---|
| ZZ1 | Controle de Fornecimento | C (Compartilhado) |
| ZZ2 | Ocorrências do Fornecedor | C (Compartilhado) |

### Campos — ZZ1 (SX3)

| # | Campo | Título | Tipo | Tam | Dec | Contexto | Observação |
|---|---|---|---|---:|---:|---|---|
| 1 | ZZ1_FILIAL | Filial | C | 2 | 0 | Real | Filial do sistema |
| 2 | ZZ1_CODIGO | Código | C | 6 | 0 | Real | Sequencial (GetSXENum) |
| 3 | ZZ1_FORNEC | Fornecedor | C | 6 | 0 | Real | FK → SA2 (A2_COD). Validação: ExistCpo |
| 4 | ZZ1_LOJAFO | Loja Fornec | C | 2 | 0 | Real | FK → SA2 (A2_LOJA) |
| 5 | ZZ1_NOMEFO | Nome Fornec | C | 40 | 0 | Virtual | Inic. Padrão: POSICIONE("SA2"...) |
| 6 | ZZ1_CERTIF | Certificado | C | 60 | 0 | Real | Número/descrição do certificado |
| 7 | ZZ1_VALCER | Validade | D | 8 | 0 | Real | Data de validade do certificado |
| 8 | ZZ1_TOLERA | Tolerância % | N | 5 | 2 | Real | Faixa: 0 a 100. Validação: faixa |
| 9 | ZZ1_TOTOK | Qtd Conforme | N | 12 | 2 | Real | Total de itens conformes |
| 10 | ZZ1_TOTNOK | Qtd Não Conf | N | 12 | 2 | Real | Total de itens não conformes |

### Campos — ZZ2 (SX3)

| # | Campo | Título | Tipo | Tam | Dec | Contexto | Observação |
|---|---|---|---|---:|---:|---|---|
| 1 | ZZ2_FILIAL | Filial | C | 2 | 0 | Real | Filial do sistema |
| 2 | ZZ2_CONFOR | Controle | C | 6 | 0 | Real | FK → ZZ1 (ZZ1_CODIGO). Validação: ExistCpo |
| 3 | ZZ2_FORNEC | Fornecedor | C | 6 | 0 | Real | Preenchido por gatilho via ZZ1 |
| 4 | ZZ2_LOJAFO | Loja Fornec | C | 2 | 0 | Real | Preenchido por gatilho via ZZ1 |
| 5 | ZZ2_NOMEFO | Nome Fornec | C | 40 | 0 | Virtual | Inic. Padrão: POSICIONE("SA2"...) |
| 6 | ZZ2_DATA | Data | D | 8 | 0 | Real | Gatilho: dDataBase (só inclusão) |
| 7 | ZZ2_HORA | Hora | C | 5 | 0 | Real | Gatilho: Time() (só inclusão) |
| 8 | ZZ2_CODPRO | Produto | C | 15 | 0 | Real | FK → SB1 (B1_COD). Validação: ExistCpo |
| 9 | ZZ2_QTDOK | Qtd Conforme | N | 12 | 0 | Real | Quantidade inspecionada OK |
| 10 | ZZ2_QTDNOK | Qtd Não Conf | N | 12 | 0 | Real | Quantidade não conforme |
| 11 | ZZ2_VLRUNI | Valor Unit | N | 12 | 2 | Real | Valor unitário do item |
| 12 | ZZ2_TOTOK | R$ Conforme | N | 12 | 2 | Virtual | = ZZ2_QTDOK × ZZ2_VLRUNI |
| 13 | ZZ2_TOTNOK | R$ Não Conf | N | 12 | 2 | Virtual | = ZZ2_QTDNOK × ZZ2_VLRUNI |

---

## Índices (SIX)

### ZZ1

| Ordem | Expressão | Descrição |
|---|---|---|
| 1 | `ZZ1_FILIAL + ZZ1_CODIGO` | Chave primária |
| 2 | `ZZ1_FILIAL + ZZ1_FORNEC + ZZ1_LOJAFO` | Por fornecedor |
| 3 | `ZZ1_FILIAL + DTOS(ZZ1_VALCER)` | Por validade do certificado |

### ZZ2

| Ordem | Expressão | Descrição |
|---|---|---|
| 1 | `ZZ2_FILIAL + ZZ2_CONFOR + DTOS(ZZ2_DATA) + ZZ2_HORA` | Chave primária |
| 2 | `ZZ2_FILIAL + ZZ2_FORNEC + ZZ2_LOJAFO + DTOS(ZZ2_DATA)` | Por fornecedor e data |
| 3 | `ZZ2_FILIAL + DTOS(ZZ2_DATA)` | Por data da ocorrência |

---

## Campos Virtuais — Inicializador Padrão (X3_RELACAO)

Campos virtuais **não são gravados no banco**. São calculados na exibição via `X3_RELACAO`.
Conforme orientação: campos virtuais **não usam gatilho (SX7)** — usam Inicializador Padrão.

| Campo | Expressão (X3_RELACAO) |
|---|---|
| ZZ1_NOMEFO | `POSICIONE("SA2",1,xFilial("SA2")+M->ZZ1_FORNEC+M->ZZ1_LOJAFO,"A2_NOME")` |
| ZZ2_NOMEFO | `POSICIONE("SA2",1,xFilial("SA2")+M->ZZ2_FORNEC+M->ZZ2_LOJAFO,"A2_NOME")` |
| ZZ2_TOTOK | `M->ZZ2_QTDOK * M->ZZ2_VLRUNI` |
| ZZ2_TOTNOK | `M->ZZ2_QTDNOK * M->ZZ2_VLRUNI` |

---

## Gatilhos (SX7) — apenas campos Reais

Gatilhos preenchem automaticamente campos **reais** no momento da digitação.

| Campo Origem | Campo Destino | Regra | Condição |
|---|---|---|---|
| ZZ2_CONFOR | ZZ2_FORNEC | `POSICIONE("ZZ1",1,xFilial("ZZ1")+M->ZZ2_CONFOR,"ZZ1_FORNEC")` | Sempre |
| ZZ2_CONFOR | ZZ2_LOJAFO | `POSICIONE("ZZ1",1,xFilial("ZZ1")+M->ZZ2_CONFOR,"ZZ1_LOJAFO")` | Sempre |
| ZZ2_DATA | ZZ2_DATA | `dDataBase` | Só na inclusão |
| ZZ2_HORA | ZZ2_HORA | `Time()` | Só na inclusão |

---

## Validações

| Tabela | Campo | Regra | Mensagem |
|---|---|---|---|
| ZZ1 | ZZ1_FORNEC | Fornecedor deve existir na SA2 | "Fornecedor não encontrado na SA2" |
| ZZ1 | ZZ1_TOLERA | Deve estar entre 0 e 100 | "Tolerância fora da faixa (0-100)" |
| ZZ1 | ZZ1_VALCER | Não pode ser anterior à data atual | "Validade não pode ser passada" |
| ZZ1 | Exclusão | Impede excluir se houver ZZ2 vinculada | "Controle possui ocorrências" |
| ZZ2 | ZZ2_CONFOR | Controle deve existir na ZZ1 | "Controle não encontrado na ZZ1" |
| ZZ2 | ZZ2_CODPRO | Produto deve existir na SB1 | "Produto não encontrado na SB1" |
| ZZ2 | ZZ2_DATA | Não pode ser data futura | "Data não pode ser futura" |

---

## Tratamento de Erros

Ambas as rotinas de gravação (STTZZ1GRV e STTZZ2GRV) seguem a estrutura de 4 camadas:

1. **Validação de negócio** — `IF` + `Break()` se faltar campo obrigatório
2. **Transação** — `BeginTran()` / `CommitTran()` / `RollBackTran()` (tudo ou nada)
3. **BEGIN SEQUENCE / RECOVER** — captura erros inesperados (banco, rede, lock)
4. **Log técnico** — `GravarLogTCC()` registra data, hora, usuário, função e descrição do erro

```
BeginTran()
BEGIN SEQUENCE
    // validações
    // RecLock + gravação
    // MsUnLock
RECOVER USING oErro
    RollBackTran()
    MsgStop("mensagem amigável")
    U_GravarLogTCC("funcao", oErro)
END SEQUENCE
IF lSucesso
    CommitTran()
ENDIF
```

---

## Biblioteca de Funções (STTZZLIB.PRW)

| Função | Parâmetros | Retorno | Descrição |
|---|---|---|---|
| `U_NomeFornec` | cFornec, cLoja | Caractere | Nome do fornecedor (SA2) |
| `U_NomeProd` | cCodPro | Caractere | Descrição do produto (SB1) |
| `U_PercNaoConf` | nQtdOk, nQtdNok | Numérico | % de não conformidade |
| `U_CertVencendo` | dValCer | Lógico | .T. se vence em até 30 dias |
| `U_CertVencido` | dValCer | Lógico | .T. se já venceu |
| `U_GravarLogTCC` | cFuncao, oErro | NIL | Grava log técnico em arquivo |

---

## Menu no SIGACOM

```
SIGACOM
  └── Cadastros
        └── Controle ISO 9001
              ├── Controle de Fornecimento  → U_STTZZ1
              └── Ocorrências               → U_STTZZ2
```

---

## Como executar

1. Compilar os fontes `.PRW` (STTZZ1, STTZZ2, STTZZLIB) no TDS/DevStudio
2. Importar o dicionário (SX2, SX3, SIX, SX7) no SIGACFG ou configurar manualmente conforme as tabelas acima
3. Acessar via SmartClient: SIGACOM → Cadastros → Controle ISO 9001
4. Ou executar diretamente: `U_STTZZ1()` no campo Programa Inicial

---

## Observações

- Projeto desenvolvido **sem ambiente Protheus disponível**
- Código escrito e comentado conforme apostilas dos Módulos 7, 8 e 9 da Jornada DEV START
- Dicionário de dados descrito integralmente neste README, conforme aceito pela rubrica
- Validações e tratamento de erros seguem o padrão "gravação à prova de falhas" (Módulo 9)
