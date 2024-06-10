PINSEL		EQU		0xE002C000
NVICBase	EQU		0xE000E000
SysCtrlBase EQU		0x400FE000
GPIOPFBase	EQU		0x40025000
GPIODIR		EQU		0x400
GPIODEN		EQU		0x51C
RCGCGPIO	EQU		0x608	
TEMP		EQU		0x01C00540
TEMP2		EQU		0x60		; offset for who??
	
Stack		EQU		0x00000100
		AREA	STACK, NOINIT, READWRITE, ALIGN=3
StackMem
		SPACE	Stack
		PRESERVE8
		
		AREA	GPIOLED, CODE, READONLY
		THUMB

; The vector table sits here
; We'll define just a few of them and leave the rest at 0 for now.

		DCD		StackMem + Stack	; Top of Stack
		DCD		Reset_Handler		; Reset Handler
		;DCD		NmiISR				; NMI Handler
		;DCD		FaultISR			; Hard Fault Handler
		;DCD		IntDefaultHandler	; MPU Fault Handler
		;DCD		IntDefaultHandler	; Bus Fault Handler
		;DCD		IntDefaultHandler	; Usage Fault Handler
		
		EXPORT	Reset_Handler
		; TM4C1233H6PM
		ENTRY
		
Reset_Handler
	; Set sysclk to DIV/4, use PLL, XTAL_16 MHz, OSC_MAIN
	; system control base is 0x400FE000, offset 0x60
	; bits[26:23]= 0x3
	; bit[22] = 0x1
	; bit[13] = 0x0
	; bit[11] = 0x0
	; bits[10:6] = 0x15
	; bits[5:4] = 0x0
	; bit[0] = 0x0
	; This all translates to a value of 0x01C00540
		LDR		r0, =SysCtrlBase
		MOVW 	r2, #0x60 		; offset 0x60 for this register
		MOVW 	r1, #0x0540
		MOVT 	r1, #0x01C0
		STR 	r1, [r0, r2] 	; write the register’s contents

		; Enable GPIOF
		; RCGCGPIO (page 339)
		; General-Purpose Input/Output Run Mode Clock Gating Control register
		LDR		r2, =RCGCGPIO 	; offfset for this register
		LDR		r1, [r0, r2] 	; grab the register contents
		ORR		r1, r1, #0x20	; enable GPIO clock
		STR		r1, [r0, r2]
		
		; Set the direction using GPIODIR (page 661)
		; Base is 0x40025000
		LDR		r0, =GPIOPFBase
		LDR		r2, =GPIODIR	; offset for this register
		MOV 	r1, #0xE		; 0b 0000 1110 setting the pins for output (1,2,3)
		LDR		r3, [r0, r2]	; read
		ORR		r3, r1			; modify
								; write
		STR 	r3, [r0, r2] 	; set 1 or 2 or 3 for output
		
		;set the GPIODEN lines
		LDR		r2, =GPIODEN 		; offset for this register
		LDR		r3, [r0, r2]
		ORR		r3, r1
		STR 	r3, [r0, r2] 	; set 1 and 2 and 3 for I/O
		
		SUB 	r7, r7, r7 		; clear out r7
		MOV 	r6, #2 			; start with LED = 0b10
		
mainloop
		; turn on the LED
		; if bits [9:2] affect the writes, then the address
		; is offset by 0x38
		STR 	r6, [r0, #0x38] ; base + 0x38 so [9:2] = 0b00111000
		MOVT 	r7, #0xD8 		; set counter to 0xF40000
spin
		SUBS 	r7, r7, #1
		BNE 	spin
		; change colors
		CMP 	r6, #8
		ITE 	LT
		LSLLT 	r6, r6, #1 		; LED = LED * 2
		MOVGE 	r6, #2 			; reset to 2 otherwise

		B 		mainloop
done	B		done

		END