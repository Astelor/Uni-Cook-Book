MEM_ADD	EQU		0x40000000
		AREA midterm_3, CODE, READONLY
		ENTRY	;411440117 Aster Chen
		LDR		r0, =MEM_ADD
		ADR 	r1, data1 	; Q1
		ADR		r2, data2
		ADR		r3, data3
		ADR		r4, data4
		ADR 	r5, data5

loop1	; Q2 411440117 Aster Chen
		LDRB	r6, [r1], #1
		STRB	r6, [r0], #1
		CMP		r6, #0
		BNE		loop1
		
		LDR		r7, =MEM_ADD
		ADD 	r7, r7, #0x30
loop2	; Q3 411440117 Aster Chen
		LDRB	r6, [r0], #-1
		STRB	r6, [r7], #1
		CMP		r0, #MEM_ADD
		BGE		loop2

		LDR		r0, =MEM_ADD
		ADD 	r0, r0, #0x60
loop3	; Q4 411440117 Aster Chen
		LDRB	r6, [r2], #1
		STRB	r6, [r0], #1
		CMP		r2, r3
		BNE		loop3
		
		LDR		r0, =MEM_ADD
		ADD 	r0, r0, #0x70
loop4	; Q5 411440117 Aster Chen
		LDRB	r6, [r3], #1
		STRB	r6, [r0], #1
		CMP		r3, r4
		BNE		loop4
	
		LDR		r7, =MEM_ADD
		ADD		r8, r7, #0x70
		ADD 	r7, r7, #0x90
		SUB		r0, r0, #1
loop5	; Q6 411440117 Aster Chen
		LDRB	r6, [r0], #-1
		STRB	r6, [r7], #1
		CMP		r0, r8
		BGE		loop5

		LDR		r0, =MEM_ADD
		ADD		r0, r0, #0xB0
loop6 	; Q7 411440117 Aster Chen
		LDRB	r6, [r4], #1
		STRB	r6, [r0], #1
		CMP		r4, r5
		BNE		loop6

		LDR		r0, =MEM_ADD
		ADD		r0, r0, #0xC0
		ADR		r7, data5
		ADD		r7, r7, #24
loop7	; Q8 411440117 Aster Chen
		LDRB	r6, [r5], #1
		STRB	r6, [r0], #1
		CMP		r5,	r7
		BNE		loop7

		ADR		r5, data5
loop8	; Q9 411440117 Aster Chen
		LDR		r6, [r5], #4
		ADD		r9, r9, r6
		CMP 	r5, r7
		BNE		loop8

		LDR		r0, =MEM_ADD
		STR		r9, [r0, #0xE0]

stop	B 		stop
data1   DCB 	"Midterm Exam in Fall 2023!", 0 
data2   DCW 	0x1234, 0x5678, 0xBEEF, 0xFACE  
data3   DCD 	0x8ECC, 0xFE37, 0xABCD, 1, 5, 0x1234FACE
data4   DCB 	0xCF, 23, 39, 0x54, 250, 0xFF, 0xAD 
data5   DCD 	0xFE37, 1, 5, 20, 0xABCDFACE, 0x12345678 
		END		;411440117 Aster Chen