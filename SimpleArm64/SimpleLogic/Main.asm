  AREA  .drectve, DRECTVE

  AREA  .rdata, DATA, READONLY

  EXPORT  Main
  IMPORT  |__imp_ExitProcess|

  AREA  .text, CODE, ARM64

Main PROC
    
    stp   fp,lr,[sp,#-0x10]!
    mov   fp,sp

    mov   w1,#0xFF0000FF
    and   w0,w1,#0xFF00FF00

    mov   w1,#0xFF0000FF
    ands  w0,w1,#0xFF00FF00

    mov   w1,#0xFF0000FF
    orr   w0,w1,#0xFF00FF00

    mov   w1,#0xFF0000FF
    eor   w0,w1,#0xFF00FF00

    mov   w0,#0
    adrp  x8,__imp_ExitProcess
    ldr   x8,[x8,__imp_ExitProcess]
    blr   x8

 ENDP

 END
