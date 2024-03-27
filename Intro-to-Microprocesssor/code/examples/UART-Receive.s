            AREA    UARTDEMO_Receive, CODE, READONLY
PINSEL0     EQU     0xE002C000      ; controls the function of pins
U0START     EQU     0xE000C000      ; start of UART0 register
LCR0        EQU     0xC             ; line control register for UART0
LSR0        EQU     0x14            ; line status register for UART0
RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104
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
            
            MOV     r9, #20
Loop1       
            BL      Receive
            STRB    r0, [r1], #1
            SUBS    r9, r9, #1
            BNE     Loop1
done        B       done            

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
            ORR     r6, r6, #0x5    ; sets p0.0 ti Tx0 and p0.1 to Rx0
            STR     r6, [r5]        ; r/modify/w back to register
            LDR     r5, =U0START
            MOV     r6, #0x83        ; set 8 bits, no parity, 1 stop bit
            STRB    r6, [r5, #LCR0] ; write control byte to LCR
            MOV     r6, #0x61        ; 9600 baud @15 MHz VPB clock
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

; Subroutine Receive

Receive     
            STMIA   sp!, {r5, r6, LR}
            LDR     r5, =U0START
wait1
            LDRB    r6, [r5, #LSR0] ; get status of buffer
            TST     r6, #1          ; data ready!
            BEQ     wait1           ; wait until data ready
            LDRB    r0, [r5]
            LDMDB   sp!, {r5, r6, PC}

CharData
            DCB     "Watson. Come quickly!", 0
            END
