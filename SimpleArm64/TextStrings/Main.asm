  AREA  .drectve, DRECTVE

  AREA  .rdata, DATA, READONLY

  EXPORT  Main
  IMPORT	|__imp_GetStdHandle|
  IMPORT	|__imp_ExitProcess|
  IMPORT	|__imp_WriteConsoleA|

  AREA  .text, CODE, ARM64

Main PROC
    
	stp   fp,lr,[sp,#-0x40]!
	mov   fp,sp
	str   x0,[sp,#0x20]
	str   x1,[sp,#0x28]
	str   x2,[sp,#0x30]
	str   w3,[sp,#0x14]

	mov   w0,#-0xB
	adrp  x8,__imp_GetStdHandle
	ldr   x8,[x8,__imp_GetStdHandle]
	blr   x8
	mov   x8,x0
	str   x8,[sp,#0x18]

	ldr   x8,[sp,#0x18]
	cmp   x8,#0
	beq   |EXIT|
	ldr   x8,[sp,#0x18]
	cmn   x8,#1  ;-1 + 1 = 0
	beq   |EXIT|

	mov   w8,#0
	str   w8,[sp,#0x10]

	mov   x4,#0
	add   x3,sp,#0x10
	mov   w2,#42       ;szHello text length here!
	adrp  x8,szHello
	add   x1,x8,szHello
	ldr   x0,[sp,#0x18]
	adrp  x8,__imp_WriteConsoleA
	ldr   x8,[x8,__imp_WriteConsoleA]
	blr   x8

|EXIT|
    mov   w0,#0
    adrp  x8,__imp_ExitProcess
    ldr   x8,[x8,__imp_ExitProcess]
    blr   x8

szHello   DCB "Hello world! This is console application!", 0x00

 ENDP

 END
