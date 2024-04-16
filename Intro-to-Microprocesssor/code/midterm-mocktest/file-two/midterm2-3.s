            AREA    midterm2_2_2, CODE, READONLY
PINSEL0     EQU     0xE002C000      ; controls the function of pins
U0START     EQU     0xE000C000      ; start of UART0 register
LCR0        EQU     0xC             ; line control register for UART0
LSR0        EQU     0x14            ; line status register for UART0
RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104
SPSTART		EQU		0x40000020		; SP
DATA1		EQU		0x40000060
DATA2		EQU		0x40000040
		ENTRY
start
            LDR     sp, =SPSTART   	; set up stack pointer
            BL      UARTConfig      ; initialize/ configure UART0
			
            ; (1) output r0
            BL		Receive
			
			; (2)-(a) copy reversely
			LDR		r1, =DATA1		; address of copied data
			LDR		r2, =StudentData; address of source string
copyloop	                        ; make a copy of CharData
			LDRB	r0, [r2], #1
			CMP 	r0, #0			; null terminated?
			STRBNE	r0, [r1], #1
			BNE		copyloop
			
			SUB		r2, r1, #1		; end, pointing to the last character
			LDR		r1, =DATA1		; beginning of the string
swap_loop
			CMP		r1, r2
			BGE		end_swap
			LDRB	r3, [r1], #1
			LDRB	r4, [r2], #-1
			
			STRB	r4, [r1, #-1]
			STRB	r3, [r2, #1]
			B 		swap_loop
end_swap
			LDR 	r1, =DATA1		; address of reversed string
			
			; (2)-(b) transmit with tally
			LDR		r1, =DATA1		; string starting address
			ADD		r1, #6
			MOV		r2, #10			; tally (10)
Loop2
			LDRB	r10, [r1], #1	; transmit 10 characters
			CMP		r2, #0
			SUBNE	r2, #1
			BLNE	Transmit
			BNE		Loop2

			; (2)-(c)
			LDR		r1, =DATA2
			MOV		r2, #20			; tally (20)
Loop4		
			BL		Receive
			STRB	r0, [r1], #1    ; output
			SUBS	r2, #1
			BNE		Loop4

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
			MOV		r6, #0x2		; DLAB = 0
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
; output:
Transmit
			
            STMDB   sp, {r5, r6, r7, LR} ; empty descending stack
            LDR     r5, =U0START
wait        
            LDRB    r6, [r5, #LSR0] ; get status of buffer
            TST     r6, #0x20       ; buffer empty?
            BEQ     wait            ; spin until buffer's empty
            STRB    r10, [r5]
            LDMDB   sp, {r5, r6, r7, PC}

; Sunroutine : Receive
; input: none
; output: r0

Receive     
            STMIB   sp, {r5, r6, LR}
            LDR     r5, =U0START
wait1
            LDRB    r6, [r5, #LSR0] ; get status of buffer
            TST     r6, #1          ; data ready!
            BEQ     wait1           ; wait until data ready
            LDRB    r0, [r5]		; output register
            LDMIB   sp, {r5, r6, PC}


Source
			DCB "This is a source string!", 0
StudentData
			DCB	"Midterm in the string 2023 class (411440117)"
            END
