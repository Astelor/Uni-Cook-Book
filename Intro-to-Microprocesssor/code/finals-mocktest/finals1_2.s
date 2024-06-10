 ; timer ehhhhhhhhhh
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
		;DCD		NmiISR				; NMI Handler
		;DCD		FaultISR			; Hard Fault Handler
		DCD		IntDefaultHandler	; MPU Fault Handler
		DCD		IntDefaultHandler	; Bus Fault Handler
		DCD		IntDefaultHandler	; Usage Fault Handler
		
		EXPORT	Reset_Handler
		ENTRY
			
Reset_Handler
		; System Control Register, base address 0x400FE000
		; | Run-Mode Clock Configuration
		; | offset 0x60
		MOVW 	r0, #0xE000			; System control register base 0x400FE000
		MOVT 	r0, #0x400F			
		MOVW 	r2, #0x60 			; offset 0x060 for RCC (Run-Mode Clcok Configuration)
		MOVW 	r1, #0x0540
		MOVT 	r1, #0x01C0
		STR 	r1, [r0, r2] 		; write the register’s content
		
		; | 16/32- Bit General-Purpose Timer Run Mode Clock Gating Control
		; | offset 0x604
		MOVW 	r7, #0x604 			; enable timer0 - RCGCTIMER
		LDR 	r1, [r0, r7] 		; System control register base 0x400FE000
		ORR 	r1, #0x1		 	; offset - 0x604
		STR 	r1, [r0, r7] 		; bit 0
		
		NOP
		NOP
		NOP
		NOP
		NOP 						; give myself 5 clocks per spec
		
		; General-Purpose Timer, base address 0x40030000
		; | GPTM timer A Mode
		; | offset 0x4
		MOVW 	r8, #0x0000 		; configure timer0 to be
		MOVT 	r8, #0x4003 		; one-shot, p.698 GPTMTnMR
		MOVW 	r7, #0x4 			; base 0x40030000
		LDR 	r1, [r8, r7] 		; offset 0x4
		ORR 	r1, #0x21 			; bit 5 = 1, 1:0 = 0x1
		STR 	r1, [r8, r7]
		
		; | GPTM Configuration (GPTMCFG)
		; | offset 0x0
		LDR 	r1, [r8] 			; set as 16-bit timer only
		ORR 	r1, #0x4 			; base 0x40030000
		STR 	r1, [r8] 			; offset 0, bit[2:0] = 0x4
		
		; | GPTM Timer A Match (GPTMTAMATCHR)
		; | offset 0x30
		MOVW 	r7, #0x30 			; set the match value at 0
		MOV 	r1, #0 				; since we’re counting down
		STR 	r1, [r8, r7] 		; offset - 0x30
		
		; | GPTM Interrupt Mask (GPTMTAMATCHR)
		; | offset 0x18
		MOVW 	r7, #0x18 			; set bits in the GPTM
		LDR 	r1, [r8, r7] 		; Interrupt Mask Register
		ORR 	r1, #0x10 			; p. 714 - base: 0x40030000
		STR 	r1, [r8, r7] 		; offset - 0x18, bit 4
		
		; NVIC, base address 0xE000E000
		; | Interrupt 0-31 set enable
		; | offset 0x100
		MOVW 	r6, #0xE000 		; enable interrupt on 16/32-bit timer0A
		MOVT 	r6, #0xE000 		; p. 132, base 0xE000E000
		MOVW 	r7, #0x100 			; offset - 0x100, bit 19
		MOV 	r1, #(1 << 19) 		; enable bit 19 for timer0
		STR 	r1, [r6, r7]
		
		; Genreral-Purpose Timer
		MOVW 	r6, #0x0000 		; start the timer
		MOVT 	r6, #0x4003
		MOVW 	r7, #0xC
		LDR 	r1, [r6, r7]
		ORR 	r1, #0x1
		STR 	r1, [r6, r7] 		; go!!

IntDefaultHandler
		MOVW 	r10, #0xBEEF
		MOVT 	r10, #0xDEAD
Spot
		B 		Spot
		
		END