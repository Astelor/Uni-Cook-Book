# Chapter 7, Transistor Amplifiers
> Using transistor as amplifier

- [Chapter 7, Transistor Amplifiers](#chapter-7-transistor-amplifiers)
- [Keys](#keys)
- [Introduction](#introduction)
- [7.1 Basic Principles](#71-basic-principles)

# Keys
ehhhhh
- 7.1 Basic Principles
  - 7.1.1 The Basis for Amplifier Operation
  - 7.1.2 Obtaining a Voltage Amplifier
  - 7.1.3 The Voltage-Transfer Characteristic (VTC)
  - 7.1.4 Obtaining Linear Amplification by Biasing the Transistor
  - 7.1.5 The Small-Signal Voltage Gain
  - 7.1.6 Determining the VTC by Graphical Analysis
  - 7.1.7 Deciding on a Location for the Bias Point Q
- 7.2 Small-Signal Operation and Models
  - 7.2.1 The MOSFET case
  - 7.2.2 The BJT Case
  - 7.2.3 Summary Tables
- 7.3 Basic Configurations
  - 7.3.1 The Three Basic Configurations
- 7.4 Biasing
- 7.5 Discrete-Circuit Amplifiers

# Introduction
Two transistor applications:
- switch: digital circuits
- amplifier: analog circuits (a controlled source)
- 

Basic principles for MOSFET and BJT as amplifiers are the same, so we study them together and make comparisons. 

# 7.1 Basic Principles

Voltage-controlled current source:
- BJT in active mode
- MOSFET in saturation region (vGS controls iD)

> This chapter calls active mode (BJT) and saturation region (MOSFET) as active region.

`(7.1)`

NMOS, vGS controls iD in active region:
$$i_D=\frac 12 k_n (v_{GS}-V_{tn})^2$$

`(7.2)`

npn BJT, vBE controls iC in active region:
$$i_C=I_Se^{v_{BE}/V_T}$$

