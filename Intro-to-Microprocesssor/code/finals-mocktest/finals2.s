Stack		EQU		0x00000100
MEMBase		EQU		0x40000000
aliasBase	EQU		0x42000000
SPSTART		EQU		0x40000080
ADD1		EQU		0x43070010
ADD2 		EQU 	0x40083800
			AREA	STACK, NOINIT, READWRITE, ALIGN=3
StackMem
			SPACE	Stack
			PRESERVE8
		
			AREA	finals2, CODE, READONLY
			THUMB
; 0x40000000, 0x41000000
; The vector table sits here

			DCD		StackMem + Stack	; Top of Stack
			DCD		Reset_Handler		; Reset Handler
		
			EXPORT	Reset_Handler
			; TM4C1233H6PM
			ENTRY
		
Reset_Handler			
			; (1)
			; alias = alias base + (byte offset x 32) + (bit number x 4)
			; for the alias 0x4307.0010
			; 0x4307.0010 - 0x4200.0000 = 0x0107.0010
			; -> 0x0107.0010 = 0x0107.0000 + 0x0000.0010
			; -> byte offset = 0x0107.0000 / 0x20 = 0x8.3800
			; -> bit number = 0x10 / 0x4 = 0x4
			; the bit address = 0x4000.0000 + 0x8.3800 = 0x4008.3800
			; with bit 4 as its destination
			
			; (2)
			; set the bit in (1) without using bit-band operations
			LDR		r0, =ADD2
			MOV		r1, #0x10	; setting bit 4
			STRB	r1, [r0]
			
			
			; (3)
			; write a sqeuence of instructions to
			; (3)-(a)
			; read bit 12 of a word at address 0x40038000 (with bit-banded operations)
			; the alias = (0x38000 x 0x20) + (12 x 4) + 0x42000000 = 0x42700030
			LDR		r0, =0x42700030
			STR		r1, [r0]
			
			; (3)-(b)
			; read bit 12 of a word at address 0x40038000 (without bit-banded operations)
			LDR		r0, =0x40038000
			STR		r1, [r0]
			LSR		r1, r1, #12		; get bit 12 to position 0
			AND		r1, r1, #1		; get bit 12
			
			; (4)
			; use (3) as a test case
			LDR		sp, =SPSTART

			; (4)-(a)
			LDR		r2, =0x38000
			LDR		r3, =12
			BL		Conv2Alias
			; (4)-(b)
			LDR		r1, =0x42700030
			BL		Conv2Region
stop		B		stop

; Subroutine
; input: r2, r3
; output: r1
;
; r1 - bit-banded alias 
; r2 - byte offset (address of a word in the bit-banded region)
; r3 - bit number

Conv2Alias
			STMFD	sp!, {r5, r6, r7, LR}
			; alias = alias base + (byte offset x 32) + (bit number x 4)
			LDR		r6, =aliasBase
			MOV		r1, r6
			
			MOV		r5, #0x20	; 32
			MUL		r6, r2, r5 
			ADD		r1, r6
		
			MOV		r5, #0x4	; 4
			MUL		r6, r3, r5 
			ADD		r1, r6
			
			LDMFD	sp!, {r5, r6, r7, PC}

; Subroutine
; input: r1
; output: r2, r3
;
; r1 - bit-banded alias
; r2 - byte offset (address of a word in the bit-banded region)
; r3 - bit number

Conv2Region
			STMFD	sp!, {r5, r6, r7, LR}
			; alias = alias base + (byte offset x 32) + (bit number x 4)
			LDR		r6, =aliasBase
			SUB		r7, r1, r6	; (byte offset x 32) + (bit number x 4)
			
			BIC		r6, r7, #0x3F
			LSR		r2, r6, #5	; byte offset
			AND		r6, r7, #0x3F; bit number x 4
			LSR		r3, r6, #2	; bit number
			
			LDMFD	sp!, {r5, r6, r7, PC}
			
			ALIGN
			END