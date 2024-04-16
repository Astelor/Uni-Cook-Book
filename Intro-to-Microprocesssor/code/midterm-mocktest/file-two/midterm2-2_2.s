            AREA    midterm2_2_2, CODE, READONLY
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
            STMDA   sp, {r5, r6, r7, LR}	; full descending stack
			
            LDR     r5, =PINSEL0    ; base address of register
			LDR     r6, [r5]        ; get contents
            BIC     r6, r6, #0xF    ; clear out lower nibble
            ORR     r6, r6, #0x5    ; sets p0.0 ti Tx0 and p0.1 to Rx0
            STR     r6, [r5]        ; r/modify/w back to register
            
			; (a)
			LDR     r5, =U0START	; bit 7 =0x80
            MOV     r6, #0x82       ; 7 data bits, odd parity, 1 stop bits
									; + DLAB latch open
			STRB    r6, [r5, #LCR0] ; write control byte to LCR
			
			; (a) - divisor f=48MHz, baud=9600
			LDR 	r5, =0x2DC6C00	; frequency = 48MHz
			LDR		r6, =9600		; baud = 9600
			MOV		r7, #16			; integer
			MUL		r7, r6, r7		; buad x 16
			
			MOV		r6, #0			; divisor tally
divide		SUBS	r5, r7			; 
			ADDGE	r6, #1			; divisor = f/(16 x baud)
			BGE		divide			; r6 - divisor
			
			LDR     r5, =U0START
			STRB    r6, [r5]        ; store divisor byte
			MOV		r6, #0x2		; 0x82-0x80 DLAB = 0
			STR		r6, [r5, #LCR0]	; close DLAB
			
			; (b) - actual frequency
			; frequency = divisor x 16 x (result baud)
			; 2999808 = 56 x 16 x 3348
			
			; (c) 
			; [1:0] 10 - 8 data bit, [2] 1 - 2 stop bit,
			; [5:4] 01 - even parity, [7] 1 - DLAB enable
			
			LDR     r5, =U0START	
            MOV     r6, #0x97       ; 8 data bits, even parity, 2 stop bits
									; + DLAB latch open
			STRB    r6, [r5, #LCR0] ; write control byte to LCR
            
			; divisor = f/(16 x baud). f = divisor x 16 x actual baud
			
			; (c) - divisor for 3600 baud
			LDR 	r5, =2999808	; acutal frequency
			LDR		r6, =3600		; baud = 3600
			MOV		r7, #16			; integer 16
			MUL		r7, r6, r7		; buad x 16
			
			MOV		r6, #0			; divisor tally
divide2		SUBS	r5, r7			; divisor = f/(16 x baud)
			ADDGE	r6, #1			
			BGE		divide2			; r6 - divisor
			
			LDR     r5, =U0START
			STRB	r6, [r5] 		; write divisor
            MOV		r6, #0x17		; DLAB = 0
			STR		r6, [r5, #LCR0]	; close DLAB
			
			LDMDA   sp, {r5, r6, r7, PC}

; Subroutine: Transmit
; input: r10
; output: none
Transmit
			
            STMDB   sp, {r5, r6, r7, LR} ; empty descending stack
            LDR     r5, =U0START
wait        
            LDRB    r6, [r5, #LSR0] ; get status of buffer
            TST     r6, #0x20       ; buffer empty?
            BEQ     wait            ; spin until buffer's empty
            STRB    r10, [r5]
            LDMDB   sp, {r5, r6, r7, PC}

Source
			DCB "This is a source string!", 0
            END
