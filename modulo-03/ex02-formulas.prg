REQUEST HB_CODEPAGE_PT850

#define PI 3.14159

FUNCTION Main()

    LOCAL nRaio, nPeso, nAltura
    LOCAL nCatetoA, nCatetoB
    LOCAL nArea, nHipotenusa, nIndice

hb_cdpSelect("PT850")

    
    INPUT "Digite o raio do c¡rculo: " TO nRaio
        nArea := PI * (nRaio ^ 2) // Calcula a  rea do c¡rculo

    INPUT "Digite o primeiro cateto: " TO nCatetoA

    INPUT "Digite o segundo cateto: " TO nCatetoB
        nHipotenusa := Sqrt((nCatetoA ^ 2) + (nCatetoB ^ 2))  // Calcula a hipotenusa

    INPUT "Digite o peso (kg): " TO nPeso

    INPUT "Digite a altura (m): " TO nAltura
        nIndice := nPeso / (nAltura ^ 2) // Calcula o IMC
      
    ? "µrea do c¡rculo: " + Str(nArea, 10, 2)
    ? "Hipotenusa: " + Str(nHipotenusa, 10, 2)
    ? "IMC: " + Str(nIndice, 10, 2)

RETURN NIL