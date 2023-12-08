		AREA popquiz2_2, CODE, READONLY
		ENTRY	;411440117 Aster Chen
		LDR		r0, =0xFFFFFFFF	; -1 (mask)
		LDR		r3, =66			; x
		LDR		r4, =44			; y
		LDR		r5, =4			; 4xy
		LDR		r6, =7			; 7x
		LDR		r7, =19			; +19
				
		EOR		r3, r3, r0
		ADD		r3, r3, #1		; x = -66
		MUL		r5, r3, r5 ; 4x
		MUL		r5, r4, r5 ; 4xy
		
		MUL		r6, r3, r6 ; 7x
		
		ADD		r2, r2, r5
		SUB		r2, r2, r6
		ADD		r2, r2, r7
stop	B 		stop
		END		;411440117 Aster Chen