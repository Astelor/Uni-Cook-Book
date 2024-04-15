            AREA    midterm3, CODE, READONLY
PINSEL0     EQU     0xE002C000      ; controls the function of pins
U0START     EQU     0xE000C000      ; start of UART0 register
LCR0        EQU     0xC             ; line control register for UART0
LSR0        EQU     0x14            ; line status register for UART0
RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104
SPSTART		EQU		0x40000020		; SP
DATA1		EQU		0x40000A00		; reversed string
DATA2		EQU		0x40000030
DATA3		EQU		0x40000090
            ENTRY
start
            LDR     sp, =SPSTART   	; set up stack pointer
            BL      UARTConfig      ; initialize/ configure UART0
			MOV		r10, #0x41		; 'A'
			
			; (1) reversely
			LDR		r1, =DATA1
			LDR		r2, =StudentData	
copyloop	                        ; make a copy of CharData
			LDRB	r0, [r2], #1
			CMP 	r0, #0
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
; --------------------------
			LDR		r1, =DATA1		; address of the reversed string
Loop		
			LDRB	r10, [r1], #1	; transmit the reversed string
			CMP		r10, #0
			BLNE 	Transmit
			BNE 	Loop
; --------------------------
			LDR		r1, =StudentData
			MOV		r2, #11			; tally (11)
Loop2
			LDRB	r10, [r1], #1	; transmit 11 characters (411440117)
			CMP		r2, #0
			SUBNE	r2, #1
			BLNE	Transmit
			BNE		Loop2
; --------------------------

			; (2) copy data to 0x40000030
			LDR		r1, =DATA2
			LDR		r2, =StudentData
copyloop2	                        ; make a copy of CharData
			LDRB	r0, [r2], #1
			CMP 	r0, #0			; null terminated?
			STRBNE	r0, [r1], #1
			BNE		copyloop2
			
			; (3) transmit 18 characters at address 0x4000003C
			LDR		r1, =DATA2
			ADD		r1, #0xC		; starting from 0x3C
			MOV		r2, #18			; tally (18)
Loop3		
			LDRB	r10, [r1], #1	; transmit the strings
			CMP		r2, #0
			SUBNE	r2, #1
			BLNE 	Transmit
			BNE 	Loop3
; --------------------------

			; (4) receive 15 characters
			LDR		r1, =DATA3
			MOV		r2, #15			; tally (15)
Loop4		
			BL		Receive
			STRB	r4, [r1], #1
			SUBS	r2, #1
			BNE		Loop4


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

; Subroutine: Transmit
; input: r10
; output: none

Transmit
			
            STMIB   sp, {r5, r6, LR} ; full ascending stack
            LDR     r5, =U0START
wait        
            LDRB    r6, [r5, #LSR0] ; get status of buffer
            TST     r6, #0x20       ; buffer empty?
            BEQ     wait            ; spin until buffer's empty
            STRB    r10, [r5]
            LDMIB   sp, {r5, r6, PC}

; Subroutine: Receive
; input: none
; output: r4

Receive     
            STMIB   sp, {r5, r6, LR}
            LDR     r5, =U0START
wait1
            LDRB    r6, [r5, #LSR0] ; get status of buffer
            TST     r6, #1          ; data ready!
            BEQ     wait1           ; wait until data ready
            LDRB    r4, [r5]
            LDMIB   sp, {r5, r6, PC}

StudentData
			DCB	"(411440117)-Midterm in the spring 2023 class!", 0	; null terminated string
            END
