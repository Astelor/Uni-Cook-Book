SysCtrlBase EQU		0x400FE000
GPIOPFBase	EQU		0x40025000
GPIODIR		EQU		0x400
GPIODEN		EQU		0x51C
RCGCGPIO	EQU		0x608
Stack		EQU		0x00000100
SRAMSTART	EQU		0x20000000
		AREA	STACK, NOINIT, READWRITE, ALIGN=3
StackMem
		SPACE	Stack
		PRESERVE8
		
		AREA	GPIOLED, CODE, READONLY
		THUMB
; 0x40000000, 0x41000000
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
		LDR		r3, [r0, r2]	; read
		MOV 	r1, #0x111		; 0b 1 0001 0001 setting the pins for output
		ORR		r3, r1			; modify
		STR 	r3, [r0, r2] 	; (write) set the bits in r1 for the output
		
		;set the GPIODEN lines
		LDR		r2, =GPIODEN 	; offset for this register
		LDR		r3, [r0, r2]	; read
		ORR		r3, r1			; modify
		STR 	r3, [r0, r2] 	; the the bits in r1 for I/O
		
		
		; RED: PF8 0x100, GREEN: PF4 0x010, BLUE: PF0 0x001
		; R -> G -> B -> B -> G -> R
		; address 0x40000000, offset 0x38
		; cycle = 3 second ish
		
		LDR		r0, =0x40000000
		SUB 	r7, r7, r7 		; clear out r7
		LDR 	r4, =color_pattern 	; load the color pattern
		MOV		r5, #0				; pattern tally reset
mainloop
		; turn on the LED
		; if bits [9:2] affect the writes, then the address
		; is offset by 0x38
		
		STR 	r6, [r0, #0x38] ; base + 0x38 so [9:2] = 0b00111000
		MOVT 	r7, #0xB9 		; set counter to 0xB90000 (3 seconds ish)
spin
		SUBS 	r7, r7, #1
		BNE 	spin
back
		CMP		r5, #6
		ADDNE	r5, #1			; increment tally
		LDRNE	r6, [r4], #4	; load the corresponding pattern
		MOVEQ	r5, #0			; 
		LDREQ	r4, =color_pattern
		BEQ		back
		B 		mainloop
done	B		done
		ALIGN
color_pattern
		DCD	0x100, 0x010, 0x001, 0x001, 0x010, 0x100
		END

		