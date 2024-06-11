		AREA	GPIOLED, CODE, READONLY
		ENTRY
		; RED: PF8 0x100, GREEN: PF4 0x010, BLUE: PF0 0x001
		; R -> G -> B -> B -> G -> R
		; address 0x40000000, offset 0x38
		; cycle = 3 second ish
		
		LDR		r0, =0x40000000
		SUB 	r7, r7, r7 		; clear out r7
		LDR 	r4, =color_pattern 	; load the color pattern
		MOV		r5, #0				; pattern tally reset
mainloop
		; turn on the LED
		; if bits [9:2] affect the writes, then the address
		; is offset by 0x38
		
		STR 	r6, [r0, #0x38] ; base + 0x38 so [9:2] = 0b00111000
		LDR 	r7, =0xB90000 		; set counter to 0xB90000 (3 seconds ish)
spin
		SUBS 	r7, r7, #1
		BNE 	spin
back
		CMP		r5, #6
		ADDNE	r5, #1			; increment tally
		LDRNE	r6, [r4], #4	; load the corresponding pattern
		MOVEQ	r5, #0			; 
		LDREQ	r4, =color_pattern
		BEQ		back
		B 		mainloop
done	B		done
		ALIGN
color_pattern
		DCD	0x100, 0x010, 0x001, 0x001, 0x010, 0x100
		END

		