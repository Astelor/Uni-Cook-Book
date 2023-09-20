# The Programmer's Model
## 2.1 Introduction
- A programmer...
  - NOT need an understanding of how the processor is constructed.
  - DO need a model of the device.
    - how the processor is controlled
    - the features available
      - E.g. where data is stored • what happens when an exception occurs • where you registers are stacked during an exception
- Begin with **ARM7TDMI** & **Cortex-M4**

## 2.2 Data Types
Data types ARM7TDMI & Cortex-M4 processors supports:
|Types|size|
|---|---|
|Byte|8 bits|
|Halfword|16 bits|
|Word|32 bits|

- ARM7TDMI
  - when reading or writing data:
    - halfwords must be aligned to two-byte(16 bits) boundaries.
    - words must be aligned to four-byte(32 bits) boundaries.
- Cortex-M4
  - allows unaligned accesses under certain conditions.

## 2.3 ARM7TDMI
- This chapter...
  - point out features that are common to all ARM processors, but differ by number, use, and limitations.

### Processor Modes
![Processor-Modes](attachments/Processor-Modes.png)
- Normally:
  - in User or Supervisor mode.
- When external event happens: *interrupts*
  - switch to FIQ or IRQ
  - E.g. when a human presses a key

- **FIQ**: fast
  - E.g. the machine is about to shutdown in a few seconds
- **IRQ**: slow
  - peripheral needs
    - E.g. user inputs • a key has been pressed

- **Abort**: recover from exceptional conditions
  - E.g. trying to access address that doesn't physically exists.
  - This mode can support virtual memory systems. Often a requirement for Linux systems.
- **Undefined**: when it sees an instruction in the pipeline it doesn't recognize.
  - "historically" can be used to support valid floating-point instructions on machines without physical floating-point hardware.
    - modern systems rarely on Undefined mode for such support. 


### Registers
- 37 registers: (36+1)
  - 30 general-purpose registers (32 bits)
  - 6 status registers
  - A Program Counter register (PC or r15)
- banked registers
  - processor suddenly changes mode 
  - save the state of the machine
  - swaps certain registers -> access fresh registers.
![Register organization](attachments/Register-Organization.png)

- Program Counter: pipeline

- Current Program Status Registers (CPSR)
![CPSR](attachments/ARM7TDMI-CPSR.png)
  -  Condition code flags
    - 31: N
    - 30: Z
    - 29: C
    - 28: V
  - Control bits
    - 7: I
    - 6: F
    - 5: T
    - 4~0: Mode