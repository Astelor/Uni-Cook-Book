;**************************************************************
;*
;* Forward declaration of the default fault handlers.
;*
;**************************************************************
;.global myStart, myStack, ResetISR, Vecs, _c_int00, Reset_Handler
;**************************************************************
;* Interrupt vector table
;**************************************************************
;.sect “.intvecs”

;.sect “.intvecs”

		; TM4C1233H6PM
		AREA	STACK, NOINIT, READWRITE, ALIGN=3
StackMem
		SPACE	0x400
		PRESERVE8
		
		AREA	EXAMPLE15_4, CODE, READONLY
		THUMB

Vecs
        DCD  StackMem + 0x400       ; The initial stack pointer
        DCD  Reset_Handler ; The reset handler
        DCD  NmiSR ; The NMI handler
        DCD  FaultISR ; The hard fault handler
        DCD  IntDefaultHandler ; The MPU fault handler
        DCD  IntDefaultHandler ; The bus fault handler
        DCD  IntDefaultHandler ; The usage fault handler
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  IntDefaultHandler ; SVCall handler
        DCD  IntDefaultHandler ; Debug monitor handler
        DCD  0 ; Reserved
        DCD  IntDefaultHandler ; The PendSV handler
        DCD  IntDefaultHandler ; The SysTick handler
        DCD  IntDefaultHandler ; GPIO Port A
        DCD  IntDefaultHandler ; GPIO Port B
        DCD  IntDefaultHandler ; GPIO Port C
        DCD  IntDefaultHandler ; GPIO Port D
        DCD  IntDefaultHandler ; GPIO Port E
        DCD  IntDefaultHandler ; UART0 Rx and Tx
        DCD  IntDefaultHandler ; UART1 Rx and Tx
        DCD  IntDefaultHandler ; SSI0 Rx and Tx
        DCD  IntDefaultHandler ; I2C0 Master and Slave
        DCD  IntDefaultHandler ; PWM Fault
        DCD  IntDefaultHandler ; PWM Generator 0
        DCD  IntDefaultHandler ; PWM Generator 1
        DCD  IntDefaultHandler ; PWM Generator 2
        DCD  IntDefaultHandler ; Quadrature Encoder 0
        DCD  IntDefaultHandler ; ADC Sequence 0
        DCD  IntDefaultHandler ; ADC Sequence 1
        DCD  IntDefaultHandler ; ADC Sequence 2
        DCD  IntDefaultHandler ; ADC Sequence 3
        DCD  IntDefaultHandler ; Watchdog timer

        DCD  IntDefaultHandler ; Timer 0 subtimer A
        DCD  IntDefaultHandler ; Timer 0 subtimer B
        DCD  IntDefaultHandler ; Timer 1 subtimer A
        DCD  IntDefaultHandler ; Timer 1 subtimer B
        DCD  IntDefaultHandler ; Timer 2 subtimer A
        DCD  IntDefaultHandler ; Timer 2 subtimer B
        DCD  IntDefaultHandler ; Analog Comparator 0
        DCD  IntDefaultHandler ; Analog Comparator 1
        DCD  IntDefaultHandler ; Analog Comparator 2
        DCD  IntDefaultHandler ; System Control (PLL OSC BO)
        DCD  IntDefaultHandler ; FLASH Control
        DCD  IntDefaultHandler ; GPIO Port F
        DCD  IntDefaultHandler ; GPIO Port G
        DCD  IntDefaultHandler ; GPIO Port H
        DCD  IntDefaultHandler ; UART2 Rx and Tx
        DCD  IntDefaultHandler ; SSI1 Rx and Tx
        DCD  IntDefaultHandler ; Timer 3 subtimer A
        DCD  IntDefaultHandler ; Timer 3 subtimer B
        DCD  IntDefaultHandler ; I2C1 Master and Slave
        DCD  IntDefaultHandler ; Quadrature Encoder 1
        DCD  IntDefaultHandler ; CAN0
        DCD  IntDefaultHandler ; CAN1
        DCD  IntDefaultHandler ; CAN2
        DCD  IntDefaultHandler ; Ethernet
        DCD  IntDefaultHandler ; Hibernate
        DCD  IntDefaultHandler ; USB0
        DCD  IntDefaultHandler ; PWM Generator 3
        DCD  IntDefaultHandler ; uDMA Software Transfer
        DCD  IntDefaultHandler ; uDMA Error
        DCD  IntDefaultHandler ; ADC1 Sequence 0
        DCD  IntDefaultHandler ; ADC1 Sequence 1
        DCD  IntDefaultHandler ; ADC1 Sequence 2
        DCD  IntDefaultHandler ; ADC1 Sequence 3
        DCD  IntDefaultHandler ; I2S0
        DCD  IntDefaultHandler ; External Bus Interface 0
        DCD  IntDefaultHandler ; GPIO Port J
        DCD  IntDefaultHandler ; GPIO Port K
        DCD  IntDefaultHandler ; GPIO Port L
        DCD  IntDefaultHandler ; SSI2 Rx and Tx
        DCD  IntDefaultHandler ; SSI3 Rx and Tx
        DCD  IntDefaultHandler ; UART3 Rx and Tx
        DCD  IntDefaultHandler ; UART4 Rx and Tx
        DCD  IntDefaultHandler ; UART5 Rx and Tx
        DCD  IntDefaultHandler ; UART6 Rx and Tx
        DCD  IntDefaultHandler ; UART7 Rx and Tx
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  IntDefaultHandler ; I2C2 Master and Slave
        DCD  IntDefaultHandler ; I2C3 Master and Slave

        DCD  IntDefaultHandler ; Timer 4 subtimer A
        DCD  IntDefaultHandler ; Timer 4 subtimer B
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  0 ; Reserved
        DCD  IntDefaultHandler ; Timer 5 subtimer A
        DCD  IntDefaultHandler ; Timer 5 subtimer B
        DCD  IntDefaultHandler ; Wide Timer 0 subtimer A
        DCD  IntDefaultHandler ; Wide Timer 0 subtimer B
        DCD  IntDefaultHandler ; Wide Timer 1 subtimer A
        DCD  IntDefaultHandler ; Wide Timer 1 subtimer B
        DCD  IntDefaultHandler ; Wide Timer 2 subtimer A
        DCD  IntDefaultHandler ; Wide Timer 2 subtimer B
        DCD  IntDefaultHandler ; Wide Timer 3 subtimer A
        DCD  IntDefaultHandler ; Wide Timer 3 subtimer B
        DCD  IntDefaultHandler ; Wide Timer 4 subtimer A
        DCD  IntDefaultHandler ; Wide Timer 4 subtimer B
        DCD  IntDefaultHandler ; Wide Timer 5 subtimer A
        DCD  IntDefaultHandler ; Wide Timer 5 subtimer B
        DCD  IntDefaultHandler ; FPU
        DCD  IntDefaultHandler ; PECI 0
        DCD  IntDefaultHandler ; LPC 0
        DCD  IntDefaultHandler ; I2C4 Master and Slave
        DCD  IntDefaultHandler ; I2C5 Master and Slave
        DCD  IntDefaultHandler ; GPIO Port M
        DCD  IntDefaultHandler ; GPIO Port N
        DCD  IntDefaultHandler ; Quadrature Encoder 2
        DCD  IntDefaultHandler ; Fan 0
        DCD  0 ; Reserved
        DCD  IntDefaultHandler ; GPIO Port P (Summary or P0)
        DCD  IntDefaultHandler ; GPIO Port P1
        DCD  IntDefaultHandler ; GPIO Port P2
        DCD  IntDefaultHandler ; GPIO Port P3
        DCD  IntDefaultHandler ; GPIO Port P4

        DCD  IntDefaultHandler ; GPIO Port P5
        DCD  IntDefaultHandler ; GPIO Port P6
        DCD  IntDefaultHandler ; GPIO Port P7
        DCD  IntDefaultHandler ; GPIO Port Q (Summary or Q0)
        DCD  IntDefaultHandler ; GPIO Port Q1
        DCD  IntDefaultHandler ; GPIO Port Q2
        DCD  IntDefaultHandler ; GPIO Port Q3
        DCD  IntDefaultHandler ; GPIO Port Q4
        DCD  IntDefaultHandler ; GPIO Port Q5
        DCD  IntDefaultHandler ; GPIO Port Q6
        DCD  IntDefaultHandler ; GPIO Port Q7
        DCD  IntDefaultHandler ; GPIO Port R
        DCD  IntDefaultHandler ; GPIO Port S
        DCD  IntDefaultHandler ; PWM 1 Generator 0
        DCD  IntDefaultHandler ; PWM 1 Generator 1
        DCD  IntDefaultHandler ; PWM 1 Generator 2
        DCD  IntDefaultHandler ; PWM 1 Generator 3
        DCD  IntDefaultHandler ; PWM 1 Fault
;.sect “.myCode”
        EXPORT Reset_Handler
        ENTRY
myStart
        ; Set sysclk to DIV/4, use PLL, XTAL_16 MHz, OSCReset_Handler
        ; system control base is 0x400FE000, offset 0x60
        ; bits [26:23] = 0x3
        ; bit [22] = 0x1
        ; bit [13] = 0x0
        ; bit [11] = 0x0
        ; bits [10:6] = 0x15
        ; bits [5:4] = 0x0
        ; bit [0] = 0x0
        ; All of this translates to 0x01C00540
        MOVW    r0, #0xE000
        MOVT    r0, #0x400F
        MOVW    r2, #0x60       ; offset 0x060 for this register
        MOVW    r1, #0x0540
        MOVT    r1, #0x01C0
        STR     r1, [r0, r2]    ; write the register’s contents
        
        ; MOVW r6, #0xE000
        ; MOVT r6, #0xE000
        MOVW    r7, #0x604      ; enable timer0 - RCGCTIMER
        LDR     r1, [r0, r7]    ; p. 321, base 0x400FE000
        ORR     r1, #0x1        ; offset - 0x604
        STR     r1, [r0, r7]    ; bit 0
        NOP
        NOP
        NOP
        NOP
        NOP                     ; give myself 5 clocks per spec


        MOVW    r8, #0x0000     ; configure timer0 to be
        MOVT    r8, #0x4003     ; one-shot, p.698 GPTMTnMR
        MOVW    r7, #0x4        ; base 0x40030000
        LDR     r1, [r8, r7]    ; offset 0x4
        ORR     r1, #0x21       ; bit 5 = 1, 1:0 = 0x1
        STR     r1, [r8, r7]
        LDR     r1, [r8]        ; set as 16-bit timer only
        ORR     r1, #0x4        ; base 0x40030000
        STR     r1, [r8]        ; offset 0, bit[2:0] = 0x4
        MOVW    r7, #0x30       ; set the match value at 0
        MOV     r1, #0          ; since we’re counting down
        STR     r1, [r8, r7]    ; offset - 0x30
        MOVW    r7, #0x18       ; set bits in the GPTM
        LDR     r1, [r8, r7]    ; Interrupt Mask Register
        ORR     r1, #0x10       ; p. 714 - base: 0x40030000
        STR     r1, [r8, r7]    ; offset - 0x18, bit 5
        MOVW    r6, #0xE000     ; enable interrupt on timer0
        MOVT    r6, #0xE000     ; p. 132, base 0xE000E000
        MOVW    r7, #0x100      ; offset - 0x100, bit 19
        MOV     r1, #(1 << 19)  ; enable bit 19 for timer0
        STR     r1, [r6, r7]
        
        ;NOP
        ;NOP
        ;NOP
        ;NOP
        ;NOP

        MOVW    r6, #0x0000     ; start the timer
        MOVT    r6, #0x4003
        MOVW    r7, #0xC
        LDR     r1, [r6, r7]
        ORR     r1, #0x1
        STR     r1, [r6, r7]    ; go!!
Spin
        B       Spin            ; sit waiting for the interrupt to occur


;**************************************************************
;* Interrupt functions
;**************************************************************
;.text
;ResetISR:
;_c_int00:
Reset_Handler
        B       myStart ; branch to the 'function'

NmiSR B NmiSR
FaultISR B FaultISR 
IntDefaultHandler
        MOVW r10, #0xBEEF
        MOVT r10, #0xDEAD
        NOP
Spot
        B       Spot
;**************************************************************
;myStack .usect “.stack”, 0x400

		END