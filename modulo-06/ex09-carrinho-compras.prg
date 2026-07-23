

FUNCTION Main()
   LOCAL aCarrinho := {}
   LOCAL cProduto, cPreco, cContinuar
   LOCAL nTotal := 0
   LOCAL nI

   QOut("=== CARRINHO DE COMPRAS ===")
   QOut("(Digite os produtos. Para encerrar, responda N)")
   QOut("")

   // --- Loop de adição de itens ---
   WHILE .T.
      ACCEPT "Nome do produto: " TO cProduto
      ACCEPT "Preço (R$): " TO cPreco

      // Adiciona {nome, preco} ao carrinho
      AADD(aCarrinho, {cProduto, Val(cPreco)})

      QOut("  ✓ " + cProduto + " adicionado!")
      QOut("")

      ACCEPT "Adicionar outro item? (S/N): " TO cContinuar
      IF Upper(cContinuar) != "S"
         EXIT
      ENDIF
      QOut("")
   ENDDO

   // --- Exibe o carrinho final ---
   QOut("")
   QOut("========================================")
   QOut("         SEU CARRINHO")
   QOut("========================================")

   FOR nI := 1 TO Len(aCarrinho)
      QOut(Str(nI, 2) + ". " + aCarrinho[nI][1] + " - R$ " + Str(aCarrinho[nI][2], 8, 2))
      nTotal += aCarrinho[nI][2]
   NEXT

   QOut("----------------------------------------")
   QOut("TOTAL: R$ " + Str(nTotal, 10, 2))
   QOut("========================================")

RETURN NIL

