  AREA  .drectve, DRECTVE

  AREA  .rdata, DATA, READONLY
szText DCB "Windows Arm64 Assembly Language", 0x0

  EXPORT  Main
  IMPORT  |__imp_ExitProcess|
  IMPORT  |__imp_MessageBoxA|

  AREA  .text, CODE, ARM64

Main PROC
    
    stp   fp,lr,[sp,#-0x10]!
    mov   fp,sp

    ;bezwarunkowe wywołanie procedury
    bl ProcedureExample

    mov   w0,#0
    adrp  x8,__imp_ExitProcess
    ldr   x8,[x8,__imp_ExitProcess]
    blr   x8

 ENDP

   AREA  .text, CODE, ARM64

ProcedureExample PROC
    
    stp   fp,lr,[sp,#-0x20]!
    mov   fp,sp

    mov   w3,#0
    adrp  x8,szText
    add   x2,x8, szText
    adrp  x8,szText
    add   x1,x8, szText
    mov   x0,#0
    adrp  x8,__imp_MessageBoxA
    ldr   x8,[x8,__imp_MessageBoxA]
    blr   x8
    
    ldp   fp,lr,[sp],#0x20
    ret
 ENDP

 END
