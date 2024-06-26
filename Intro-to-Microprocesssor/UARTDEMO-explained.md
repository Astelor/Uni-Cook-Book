# UARTDEMO-explained

The code explained is here: [UARTDEMO](code/examples/UARTDEMO.s)

And the corresponding specs for LPC2104: [UM10275](resources/UM10275.pdf)


```arm-asm
PINSEL0     EQU     0xE002C000      ; controls the function of pins
U0START     EQU     0xE000C000      ; start of UART0 register
LCR0        EQU     0xC             ; line control register for UART0
LSR0        EQU     0x14            ; line status register for UART0
RAMSTART    EQU     0x40000000      ; start of onboard RAM for 2104
            ENTRY
```

# UARTConfig

> Configuration for UART

```arm-asm
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
```

## PINSEL0 

> Pin function select register 0 (page 63)

```arm-asm
LDR     r5, =PINSEL0    ; base address of register
LDR     r6, [r5]        ; get contents
BIC     r6, r6, #0xF    ; clear out lower nibble
ORR     r6, r6, #0x5    ; sets p0.0 to Tx0 and p0.1 to Rx0
STR     r6, [r5]        ; r/modify/w back to register
```

- Purpose:
  - Setting the pin to the desired mode

|PINSEL0|Pin Name|Value|Function|
|-|-|-|-|
|1:0|P0.0|00|GPIO Port 0.0|
|||01|TXD (UART 0)|
|||10|PWM1|
|3:2|P0.1|00|GPIO Port 0.1|
|||01|RXD (UART 0)|
|||10|PWM3|

> Every pin has 2 bits of value to determine its function. So we clear out the "lower nibble", which is p0.0 and p0.1

# MISC

- Baud rate
  - $Baud=\frac{UART Clock Frequency}{Divisor\times 16}$

# Funny Term Bracket

> comp-sci/engineering gatekeep at its finest

- UART (Universal Asynchronous Receiver/Transmitter)
- U0RBR (Receiver Buffer Register)
- U0THR (Transmit Holding Register)
- RX (receive/receiver)
- TX (transmit/transmitter)
- U0DLL (Divisor Latch LSB)
- LSB (????)
- U0TSR (UART0 TX Shift Register)
- TXD0 (Transmitter output for UART 0)
- THRE (LSR0, Tx Holding Register Empty)
- TEMT (LSR0, Transmitter Empty)
- FIFO (First-in, first-out)

```
[U0THR] -> [U0TSR]-> TXD0
```

> Consult the architecture page when questioning what goes where.
> Wait we have a fractional divider register on UART0 for buadrate calculation?

# LSR0 (Line Status Register, UART0)

> Shows the status for RX and TX buffer registers, and the attributes to the data it holds.

# Serial I/O

About Keil serial window: https://www.keil.com/support/man/docs/uv4cl/uv4cl_db_dbg_serialwin.htm

> "The Serial window accepts serial input and output data streams. The window displays serial output data received from a simulated CPU, while **characters typed into a serial window are input to the simulated CPU**"
>
> Astelor: there's no RXD0 or TXD0 'interface window' to be found, the serial window itself is the I/O interface
> 
> tl;dr, type in UART #1 for input

```
+---------------+
[U0THR]->[U0TSR]->|->
```