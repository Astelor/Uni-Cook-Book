 ; Am I thinking too hard on a hypothetical problem?
 ; not solved at ALL
Stack		EQU		0x00000100
		; TM4C1233H6PM
		AREA	STACK, NOINIT, READWRITE, ALIGN=3
StackMem
		SPACE	Stack
		PRESERVE8
		
		AREA	EXAMPLE15_4, CODE, READONLY
		THUMB
; 0x40000000, 0x41000000
; The vector table sits here
; We'll define just a few of them and leave the rest at 0 for now.
		
		DCD		StackMem + Stack	; Top of Stack
		DCD		Reset_Handler		; Reset Handler
		DCD		NmiISR				; NMI Handler
		DCD		FaultISR			; Hard Fault Handler
		DCD		IntDefaultHandler	; MPU Fault Handler
		DCD		IntDefaultHandler	; Bus Fault Handler
		DCD		IntDefaultHandler	; Usage Fault Handler
		DCD		IntDefaultHandler	; Bus fault
		EXPORT	Reset_Handler
		ENTRY
			
Reset_Handler
        ; Set sysclk to DIV/4, use PLL, XTAL_16 MHz, OSCReset_Handler
        ; system control base is 0x400FE000, offset 0x60
        ; bits [26:23] = 0x3
        ; bit [22] = 0x1
        ; bit [13] = 0x0
        ; bit [11] = 0x0
        ; bits [10:6] = 0x15
        ; bits [5:4] = 0x0
        ; bit [0] = 0x0
        ; All of this translates to 0x06C00540
		
		; table 5-4
		
		; System Control Register, base address 0x400FE000
		; | Run-Mode Clock Configuration
		; | offset 0x60
		;MOVW 	r0, #0xE000			; System control register base 0x400FE000
		;MOVT 	r0, #0x400F			
		;MOVW 	r2, #0x60 			; offset 0x060 for RCC (Run-Mode Clcok Configuration)
		;LDR		r1, =0x06C00540
		;STR 	r1, [r0, r2] 		; write the register’s content
		
		; | 16/32- Bit General-Purpose Timer Run Mode Clock Gating Control
		; | offset 0x604
		;MOVW 	r7, #0x604 			; enable timer0 - RCGCTIMER
		;LDR 	r1, [r0, r7] 		; System control register base 0x400FE000
		;ORR 	r1, #0x0		 	; offset - 0x604
		;STR 	r1, [r0, r7] 		; bit 0
		
		NOP
		NOP
		NOP
		NOP
		NOP 						; give myself 5 clocks per spec
		
		
stop	B		stop

NmiISR 	 B		NmiISR
FaultISR B		FaultISR

IntDefaultHandler
		MOVW 	r10, #0xBEEF
		MOVT 	r10, #0xDEAD
Spot
		B 		Spot
		ALIGN
		END