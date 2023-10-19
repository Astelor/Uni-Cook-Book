		AREA popquiz2_1, CODE, READONLY
		ENTRY	;411440117 Aster Chen
		LDR 	r2, =25 	; n
		LDR 	r3, =11		; m
		LDR		r4, =6
		MOV		r6, #2
		MOV		r7, #4
		MOV		r8, #8
		MOV		r9, #17
		
		MOV		r1, #1
loop1	CMP 	r2, #0
		MULGT 	r1, r6, r1
		SUBGT	r2, r2, #1
		BGT		loop1
		MOV		r6, r1
		
		MOV		r1, #1
loop2	CMP 	r3, #0
		MULGT 	r1, r7, r1
		SUBGT	r3, r3, #1
		BGT		loop2
		MOV		r7, r1
		; 411440117 Aster Chen
		MOV		r1, #1
loop3	CMP 	r4, #0
		MULGT 	r1, r8, r1
		SUBGT	r4, r4, #1
		BGT		loop3
		MOV		r8, r1

		ADD		r5, r5, r6
		ADD		r5, r5, r7
		ADD		r5, r5, r8
		SUB		r5, r5, r9
stop	B 		stop
		END		;411440117 Aster Chen