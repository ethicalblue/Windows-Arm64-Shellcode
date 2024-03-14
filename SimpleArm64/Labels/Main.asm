  AREA  .drectve, DRECTVE

  AREA  .rdata, DATA, READONLY

  EXPORT  Main
  IMPORT  |__imp_ExitProcess|

  AREA  .text, CODE, ARM64

Main PROC
    
    stp   fp,lr,[sp,#-0x10]!
    mov   fp,sp

    mov   x0,#0
    tst   x0,x0  ;Sprawdź czy w rejestrze x0 jest wartość zero
    beq   |FAIL| ;Jeśli tak, to przejdź do etykiety |FAIL|
    b     |EXIT| ;W przeciwnym wypadku bezwarunkowe przejście do |EXIT|
|FAIL|
    mov   w0,#-1 ;Do rejestru w0 wpisz -1.
                 ;Będzie to kod powrotu funkcji ExitProcess
                 ;zwracany do systemu Windows.
|EXIT|
    adrp  x8,__imp_ExitProcess
    ldr   x8,[x8,__imp_ExitProcess]
    blr   x8

 ENDP

 END
