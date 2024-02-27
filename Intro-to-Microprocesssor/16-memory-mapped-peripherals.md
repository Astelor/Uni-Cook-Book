# Chapter 16, Memory-Mapped Peripherals
> How the hardware talks to the processor through software. Essentially the drivers (mouse, keyboard etc) on your PC, but simpler.
> And hey, the things mentioned within are still in the game, older doesn't mean outdated, not all things have to be fast, and fast=expensive.

(like the professors old enough to be our grandparent /j)

# Keys
- Introduction
- The LPC2104
  - The UART
  - The Memory Map
  - Configuring the UART
  - Writing the Data to the UART
  - Putting the Code Together
  - Running the Code
- The LPC 2132
  - The D/A Converter
  - The Memory Map
  - Configuring the D/A Converter
  - Generating a Sine Wave
  - Putting the Code Together
  - Running the Code
- the Tiva Launchpad
  - General-Purpose I/O
  - The Memory Map
  - Configuring the GPIO Pins
  - Turning on the LEDs
  - Putting the Code Together
  - Running the Code
- Exercises

# Funny Term bracket
> Things I encounter myself.
- system on a chip (SoC)
- NXP, a company that makes microcontrollers
- AHB, advanced high-performance bus
- VPB, VLSI peripheral bus
- RS-232, Recommended Standard, a standard fo serial communication transmission of data introduced in 1960

> bruh there are so many diagrams impossible to be transcribed to text diagram :'(

# CLASS
> Things I got encountered from the professor in class, or just questions. 
- BIOS (Basic I/O Services)
stored in ROM, and is the first thing the processor boots. Does everything has BIOS? or is there any processor too trivial to have BIOS?
- wait does a virtual machine has all the microcontroller stuff, a processor and memory?

# The LPC2104
> The devil, the (virtual) microcontroller we use in class

Do keep in mind the LPC2104 is a group of hardware(flash memory, peripherals, SRAM etc), and it has a core(microprocessor) called ARM7TDMI-S.

what we're dealing with. (the parts that matters for now), in short, CPU, MEMORY, I/O (peripheral)
```
+----------------+ || +---------------+
| internal flash |=+| | internal SRAM |
| controller     | |+=| controller    |
+----------------+ || +---------------+
 (128KB flash)     ||  (16KB SRAM)
                   ||
                   ||
+-------------+    || ARM7 local bus
| ARM7TDMI-S  |    ||
| (processor) |====++
+-------------+
| AHB bridge  |
+-------------+
  ||                 
  || AHB      +-------------+
  |+==========| AHB decoder |
  ||          +-------------+
  ||
+---------------------------------+
| AHB to VPB bridge | VPB divider |
+---------------------------------+
  ||
  || VPB   +-------------+
  |+=======| UART0/UART1 | <--[I/O]
  ||       +-------------+
  ||       +-------------------+
  |+=======| other peripherals | <--[I/O]
  ||       +-------------------+
```

Engineering is all about purposes btw, so there's a reason something specific is implemented.

- flash memory (128KB)
  - aka non-volatile memory
  - for your program
- on-chip RAM (16KB)
  - aka static RAM
  - for stacks and holding variables
  - 64KB for LPC2106, 32KB for LPC2105, 16KB for LPC2104

## The UART, LPC2104
> Universal Asynchronous Receiver/Transmitter, one of the most ubiquitous peripherals, which means it can be used to implement a variety of hardware

- Why asynchronous?
  - simplicity, flexibility, and compatibility.
  - synchronous = both sides shares the same clock.
  - without a shared clock, the UART uses a special bit to indicate start and end of data.
  - data can be transmitted between devices with different clock rate. (clock rate difference can be a huge issue)
- Asynchronous:
  - the data fetching and writing doesn't necessarily happen simultaneously.
  - receiver can get data when it wants to(the faster end), transmitter can write data when it needs to, and it happens in the buffer.

```
            +--------+
receiver <--| buffer |<--transmitter
            +--------+
```

## The Memory Map, LPC2104
> Peripherals' registers (config, data buffer, etc) are mapped to an address. peripheral <-> memory block <- CPU, as easy as that.

from 0x0~0xFFFFFFFF(4GB space, 2^32), every address has a dedicated task, hence the name memory map -> 4GB maximum for a 32 bit system.

> Again, you need a general register to appoint to an address, and the largest number a 32 bit system (32 bit register) can get is 2^32 or 0xFFFFFFFF.

This is the "maximum" layout, when all the addresses are used on the processors. It doesn't mean there's a 4GB memory anywhere on the controller dude.

> Okay I still don't understand what the system memory map is for. why map it when it's going to be scrambled anyways? I want the outline of the black box.
```
              I/O space ↓
         4GB+---------------------------------------+
0xFFFF FFFF |                                       |
            | AHB peripherals                       |
0xF000 0000 |                                       |
      3.75GB+---------------------------------------|
            | VPB peripherals                       |
0xE000 0000 |                                       |
       3.5GB+---------------------------------------|
            | reserved for external memory          |
0x8000 0000 |                                       |
         2GB+=======================================+
            | boot block                            |
0x7FFF E0000| (re-mapped from on-chip flash memory) |
            +---------------------------------------|
            | reserved for on-chip memory           |
0x4000 4000 |                                       |
            +---------------------------------------|
            | on-chip SRAM (16KB)                   |
0x4000 0000 |                                       |
         1GB+---------------------------------------|
            | reserved(not specified in the text)   |
0x0002 0000 |                                       |
            +---------------------------------------|
0x0001 FFFF |                                       |
            | 128KB on-chip flash memory            |
0x0000 0000 |                                       |
         0GB+---------------------------------------+
              Memory space ↑
```

## Configuring the UART, LPC2104
> peepotalk to the peripherals.