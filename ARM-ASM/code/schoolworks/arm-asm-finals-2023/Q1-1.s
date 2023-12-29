MEM_ADD	EQU 	0x40000000
		AREA Q1_1, CODE
		ENTRY
		; r0 -> hold the memory address
		
]		LDR r0,=MEM_ADD

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
		
		
stop 	B	stop ; 411440117 Aster Chen

STRING 	DCB "THE SOURCE STRING", 0
		END