            AREA    midterm2_1, CODE, READONLY
PINSEL0     EQU     0xE002C000      ; controls the function of pins
U0START     EQU     0xE000C000      ; start of UART0 register
LCR0        EQU     0xC             ; line control register for UART0
LSR0        EQU     0x14            ; line status register for UART0
RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104
SPSTART		EQU		0x40000020		; SP
            ENTRY
start
            LDR     sp, =SPSTART   	; set up stack pointer
            BL      UARTConfig      ; initialize/ configure UART0
done        B       done            

; Subroutine: UARTConfig
UARTConfig
            STMDA   sp, {r5, r6, r7, LR}	; empty descending stack
			; (a)
            LDR     r5, =PINSEL0    ; base address of register
			LDR     r6, [r5]        ; get contents
            BIC     r6, r6, #0xF    ; clear out lower nibble
            ORR     r6, r6, #0x5    ; sets p0.0 ti Tx0 and p0.1 to Rx0
            STR     r6, [r5]        ; r/modify/w back to register
            
			; (b)
			LDR     r5, =U0START
            MOV     r6, #0x93       ; 8 data bits, even parity, 2 stop bits+DLAB latch open
            STRB    r6, [r5, #LCR0] ; write control byte to LCR
            
			; (c)
			MOV     r6, #208        ; 9600 baud @32 MHz VPB clock
            STRB    r6, [r5]        ; store control byte
			; divisor = f/(16 x baud). f = divisor x 16 x actual baud

			; (c) - frequency calculation
			LDR		r7, =901		; actual baud
			MUL		r5, r6, r7		; divisor x buad
			MOV		r7, #16			; integer 16
			MUL		r5, r7, r5		; divisor x baud x 16 = frequency
		
			; (d) - divisor for 2400 baud
			MOV		r6, #2400		; baud
			MOV		r7, #16			; MUL doesn't like integers
			MUL		r7, r6, r7		; baud x 16
			
			MOV		r6, #0			; tally for divisor
divide		SUBS	r5, r7			; frequency dividings
			ADDGE	r6, #1
			BGE		divide
			
			LDR     r5, =U0START
			STRB    r6, [r5]        ; store control byte
			
			MOV     r6, #3          ; set DLAB=0, (close latch)
            STRB    r6, [r5, #LCR0] ; Tx and Rx buffers set up
            
			LDMDA   sp, {r5, r6, r7, PC}

            END
