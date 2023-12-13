	AREA	|.drectve|, DRECTVE

	EXPORT	|WinMain|

	AREA	|.text|, CODE, ARM64

|WinMain| PROC
|START|
	stp         x19,x20,[sp,#-0x20]!
	str         x21,[sp,#0x10]
	stp         fp,lr,[sp,#-0x10]!
	mov         fp,sp

	ldr         x8,[xpr,#0x60]

	ldr         x9,[x8,#0x18]
	ldr         x10,[x9,#0x20]
	ldr         x11,[x10]
	ldr         x8,[x11]

	ldr         x21,[x8,#0x20]

	ldr         w9,[x21,#0x3C]

	add         x8,x21,w9,sxtw #0
	ldr         w10,[x8,#0x88]
	add         x13,x21,w10,uxtw #0

	mov         w10,#0
	ldr         w8,[x13,#0x20]
	ldr         w11,[x13,#0x18]
	add         x12,x21,w8,uxtw #0
	cbz         w11,|LABEL2|
	ldr         x14,|szGetProcA|
|LABEL1|

	ldr         w8,[x12,w10 uxtw #2]
	ldr         x9,[x21,w8 uxtw #0]
	cmp         x9,x14
	beq         |LABEL2|

	add         w10,w10,#1
	cmp         w10,w11
	blo         |LABEL1|
|LABEL2|

	ldr         w9,[x13,#0x24]

	ubfiz       x8,x10,#1,#0x20
	ldr         w10,[x13,#0x1C]

	mov         x0,x21
	add         x9,x8,w9,uxtw #0
	ldrsh       w11,[x9,x21]
	add         x8,x10,w11,sxtw #2
	ldr         w9,[x8,x21]
	adrp        x8,|szUser32|
	add         x19,x8,|szUser32|
	add         x1,x19,#0x20
	add         x20,x21,w9,sxtw #0
	blr         x20
	mov         x8,x0

	mov         x0,x19
	blr         x8

	adrp        x8,|szMessageBoxA|
	add         x1,x8,|szMessageBoxA|
	blr         x20

	mov         w3,#0
	add         x2,x19,#0x30
	mov         x8,x0
	mov         x0,#0
	add         x1,x19,#0x30
	blr         x8

	add         x1,x19,#0x10
	mov         x0,x21
	blr         x20
	mov         x8,x0

	mov         w0,#0
	blr         x8
	ldp         fp,lr,[sp],#0x10
	ldr         x21,[sp,#0x10]
	ldp         x19,x20,[sp],#0x20
	ret

|szGetProcA| DCQ 0x41636f7250746547
|szUser32| DCB "user32.dll", 0x00
|szExitProcess| DCB "ExitProcess", 0x00
|szLoadLibraryA| DCB "LoadLibraryA", 0x00
|szMessageBoxA| DCB "MessageBoxA", 0x00
|szEthicalBlue| DCB "ethical.blue Magazine "
	DCB	"// Cybersecurity clarified.", 0x00

	ENDP

	END
