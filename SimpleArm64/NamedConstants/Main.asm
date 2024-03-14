  AREA  .drectve, DRECTVE

  AREA  .rdata, DATA, READWRITE
|FORMAT| DCB "%d = %#08x",0x00
|DEST|   DCB 0x00,0x00,0x00,0x00
         DCB 0x00,0x00,0x00,0x00
         DCB 0x00,0x00,0x00,0x00
         DCB 0x00,0x00,0x00,0x00
         DCB 0x00,0x00,0x00,0x00
         DCB 0x00,0x00,0x00,0x00
         DCB 0x00,0x00,0x00,0x00
         DCB 0x00,0x00,0x00,0x00

;Bufor |DEST| musi być na tyle duży,
;aby zmieścić wynikowy napis.
;W języku wysokiego poziomu można
;łatwo użyć bezpieczniejszej funkcji
;na przykład: StringCChPrintf z pliku strsafe.h

ONE EQU 1
TWO EQU ONE+ONE
TRUE EQU 1
FALSE EQU 0
NULL EQU 0
MINUS1 EQU -1
LETTER_A EQU 'A'
SYNONYM * 4 ;gwiazdka to alternatywna składnia do EQU

  EXPORT  Main
  IMPORT  |__imp_ExitProcess|
  IMPORT  |__imp_wsprintfA|
  IMPORT  |__imp_MessageBoxA|

  AREA  .text, CODE, ARM64

Main PROC
    
    stp   fp,lr,[sp,#-0x20]!
    mov   fp,sp

    mov   w3,MINUS1 ;tutaj można wpisywać stałe do wyświetlenia
    mov   w2,w3
	adrp  x8,|FORMAT|
	add   x1,x8,|FORMAT|
	adrp  x8,|DEST|
	add   x0,x8,|DEST|
	adrp  x8,__imp_wsprintfA
	ldr   x8,[x8,__imp_wsprintfA]
	blr   x8

|MSGBOX|
    mov   w3,#0
    adrp  x8,|DEST|
    add   x2,x8,|DEST|
    adrp  x8,|DEST|
    add   x1,x8,|DEST|
    mov   x0,#0
    adrp  x8,__imp_MessageBoxA
    ldr   x8,[x8,__imp_MessageBoxA]
    blr   x8

|EXIT|
    mov   w0,#0
    adrp  x8,__imp_ExitProcess
    ldr   x8,[x8,__imp_ExitProcess]
    blr   x8

 ENDP

 END
