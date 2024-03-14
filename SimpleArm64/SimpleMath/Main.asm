  AREA  .drectve, DRECTVE

  AREA  .rdata, DATA, READONLY

  EXPORT  Main
  IMPORT  |__imp_ExitProcess|

  AREA  .text, CODE, ARM64

Main PROC
    
    stp   fp,lr,[sp,#-0x10]!
    mov   fp,sp

    mov   x0,#0
    mov   x1,#1
    add   x0,x1,#1

    mov   x0,#0
    mov   x1,#255
    sub   x0,x1,#1

    mov   x0,#0
    mov   x1,#128
    sub   x0,x1,#1

    mov   x0,#0
    mov   x1,#1
    neg   x0,x1

    mov   x0,#0
    mov   x1,#4
    mov   x2,#4
    mul   x0,x1,x2

    ;x0 = x1 * x2 + x3
    ;madd  x0,x1,x2,x3
    
    mov   x0,#0
    mov   x1,#10
    mov   x2,#2
    udiv  x0,x1,x2

    mov   x0,#0
    mov   x1,#32
    mov   x2,#2
    sdiv  x0,x1,x2

    mov   w0,#0
    adrp  x8,__imp_ExitProcess
    ldr   x8,[x8,__imp_ExitProcess]
    blr   x8

 ENDP

 END
