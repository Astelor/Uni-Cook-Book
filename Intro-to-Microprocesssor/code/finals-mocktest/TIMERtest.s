    AREA RESET, CODE, READONLY
    EXPORT __main
    EXPORT Timer0A_Handler

__main
    LDR R0, =0x400FE608          ; Enable clock to Port F (SYSCTL_RCGCGPIO)
    LDR R1, =0x20
    STR R1, [R0]

    LDR R0, =0x400FE604          ; Enable clock to Timer0 (SYSCTL_RCGCTIMER)
    LDR R1, =0x01
    STR R1, [R0]

    LDR R0, =0x40025000          ; Configure PF1 as output (GPIO_PORTF_DIR)
    LDR R1, =0x02
    STR R1, [R0, #0x400]         ; GPIO_PORTF_DEN to enable PF1

    LDR R0, =0x40030000          ; Disable Timer0A during setup (GPTMCTL)
    MOV R1, #0
    STR R1, [R0, #0x0C]

    MOV R1, #0                   ; Configure Timer0A 32-bit mode (GPTMCFG)
    STR R1, [R0, #0x000]

    MOV R1, #1                   ; Configure Timer0A in one-shot mode (GPTMTAMR)
    STR R1, [R0, #0x004]

    LDR R1, =48000000 - 1        ; Load Timer0A with 3 seconds interval (GPTMTAILR)
    STR R1, [R0, #0x028]

    MOV R1, #1                   ; Enable Timer0A timeout interrupt (GPTMIMR)
    STR R1, [R0, #0x018]

    LDR R0, =0xE000E100          ; Enable IRQ 19 (NVIC_EN0 for Timer0A)
    LDR R1, =1 << 19
    STR R1, [R0]

    LDR R0, =0x40030000          ; Enable Timer0A (GPTMCTL)
    MOV R1, #1
    STR R1, [R0, #0x0C]

loop
    B loop                       ; Infinite loop

    END

Timer0A_Handler
    LDR R0, =0x40030000          ; Clear Timer0A timeout interrupt (GPTMICR)
    LDR R1, =0x1
    STR R1, [R0, #0x024]

    LDR R0, =0x40025038          ; Toggle PF1 (GPIO_PORTF_DATA)
    LDR R1, [R0]
    EOR R1, R1, #0x02
    STR R1, [R0]

    BX LR                        ; Return from interrupt
