MEM_ADD	EQU 	0x40000000
		AREA Q2_1, CODE
		ENTRY
		; r0 -> hold the memory address
		; r1 ->
		
		LDR r0, =MEM_ADD
		ADR r1, TABLE
		BL func1		; repeat 8 times
		BL func1
		BL func1
		BL func1
		BL func1
		BL func1
		BL func1
		BL func1
		
		BL func2
		BL func3
stop 	B	stop

func1
        MOV r3, #0
        MOV r4, #0
        LDR r5, [r1],#4
loop1	
        LSR r2, r5, r3
        AND r2, r2, #0xF
        LSL r4, r4, #4
        ADD r4, r4, r2 ; r4 has the reversed data
        ADD r3, r3, #4
        CMP r3, #32
        BNE loop1
		STR r4, [r0],#4
		
        BX lr

func2
		LDR r0,=MEM_ADD
		ADD r0, r0, #0x50
		ADR r1, STRING
test	LDRB r5, [r1],#1
		CMP r5, #0
		BNE test
		SUB r1, r1, #2
loop2
		LDRB r5, [r1],#-1
		STRB r5, [r0],#1
		CMP r1, #STRING
		BGE loop2
		BX lr
		
func3
		LDR r0, =0xFACEBEEF
		MOV r2, #0
		MOV r4, #0
loop3
		LSR r3, r0, r2
		LSL r4, r4, #1
		
		AND r3, r3, #1
		ADD r4, r4, r3
		ADD r2, r2, #1
		CMP r2, #32
		BNE loop3
		BX lr

TABLE  	DCD 0xFEBBAAAA, 0x12340000, 0x88881111, 0x22227777
		DCD 0x00000013, 0x80808080, 0xFFFF0000, 0x1111FFFF
STRING 	DCB "The (source) string", 0
		END