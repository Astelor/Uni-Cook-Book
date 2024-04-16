# Scrap 2, electro-boogaloo

## Reverse

```assembly
			; (1) reversely
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
```

- The copyloop can be used as a stand-alone code
- The DATA addresses are declared below the "area"

```assembly
			; (2) copy data to 0x40000030 (DATA2)
			LDR		r1, =DATA2
			LDR		r2, =StudentData
copyloop2	                        ; make a copy of CharData
			LDRB	r0, [r2], #1
			CMP 	r0, #0			; null terminated?
			STRBNE	r0, [r1], #1
			BNE		copyloop2
```

- Transmit
- remember to change the Loop label

```assembly
			LDR		r1, =DATA1		; address of the reversed string
Loop		
			LDRB	r10, [r1], #1	; transmit the reversed string
			CMP		r10, #0
			BLNE 	Transmit
			BNE 	Loop
```

## STACK

- full descending stack

```
STMDA	sp, {r5-r7, LR}
LDMDA	sp, {r5-r7, PC}
```

- empty descending stack

```
STMDB	sp, {r5-r7, LR}
LDMDB	sp, {r5-r7, PC}
```

- full ascending stack
```
STMIA	sp, {r5-r7, LR}
LDMIA	sp, {r5-r7, PC}
```

- empty ascending stack
```
STMIB	sp, {r5-r7, LR}
LDMIB	sp, {r5-r7, PC}
```

```
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
```