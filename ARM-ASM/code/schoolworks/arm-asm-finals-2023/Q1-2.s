MEM_ADD	EQU 	0x40000000
		AREA Q1_2, CODE
		ENTRY
		; r0 -> hold the memory address
		; r1 ->
		
		LDR r0, =MEM_ADD
		ADR r1, TABLE
		MOV r7, #8
loop	MOV r3, #0
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
		
		SUB r7, r7, #1
		CMP r7, #0
		BNE loop
		
stop 	B	stop ; 411440117 Aster Chen
	
TABLE  	DCD 0x00000013, 0x80808080, 0xFFFF0000, 0x1111FFFF
		DCD 0xFEBBAAAA, 0x12340000, 0x88881111, 0x22227777

		END