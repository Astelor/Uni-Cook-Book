        AREA    Q2_22, CODE
        ENTRY
; (1) func1 inserts the value 0xFF into r0 so that the final value of r0 becomes 0xDEFFBEEF 
; (2) func2 loads bits 12~19 from r0 into r1 so that the final value of r1 becomes 0xFACEABFB, 
; (3) func3 puts the number of different bits between r0 and r1 into r3 using TST.
; (4) func4 puts the number of different bits between r0 and r1 into r4 without using TST.
; (5) func5 puts the different bit numbers between r0 and r1 one by one in the words started from memory address 0x40000050.
; r0 -> = 0xDEADBEEF
; r1 -> = 0xFACEABCD
; r2 -> temp 
; r3 -> number of different bits between r0 & r1 (func3)
; r6 -> number of different bits between r0 & r1 (func4)
; r5 -> temp
; r6 -> temp
;---------------------------
        LDR r0, =0xDEADBEEF
        LDR r1, =0xFACEABCD
        BL  func1
        BL  func2
        BL  func3
        BL  func4
        BL  func5
stop    B   stop

func1
        ROR r2, r0, #16
        BIC r2, r2, #0xFF
        ADD r2, r2, #0xFF
        ROR r0, r2, #16     ; now r0=0xDEFFBEEF
        BX  lr

func2
        ROR r2, r0, #12		; get bit 12
        AND r2, r2, #0xFF   ; isolate the bits
        BIC r1, r1, #0xFF
        ADD r1, r1, r2      ; now r1=0xFACEABFB
        BX  lr
func3
        EOR r2, r0, r1
        MOV r3, #0
        MVN r6, #0
loop1   TST r2, r6
        AND r5, r2, #1
        ADD r3, r3, r5
        LSR r2, r2, #1
        BNE loop1 
        BX  lr
func4
        EOR r2, r0, r1
        MOV r4, #0
loop2   CMP r2, #0
        AND r5, r2, #1
        ADD r4, r4, r5
        LSR r2, r2, #1
        BNE loop2
        BX  lr
func5   ; I dont understand what it wants me to do
        LDR sp, =0x40000020 

        BX  lr
        END