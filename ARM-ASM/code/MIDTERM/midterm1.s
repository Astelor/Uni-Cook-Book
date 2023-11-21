MEM_ADD	EQU		0x40000000
		AREA midterm_1, CODE, READONLY
		ENTRY	;411440117 Aster Chen
		LDR		r0, =MEM_ADD
		LDR		r1, =0xBEEFFACE
		STR		r1, [r0]
		LDR		r2, =0x8765 ; Q1
		LDR 	r6, =0xF0000FFF ;mask 4
		AND 	r1, r1, r6
		ADD		r1, r1, r2, LSL #12
		; Q2
		LDR		r3, =0x22220 ;mask1 (5,9,13,17)
		EOR		r1, r3, r1
		; Q3
		LDR		r1, [r0]	; reset
		LDR		r4, =0xFFFEFB7F ;mask 2 (7,10,16)
		AND		r1, r4, r1
		; Q4
		LDR		r1, [r0]	; reset
		LDR		r4, =0x10480 ;mask 2 (7,10,16)
		BIC		r1, r4
		; Q5
		LDR		r1, [r0]	; reset
		LDR		r5, =0x6040000 ;mask 3 (mask3 18, 25, 26)
		EOR		r1, r5, r1
		
stop	B 		stop
		END		;411440117 Aster Chen