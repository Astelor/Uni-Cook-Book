Stack		EQU		0x00000100
DivbyZ		EQU		0xD14
SYSHNDCTRL	EQU		0xD24
Usagefault	EQU		0xD2A
NVICBase	EQU		0xE000E000
ADD1		EQU		0x20000130
ADD2		EQU		0x20000120
stackPointer EQU	0x200000A0
		; TM4C1233H6PM
		AREA	midterm2_1, NOINIT, READWRITE, ALIGN=3
StackMem
		SPACE	Stack
		PRESERVE8
		
		AREA	RESET, CODE, READONLY
		THUMB

; The vector table sits here
; We'll define just a few of them and leave the rest at 0 for now.

		DCD		StackMem + Stack	; Top of Stack
		DCD		Reset_Handler		; Reset Handler
		DCD		NmiISR				; NMI Handler
		DCD		FaultISR			; Hard Fault Handler
		DCD		IntDefaultHandler	; MPU Fault Handler
		DCD		IntDefaultHandler	; Bus Fault Handler
		DCD		IntDefaultHandler	; Usage Fault Handler
	
		EXPORT	Reset_Handler
		ENTRY
			
Reset_Handler
			
			; enable the divide-by-zero trap
			; located in the NVIC
			; base: 0xE000E000
			; offset: 0xD14
			; bit: 4
			LDR		r6, =NVICBase
			LDR		r7, =DivbyZ
			LDR		r1, [r6, r7]
			ORR		r1, #0x10		; enable bit 4
			STR		r1, [r6, r7]
			
			; now turn on the usage fault exception
			LDR		r7, =SYSHNDCTRL	; p.163
			LDR		r1, [r6, r7]
			ORR		r1, #0x40000
			STR		r1, [r6 ,r7]
			
			; try out a divide by 2 then a divide by 0!
			LDR		sp, =stackPointer
			MOV		r0, #0
			MOV		r1, #0x11111111
			MOV		r2, #0x22222222
			MOV		r3, #0x33333333
			
			; this divide works just fine
			UDIV	r4, r2, r1
			BL	qOne
			; this divide takes an exception
			UDIV	r5, r3, r0
			;BL 	qOne
Exit 		B		Exit
NmiISR		B		NmiISR
FaultISR	B		FaultISR

IntDefaultHandler
			MOV r12, LR	; move the original LR to r12 (0xFFFFFFF9)
			BL	qOne	; BL generates another LR
			MOV LR, r12 ; recover LR from r12
			BX	LR		; branch back to the main program
done		B	done
; subroutine qone

qOne
			STMIA	sp!, {r1, r6, r7, LR}
			LDR		r7, =Usagefault
			LDRH	r1, [r6, r7]
			TST		r1, #0x200
			
			LDREQ	r6, =ADD1
			LDREQ	r7, =not_divide_by_0
			
			LDRNE	r6, =ADD2
			LDRNE	r7, =divide_by_0

loop		; copy the string into memory
			LDRB	r1, [r7], #1
			STRB	r1, [r6], #1
			CMP		r1, #0			; null terminated?
			BNE		loop
			LDMDB	sp!, {r1, r6, r7, PC}
			
			ALIGN
divide_by_0 		DCB "DIVIDE-BY-ZERO Event", 0
not_divide_by_0 	DCB "No DIVIDE-BY-ZERO Event", 0 
			
			END