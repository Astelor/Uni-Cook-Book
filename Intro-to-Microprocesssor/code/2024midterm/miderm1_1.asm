			AREA	midterm1_1,	CODE, READONLY
			ENTRY
PINSEL0     EQU     0xE002C000      ; controls the function of pins
U0START     EQU     0xE000C000      ; start of UART0 register
LCR0        EQU     0xC             ; line control register for UART0
LSR0        EQU     0x14            ; line status register for UART0
RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104
SPSTART		EQU		0x40000020		; SP
DATA1		EQU		0x40000A00

start		
			LDR     sp, =SPSTART   	; set up stack pointer
            BL      UARTConfig      ; initialize/ configure UART0
		
done		B	done
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
            MOV     r6, #0x94       ; 5 data bits, even parity, 2 stop bits, DLAB enable
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
			MOV		r6, #0x14		; 0x94-0x80, DLAB = 0
			STR		r6, [r5, #LCR0]	; close DLAB
			
			; (b) - calculate the LPC2104 frequency
			; equation: frequency = (result baud) x 16 x divisor
			; calculation: 801 x 16 x 0xEA = 801 x 16 x 234 =2998994 = 0x2DC2D2

			; (c).1 - configuration
			LDR     r5, =U0START	
            MOV     r6, #0x83       ; 8 data bits, odd parity, 1 stop bits, DLAB latch open
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
            MOV		r6, #0x3		; DLAB = 0
			STR		r6, [r5, #LCR0]	; close DLAB
			
			LDMIA   sp!, {r5, r6, r7, PC}
		
		END