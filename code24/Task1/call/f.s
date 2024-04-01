	EXPORT f
	PRESERVE8
	AREA f,CODE,READONLY
	ENTRY
	IMPORT g
	PUSH {lr}
	MOVS r0, #2
	ADDS r1, r0, r0
	ADDS r2, r1, r0
	ADDS r3, r1, r1
	BL g
	POP {pc}
	END
