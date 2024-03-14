  AREA  .drectve, DRECTVE

  AREA  .rdata, DATA, READONLY

;Bajt (8 bitów)
var1 DCB 255

;Pół słowa komputerowego (16 bitów, 2 bajty)
var2 DCW 0xBAD ;16 bitów (pół słowa komputerowego)
var3 DCWU 0xBAD  ;16 bitów (pół słowa, bez wyrównania)

;Słowo (ang. word) w ARM64 ma 32 bity (4 bajty).
;Natomiast słowo w x64/x86 ma 16 bitów (2 bajty).
var4 DCD 0xC0FFEE ;32 bity (słowo komputerowe)
var5 DCDU 0x0234 ;32 bity (4 bajty, słowo niewyrównane)
var6 DCD 1,2,3,4 ;Cztery słowa komputerowe (4 razy 32-bity)

var7 DCQ 13 ;Zmienna o rozmiarze 8 bajtów (64-bity)

var8 SPACE 255 ;Zmienna o rozmiarze 255 bajtów (wypełniona zerami)
var9 FILL 50,0xCC,1 ;Zmienna 50 bajtów wypełniona 0xCC (1 to rozmiar wartości)

NULL EQU 0x00

  EXPORT  Main
  IMPORT  |__imp_ExitProcess|

  AREA  .text, CODE, ARM64

Main PROC
    
    stp   fp,lr,[sp,#-0x10]!
    mov   fp,sp

    ;Przykładowa wartość szesnastkowa wpisana do rejestru w1 (32 bity)
    mov   w1, 0xBAD

    ;Wpisanie wartości rejestru w1 do rejestru w0
    mov   w0, w1

    ;Wpisanie przykładowych wartości natychmiastowych do rejestru x0
    mov   x0, #-1
    mov   x0, #0xFF
    mov   x0, #3
    mov   x0, NULL

    ;Wczytanie do rejestru x1 adresu zmiennej var7
    adrp  x1,var7
    ;Wczytanie do x1 wartości spod adresu zmiennej var7
    ldr   x1,[x1,var7]

    mov   w0,#0
    adrp  x8,__imp_ExitProcess
    ldr   x8,[x8,__imp_ExitProcess]
    blr   x8

 ENDP

 END
