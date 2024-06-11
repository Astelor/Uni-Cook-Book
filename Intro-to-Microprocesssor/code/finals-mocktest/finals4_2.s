Stack		EQU		0x00000100
DivbyZ		EQU		0xD14
SYSHNDCTRL	EQU		0xD24
Usagefault	EQU		0xD2A
NVICBase	EQU		0xE000E000
ADD1		EQU		0x20000080
ADD2		EQU		0x20000040
ADD3		EQU		0x2000000C
stackPointer EQU	0x20000100
		; TM4C1233H6PM
		AREA	finals4_2, NOINIT, READWRITE, ALIGN=3
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

			; this divide takes an exception
			UDIV	r5, r3, r0

			; enable the divide-by-zero trap again
			LDR		r6, =NVICBase
			LDR		r7, =DivbyZ
			LDR		r1, [r6, r7]
			ORR		r1, #0x10		; enable bit 4
			STR		r1, [r6, r7]
			
			; hard fault method 2, disable the usage fault exception
			; disable the usage fault exception
			LDR		r7, =SYSHNDCTRL	; p.163
			LDR		r1, [r6, r7]
			BIC		r1, #0x40000
			STR		r1, [r6 ,r7]
			
			; now this exception should be taken as a hard fault
			UDIV	r5, r3, r0
			
Exit 		B		Exit
NmiISR		B		NmiISR

FaultISR
			; disable the divide-by-zero trap again
			LDR		r6, =NVICBase
			LDR		r7, =DivbyZ
			LDR		r1, [r6, r7]
			BIC		r1, #0x10		; disable bit 4
			STR		r1, [r6, r7]
			
			LDR		r6, =ADD3
			LDR		r7, =MsgH

loop		
			LDRB	r1, [r7], #1
			STRB	r1, [r6], #1
			CMP		r1, #0			; null terminated?
			BNE		loop
			
			BX		LR
IntDefaultHandler
			; hard fault method 1
			UDIV	r5, r3, r0
			BX		LR	
done		B		done
			
			ALIGN

MsgH DCB "Hard fault did happen!", 0
			END

