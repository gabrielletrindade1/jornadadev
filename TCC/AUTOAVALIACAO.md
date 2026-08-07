
# Autoavaliação — TCC Controle ISO 9001

## Itens entregues

| # | Critério | Entregue? | Observação |
|---|---|---|---|
| 1 | Dicionário (tabelas, campos, índices) | ✅ Sim | Descrito no README.md com tipos, tamanhos e índices completos |
| 2 | Rotinas funcionais (mBrowse, legendas, filtro) | ✅ Sim | STTZZ1.PRW e STTZZ2.PRW com legendas e filtro por ZZ1 |
| 3 | Validações de dados | ✅ Sim | Fornecedor (SA2), tolerância (0-100), datas, produto (SB1), controle (ZZ1) |
| 4 | Gatilhos/Campos virtuais (SX7 + X3_RELACAO) | ✅ Sim | Gatilhos em campos reais (fornec, data, hora); virtuais via Inic. Padrão |
| 5 | Tratamento de erros (BEGIN SEQUENCE) | ✅ Sim | STTZZ1GRV e STTZZ2GRV com transação + rollback + log |
| 6 | Biblioteca de funções (STTZZLIB.PRW) | ✅ Sim | NomeFornec, NomeProd, PercNaoConf, CertVencendo, GravarLogTCC |
| 7 | Menu no SIGACOM | ✅ Sim | Descrito no README (Cadastros > Controle ISO 9001) |
| 8 | Documentação (README.md) | ✅ Sim | Descrição completa do sistema, tabelas, validações e instalação |

## Diferenciais implementados

- [x] Comentários de cabeçalho em todos os fontes (função, parâmetros, autor, data)
- [x] Zero duplicação de código (funções centralizadas na STTZZLIB)
- [x] Legenda da ZZ2 comparando % NC com tolerância do certificado
- [x] Integridade referencial (impede excluir ZZ1 com ZZ2 vinculada)
- [x] Distinção correta entre gatilho SX7 (campo real) e Inic. Padrão (campo virtual)
- [ ] Classe ADVPL (POO) — não implementada

## Observações
- Sem ambiente Protheus disponível — código escrito e comentado conforme apostilas
- Dicionário de dados descrito por escrito no README (aceito pela rubrica)
