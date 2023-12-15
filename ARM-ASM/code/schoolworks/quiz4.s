MEM_ADD	EQU		0x40000000
		AREA	quiz, CODE
		ENTRY
		; registers used
		; r0 - temp
		; r1 - used to hold address of memory
		; r2 - temp
		; r3 - used to hold the data with parity
		; r4 - temp
main	; 411440117 Aster Chen 
		LDR	r1, =MEM_ADD
		ADR r0, data
		LDR	r2, [r0], #4
		STR	r2, [r1], #4
		LDR	r2, [r0], #4
		STR	r2, [r1], #4
		LDR	r2, [r0], #4
		STR	r2, [r1], #4
		LDR	r2, [r0], #4
		STR	r2, [r1], #4
		
		; question 1----------------------------------------------|
		LDR	r1, =MEM_ADD
		LDR	r0, [r1]				; load data in address MEM_ADD+0
		ROR r2, r0, #2 				; get bit 2
		EOR	r2, r2, r0, ROR #4
		EOR	r2, r2, r0, ROR #6
		EOR	r2, r2, r0, ROR #8
		
		AND	r2, r2, #1				; isolate bit
		EOR	r2, r2, #1				; invert the bit for odd parity
		LDR	r0, [r1, #8]			; load data in address MEM_ADD+8
		ROR r4, r0, #7				; get bit 7
		BIC	r4, r4, #1				; clear the bit (idk what else can I do it)
		ADD	r4, r4, r2				; add the single bit
		ROR	r3, r4, #25				; rotate back to normal
		STR	r3, [r1, #8]			; store it back to memory
		
		; 411440117 Aster Chen 
		; question 2----------------------------------------------|
		LDR	r1, =MEM_ADD
		LDR	r0, [r1, #4]			; load data in address MEM_ADD+4
		ROR r2, r0, #1 				; get bit 2
		EOR	r2, r2, r0, ROR #3
		EOR	r2, r2, r0, ROR #5
		EOR	r2, r2, r0, ROR #7
		EOR	r2, r2, r0, ROR #9
		
		AND	r2, r2, #1				; isolate bit
		;EOR	r2, r2, #1				; invert the bit for odd parity
		LDR	r0, [r1, #12]			; load data in address MEM_ADD+12
		ROR r4, r0, #9				; get bit 9
		BIC	r4, r4, #1				; clear the bit (idk what else can I do it)
		ADD	r4, r4, r2				; add the single bit
		ROR	r3, r4, #23				; rotate back to normal
		STR	r3, [r1, #12]			; store it back to memory


stop 	B 	stop
data 	DCD	0x8765ABCD
		DCD 0xABCD8765
		DCD 0xFACEBEEF
		DCD 0xDEADBEEF
		END