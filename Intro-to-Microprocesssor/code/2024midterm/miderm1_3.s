            AREA    midterm1_3, CODE, READONLY
PINSEL0     EQU     0xE002C000      ; controls the function of pins
U0START     EQU     0xE000C000      ; start of UART0 register
LCR0        EQU     0xC             ; line control register for UART0
LSR0        EQU     0x14            ; line status register for UART0
RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104
SPSTART		EQU		0x40000020		; SP
DATA1		EQU		0x40000A00
DATA2		EQU		0x40000070
DATA3		EQU		0x400000A0
            ENTRY
start
            LDR     sp, =SPSTART   	; set up stack pointer
            BL      UARTConfig      ; initialize/ configure UART0
			
			; (a) - copy reversely to memory
			LDR		r1, =DATA2		; address of copied data
			LDR		r2, =StudentData; address of source string
copyloop	                        ; make a copy of CharData
			LDRB	r0, [r2], #1
			CMP 	r0, #0			; null terminated?
			STRBNE	r0, [r1], #1
			BNE		copyloop
			
			SUB		r2, r1, #1		; end, pointing to the last character
			LDR		r1, =DATA2		; beginning of the string
swap_loop
			CMP		r1, r2
			BGE		end_swap
			LDRB	r3, [r1], #1
			LDRB	r4, [r2], #-1
			
			STRB	r4, [r1, #-1]
			STRB	r3, [r2, #1]
			B 		swap_loop
end_swap			

;			; (b) - transmit
;			LDR		r1, =DATA2		; string starting address
;			ADD		r1, #8			; 0x40000070 + 0x8
;			MOV		r2, #10			; tally (10)
;Loop2
;			LDRB	r10, [r1], #1	; transmit 10 characters
;			CMP		r2, #0
;			SUBNE	r2, #1
;			BLNE	Transmit
;			BNE		Loop2
;doneB		B		doneB
			; (c) -  receive 20 characters
			LDR		r1, =DATA3		; starting address for storing
			MOV		r2, #20			; tally (20)
Loop4		
			BL		Receive
			STRB	r0, [r1], #1	; output r0
			SUBS	r2, #1
			BNE		Loop4

; Subroutine: UARTConfig
UARTConfig
            STMDB   sp!, {r5, r6, r7, LR}	; full descending stack
			
            LDR     r5, =PINSEL0    ; base address of register
			LDR     r6, [r5]        ; get contents
            BIC     r6, r6, #0xF    ; clear out lower nibble
            ORR     r6, r6, #0x5    ; sets p0.0 ti Tx0 and p0.1 to Rx0
            STR     r6, [r5]        ; r/modify/w back to register
            
			; (a).1 - configuration
			LDR     r5, =U0START	; bit 7 =0x80
            MOV     r6, #0x9C       ; 5 data bits, even parity, 2 stop bits, DLAB enable
			STRB    r6, [r5, #LCR0] ; write control byte to LCR
			
			; (a).2 - caculate the divisor with f=48MHz, baud=12800
			LDR 	r5, =0x2DC6C00	; frequency = 48MHz
			LDR		r6, =12800		; baud = 9600
			MOV		r7, #16			; integer 16
			MUL		r7, r6, r7		; buad x 16
			
			MOV		r6, #0			; divisor tally
divide		SUBS	r5, r7			; f / (16 x baud)
			ADDGE	r6, #1			
			BGE		divide			; r6 - divisor
			
			LDR     r5, =U0START
			STRB    r6, [r5]        ; store divisor byte
			MOV		r6, #0x1C		; 0x94-0x80, DLAB = 0
			STR		r6, [r5, #LCR0]	; close DLAB
			
			; (b) - calculate the LPC2104 frequency
			; equation: frequency = (result baud) x 16 x divisor
			; calculation: 801 x 16 x 0xEA = 801 x 16 x 234 =2998994 = 0x2DC2D2

			; (c).1 - configuration
			LDR     r5, =U0START	
            MOV     r6, #0x8B       ; 8 data bits, odd parity, 1 stop bits, DLAB latch open
			STRB    r6, [r5, #LCR0] ; write control byte to LCR
			
			; (c).2 - calculate the divisor for 12800 baud
			; equation: divisor = f/(16 x baud). 
			; f = divisor x 16 x actual baud
			LDR 	r5, =2998994	; LPC2104 frequency
			LDR		r6, =12800		; desired baud
			MOV		r7, #16			; integer 16
			MUL		r7, r6, r7		; buad x 16
			
			MOV		r6, #0			; divisor tally
divide2		SUBS	r5, r7			; f / (16 x baud)
			ADDGE	r6, #1			
			BGE		divide2			; r6 - divisor
			
			LDR     r5, =U0START
			STRB	r6, [r5] 		; write divisor
            MOV		r6, #0xB		; DLAB = 0
			STR		r6, [r5, #LCR0]	; close DLAB
			
			LDMIA   sp!, {r5, r6, r7, PC}

; Subroutine: Transmit
; input: r10
; output: none
Transmit
			
            STMDB   sp!, {r5, r6, r7, LR}; full descending stack
            LDR     r5, =U0START
wait        
            LDRB    r6, [r5, #LSR0] ; get status of buffer
            TST     r6, #0x20       ; buffer empty?
            BEQ     wait            ; spin until buffer's empty
            STRB    r10, [r5]
            LDMIA   sp!, {r5, r6, r7, PC}

; Sunroutine : Receive
; input: none
; output: r0
Receive     
            STMIA   sp!, {r5, r6, LR}; empty ascending stack
            LDR     r5, =U0START
wait1
            LDRB    r6, [r5, #LSR0] ; get status of buffer
            TST     r6, #1          ; data ready!
            BEQ     wait1           ; wait until data ready
			TST		r6, #0xE		; test error
            LDRB    r0, [r5]		; output register
			BNE		wait1
			LDMDB   sp!, {r5, r6, PC}
			
StudentData
			DCB	"(411440117-Aster Chen)-Midterm Exam in Spring 2024!", 0
			END