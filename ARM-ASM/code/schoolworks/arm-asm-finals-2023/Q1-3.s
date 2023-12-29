		AREA Q1_3, CODE
		ENTRY
		; r0 -> hold the memory address
		; r1 ->
		
		LDR r0, =0xDEADFACE
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
		
stop 	B	stop ; 411440117 Aster Chen

		END