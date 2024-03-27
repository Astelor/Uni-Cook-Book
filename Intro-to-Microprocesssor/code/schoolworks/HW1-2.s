            AREA    HW1-2-UARTDEMO, CODE, READONLY
PINSEL0     EQU     0xE002C000      ; controls the function of pins
U0START     EQU     0xE000C000      ; start of UART0 register
LCR0        EQU     0xC             ; line control register for UART0
LSR0        EQU     0x14            ; line status register for UART0
RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104

DATA2		EQU		0x40000100		; address for the reversed data

            ENTRY
start
            LDR     sp, =RAMSTART   ; set up stack pointer
            BL      UARTConfig      ; initialize/ configure UART0
            LDR     r1, =CharData   ; starting address of characters
Loop
            LDRB    r0, [r1], #1    ; load character, increment address
            CMP     r0, #0          ; null terminated?
            BLNE    Transmit        ; send character to UART
            BNE     Loop            ; continue if not a '0'

; new!----------------------
			LDR		r1, =DATA2
			LDR 	r2, =CharData
copyloop	                        ; make a copy of CharData
			LDRB	r0, [r2], #1
			CMP 	r0, #0
			STRBNE	r0, [r1], #1
			BNE		copyloop

			SUB		r2, r1, #1		; end. pointing to the last character
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
			LDR		r1, =DATA2
; --------------------------
Loop2
            LDRB    r0, [r1], #1    ; load character, increment address
            CMP     r0, #0          ; null terminated?
            BLNE    Transmit        ; send character to UART
            BNE     Loop2           ; continue if not a '0'
; ---------------------------
done        B       done            ; otherwise we are done			

; Subroutine UARTConfig
; This subroutine configures the I/O pins first.
; It then sets up the UART control register.
; The parameters
; are set to 8 bits, no parity and 1 stop bit.
; Registers used:
; r5 - scratch register
; r6 - scratch register
; inputs: none
; outputs: none 

UARTConfig
            STMIA   sp!, {r5, r6, LR}
            LDR     r5, =PINSEL0    ; base address of register
            LDR     r6, [r5]        ; get contents
            BIC     r6, r6, #0xF    ; clear out lower nibble
            ORR     r6, r6, #0x5    ; sets p0.0 to Tx0 and p0.1 to Rx0
            STR     r6, [r5]        ; r/modify/w back to register
            LDR     r5, =U0START
            MOV     r6, #0x83       ; set 8 bits, no parity, 1 stop bit
            STRB    r6, [r5, #LCR0] ; write control byte to LCR
            MOV     r6, #0x61       ; 9600 baud @15 MHz VPB clock
            STRB    r6, [r5]        ; store control byte
            MOV     r6, #3          ; set DLAB=0
            STRB    r6, [r5, #LCR0] ; Tx and Rx buffers set up
            LDMDB   sp!, {r5, r6, PC}

; Subroutine Transmit
; This routine puts one byte into the UART
; for transmitting.
; Register used:
; r5 - scratch
; r6 - scratch
; inputs: r0 - byte to transmit
; outputs: none

Transmit
            STMIA   sp!, {r5, r6, LR}
            LDR     r5, =U0START
wait        
            LDRB    r6, [r5, #LSR0] ; get status of buffer
            TST     r6, #0x20       ; buffer empty?
            BEQ     wait            ; spin until buffer's empty
            STRB    r0, [r5]
            LDMDB   sp!, {r5, r6, PC}

CharData
            DCB     "TKU-ECE 411440117 Aster ", 0
            END
