# Chapter 6, Bipolar Junction Transistor
> aka BJT
> a dangling note waiting to be written.
> well well well, isn't it the consequences to my actions

# Keys
- 6.1 Device Structure and Physical Operation
  - 6.1.1 Simplified Structure and Modes of Operation
  - 6.1.2 Operation of the npn Transistor in the Active Mode
  - 6.1.3 Structure of Actual Transistors
  - 6.1.4 Operation in the Saturation Mode
  - 6.1.5 The pnp Transistor 
- 6.2 Current-Voltage Characteristic
  - 6.2.1 Circuit Symbols and Conventions
  - 6.2.2 Graphical Representation of Transistor Characteristics
  - 6.2.3 Dependence of iC on the Collector Voltage-The Early Effect
  - 6.2.4 An Alternative Form of the Common-emitter Characteristics
- 6.3 BJT Circuits at DC
- 6.4 Transistor Breakdown and Temperature Effects
  - 6.4.1 Transistor Breakdown
  - 6.4.2 Dependence of beta on iC and Temperature

# 6.1 Device Structure and Physical Operation

## 6.1.1 Simplified Structure and Modes of Operation
> The basics...

Simplified structure of npn transistor: (like NMOS)
```     
      +---------+--------+-----------+
      | n-type  | p-type | n-type    |
 o----+ Emitter | Base   | Collector +----o
(E)   | region  | region | region    |   (C)
      +---------+----+---+-----------+
(emitter-base  EBJ   |  CBJ (collector-base
 junction)           o       junction)
                    (B)
```

Simplified structure of pnp transistor: (like PMOS)
```     
      +---------+--------+-----------+
      | p-type  | n-type | p-type    |
 o----+ Emitter | Base   | Collector +----o
(E)   | region  | region | region    |   (C)
      +---------+----+---+-----------+
                     | 
                     o      
                    (B)
```

- Two pn junctions:
  - emitter-base junction (EBJ)
  - collector-base junction (CBJ)
- Three terminals:
  - emitter (E)
  - base (B)
  - collector (C)

Biasing conditions at junctions give different modes of operations.
> current flows from: n->p reverse bias, p->n forward bias. 
> "negative" -> "positive", reverse. "positive" -> "negative", forward. :)

BJT modes of operation:
|Mode|EBJ|CBJ|
|-|-|-|
|Cutoff|Reverse|Reverse|
|Active|Forward|Reverse|
|Saturation|Forward|Forward|

Charge carriers of both polarities participate in the current-conduction process in a bipolar transistor. (Contrasting with MOSFET where current is conducted by one type of carrier.)

## 6.1.2 Operation of the npn Transistor in the Active Mode
> go transistor go

- EBJ: forward bias
- CBJ: reverse bias

```     
      +---------+--------+-----------+
      |    n    |    p   |     n     |
 o----+         |        |           +----o
(E)   |         |        |           |   (C)
      +---------+----+---+-----------+
               EBJ   |  CBJ
                     o
                    (B)
```

