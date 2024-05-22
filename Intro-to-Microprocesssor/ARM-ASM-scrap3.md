# Scrap 3

- Thread mode/ Handler mode

> Handler is for exception handling (Exception entry)
> Thread is for normal operation (EXception exit)

- Privileged/ User
> Handler mode can only be Privileged
> Thread can be either, dictated by the `CONTROL` register

Resetting will return to Privileged Thread mode.



# Quick list for the tm4c1233h6pm manual 

> The NVIC registers

- Exception types p.95

- Configuration and Control (CFGCTRL), 0xD14, p.162

- System Handler Priority 1, 0xD18 ,p.163

- System Handler Control and State (SYSHNDCTRL), 0xD24,p.166

> "If a system handler is disabled and the corresponding fault occurs, the processor treats the fault as a **hard fault**."


# Priority

Example:
- Priority group number = x
- Priority group x
- Group (Pre-emption) Priority Field: bit[7:x+1]
- Sub-priority Field: bit[x:0]

http://www.ocfreaks.com/interrupt-priority-grouping-arm-cortex-m-nvic/

# Code for settings

```asm
; enable the divide-by-zero trap
; located in the NVIC
; base: 0xE000E000
; offset: 0xD14
; bit: 4
LDR		r6, =NVICBase
LDR		r7, =DivbyZ
LDR		r1, [r6, r7]
ORR		r1, #0x10		; enable bit 4
STR		r1, [r6, r7]
```

# Code (mode transition)

> Will take effect when after exiting exception


- PT to UT

> Reset (PT) -> modify `CONTROL` register (UT)
> Will take effect immediately

```asm
Reset_Handler
	MRS		r8, CONTROL
	ORR		r8, r8, #1
	MSR		CONTROL, r8
```

- PT to PH

> Reset(PT) -> exception entry (PH)

```asm
Reset_Handler
	MOV		r0, #0
	MOV		r1, #0x11111111
	MOV		r2, #0x22222222
	MOV		r3, #0x33333333

	UDIV	r5, r3, r0
```

- PH to PT

```asm
Reset_Handler
	UDIV	r5, r3, r0
	; enters PH

IntDefaultHandler
	BX 	LR
	; leaves PH
```

- PH to UT

```asm
Reset_Handler
	UDIV	r5, r3, r0
	; enters PH

IntDefaultHandler
	MRS		r8, CONTROL
	ORR		r8, r8, #1
	MSR		CONTROL, r8
	BX 		LR
	; leavse PH

```

- PT to UT to PH to PT
```asm
Reset_Handler

	MRS		r8, CONTROL
	ORR		r8, r8, #1
	MSR		CONTROL, r8
	; enter UT
	
	UDIV	r5, r3, r0
	; enter PH

IntDefaultHandler
	MRS		r8, CONTROL
	BIC		r8, r8, #1
	MSR		CONTROL, r8
	; enter PT
	
	BX 		LR
```