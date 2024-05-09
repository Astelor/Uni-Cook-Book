Stack		EQU		0x00000100
DivbyZ		EQU		0xD14
SYSHNDCTRL	EQU		0xD24
Usagefault	EQU		0xD2A
NVICBase	EQU		0xE000E000
		; TM4C1233H6PM
		AREA	STACK, NOINIT, READWRITE, ALIGN=3
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
			
			; switch to user (unprivileged) thread mode
			;MRS		r8, CONTROL
			;ORR		r8, r8, #1
			;MSR		CONTROL, r8
			;BX 		LR
			
			
			; this divide works just fine
			;UDIV	r4, r2, r1
			; this divide takes an exception
			UDIV	r5, r3, r0
			
Exit 		B		Exit

NmiISR		B		NmiISR
FaultISR	B		FaultISR
IntDefaultHandler
			MRS		r8, CONTROL
			ORR		r8, r8, #1
			MSR		CONTROL, r8
			BX 		LR
		
done		B 		done
			ALIGN
			
			END