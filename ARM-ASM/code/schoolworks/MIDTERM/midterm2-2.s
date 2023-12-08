MEM_ADD	EQU		0x40000010
		AREA midterm_2_1, CODE, READONLY
		ENTRY	;411440117 Aster Chen
		LDR		r0, =MEM_ADD
		ADR		r2, table
		LDR		r1, [r2]
		STR		r1, [r0]
		LDR		r1, [r2, #4]
		STR		r1, [r0, #16]
		LDR		r1, [r2, #8]
		STR		r1, [r0, #32]
		
		LDR		r1, [r0] ;address 10
		LDR		r2, =0xFFFFFFFF
loop1 	TST		r1, r2		; Qa
		AND 	r3, r1, #1
		LSR		r1, r1, #1
		ADD		r4, r4 ,r3
		BNE		loop1
		; 411440117 Aster Chen
		LDR		r1, [r0, #16] ;address 20
loop2	CMP		r1, #0		; Qb
		AND 	r3, r1, #1
		LSR		r1, r1, #1
		ADD		r5, r5 ,r3
		BNE		loop2

		LDR		r1, [r0, #32] ;address 30
loop3	TST		r1, r2		;Qc
		AND 	r3, r1, #1
		LSR		r1, r1, #1
		ADD		r6, r6 ,r3
		BNE		loop3

		LDR		r1, [r0, #16]
		LDR		r7, [r0, #32]
		EOR		r7, r1, r7
loop4	CMP		r7, #0 		;Qd
		AND		r3, r7, #1
		LSR		r7, r7, #1
		ADD		r8, r8, r3
		BNE		loop4

		STR		r4, [r0, #48]!
		STR		r5, [r0, #4]!
		STR		r6, [r0, #4]!
		STR		r8, [r0, #4]!
stop	B 		stop
table	DCD		0xDEADABCD, 0xABCD8765, 0xBEEFFACE
		END		;411440117 Aster Chen
