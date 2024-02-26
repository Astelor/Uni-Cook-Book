# Chapter 5, MOSFET
> Metal-oxide-semiconductor field-effect transistor.

> Astelor: I'm infinitely annoyed that the professor doesn't elaborate much about "how" it works, just "it works like that and the equations look like this, memorize it and that's it" There's a reason I chose engineering over social science, I cannot and hate memorizing shit. There's a phenomenon first then there's a math description.

> Astelor: I'm signing as if there is a co-writer, there isn't.

# Keys
eh why not
- 5.1 Device Structure and Physical Operation
  - 5.1.1 Device Structure
  - 5.1.2 Operation with Zero Gate Voltage
  - 5.1.3 Creating a Channel for Current Flow
  - 5.1.4 Applying a Small vDS
  - 5.1.5 Operation as vDS is Increased
  - 5.1.6 Operation for vDS ≥ vOV: Channel Pinch-Off and Current Saturation
  - 5.1.7 The p-Channel MOSFET
  - 5.1.8 Complementary MOS or CMOS
- 5.2 Current-Voltage Characteristics
  - 5.2.1 Circuit Symbol
  - 5.2.2 the iD-vDS Characteristics
  - 5.2.3 The iD-vGS Characteristics
  - 
- 5.3 MOSFET Circuits at DC
- 5.4 Technology Scaling (Moore's Law) and Other Topics

# 5.1 Device Structure and Physical Operation
> enhancement-type MOSFET is the most widely used FET

## 5.1.1 Device Structure
Physical structure of n-channel enhancement-type MOSFET:
```
        +-----------+
        |Gate(metal)|
   +--+ +-----------+ +--+
   |S | |oxide(SiO2)| |D |
+-+------+---------+------+-+
| | n+   | Channel | n+   | |
| +------+ region  +------+ |
| p-type substrate          |
+---------------------------+
          | Body |
          +------+
```
- Terminals: a layer of metal, creating an electrode
  - S: Source -> connecting the n+
  - G: Gate -> insulated from body
  - D: Drain -> connecting the n+
  - B: Body -> connecting the substrate
- n+: n-type semiconductor (source & drain region)
- p-type substrate: single-crystal silicon wafer
- oxide: electrical insulator


aka NMOS transistor, aka n-channel MOSFET.
MOSFET is symmetrical, interchanging S and D makes no difference.

Specifications (that matters):
```
        +-----------+
        |           |
   +--+ +-----------+ +--+
   |  | |↕tOX       | |  |
+-+------+---------+------+-+
| |      |         |      | |
| +------+ <-L---> +------+ | W
|            Length         | Width
+---------------------------+
          |      |
          +------+
```

## 5.1.2 Operation with Zero Gate Voltage
> two back-to-back diodes in series when vGS=0
the path between D and S has a very high resistance (of the order of 10^12 Ω)

## 5.1.3 Creating a Channel for Current Flow
> MOSFET activate! vGS ≥ Vt, specifically NMOS.

- Gate terminal positively charged
  - push free holes in the substrate down -> uncovers bound negative charge (creates depletion region)
  - attracts electrons from n+ regions to the channel region (underneath the oxide plate, still in the substrate)
- results in sufficient electrons in the "channel" -> the channel connects S and D terminals.

in short, Gate positive voltage -> attract electrons -> n-channel.
AND this creates an parallel-plate capacitor:
```
+----------------+
| Gate plate (+) |
+----------------+
| the oxide      | ↓ Electric field = vOV
+----------------+
| n-channel (-)  |
+----------------+
```
with the oxide acting as the capacitor dielectric, and a electric field that controls the amount of charge in the channel `(5.2)` -> field-effect transistor

`(5.1)`
$$v_{GS}-V_t≡v_{OV}$$

Activating the transistor:
- Vt: threshold voltage
  - the minimum voltage required between G and S to turn the transistor on.
  - is positive for NMOS
  - fixed value -> manufacture
  - typically 0.3V~1.0V
- **vOV**: effective voltage or overdrive voltage
  - the excess of vGS over Vt
  - also the average voltage across the channel 
- vGS: voltage applied to the gate

`(5.2)`
$$|Q|=[C_{ox}(WL)]v_{OV}$$

Magnitude of the electron charge in the channel:
(because the channel itself is one side of a capacitor)
- |Q|: yes
- Cox: oxide capacitance (F/m^2)
  - capacitance of the parallel-plate capacitor per unit gate area
- W: width of the channel (in the substrate)
  - can be as WIDE as you want (?)
- **L**: length of the channel (between the n+ regions)

`(5.3)`
$$C_{ox}=\frac{ϵ_{ox}}{t_{ox}}$$

How to get Cox from the specifications:
- ϵox: permittivity of the silicon dioxide
  - 3.9ϵ0 = 3.9 x 8.854 x 10^(-12) = 3.45 x 10^(-11) (F/m)
- **tox**: the thickness of the oxide

> These describes how conductive the channel is.

## 5.1.4 Applying a Small vDS
> now the channel has electrons, let's make it flow! applying vDS and vDS ≪ vOV

The current is carried by free electrons going from S to D, hence the names, the source and drain for electrons.
```
            (vGS)
(ground)    [G]       (vDS)
     [S]     |↓iG=0   [D]
iS=iD↑| =============  |↓ iD
   ==== ============= ====
+-+------+---------+------+-+
| |  n+  |   ←iD   |  n+  | |
| +------+ <--L--> +------+ | 
|  p-type substrate         | 
+---------------------------+
          ======
             |
            [B] (ground)         
```

So how fast does the electrons go? (Ampere = Coulomb/second)

> Texts above the equation is where or how it comes from, below is the definitions to it.
> since the equations here are rather self explanatory, there isn't much description ok.

`(5.4)`
$$\frac{|Q|}{L}=C_{ox}Wv_{ox}$$

Charge per unit channel length (C/m), it's the amount of charge in a cross-sectional area.

`(5.5)`
$$|E|=\frac{v_{DS}}{L}$$

Electric field established by vDS across the length of the channel (V/m). (tis the basic law ok)

`(5.6)`
$$Electron\ drift\ velocity=μ_n|E|=μ_n\frac{v_{DS}}{L}$$

- μn: mobility of the electrons (at the surface of the channel)

`(5.7)`

with `(5.4)` `(5.6)` we get (C/m)*(m/s) = (C/s) = (Ampere)
$$i_D=[ (μ_nC_{ox})(\frac WL) ]v_{OV} v_{DS}$$

> Ampere is the rate at which the charges go through a cross-sectional area, you have (5.4) dictates how many charges are in a two dimensional area, and (5.6) dictates how "long" the charges passes for an unit second, creating a three dimensional volume, so you have how exactly many charges that have passed through the said area in a second. Which is, Ampere!


`(5.8)`

and we can substitute vOV with vGS - Vt `(5.1)`
$$i_D=[ (μ_nC_{ox})(\frac WL) ](v_{GS} - V_t) v_{DS}$$

`(5.9)`

dividing the current by its voltage, we get the conductance as well!
$$g_{DS}=[ (μ_nC_{ox})(\frac WL) ]v_{OV}=\frac{i_D}{v_{DS}}$$

- The conductance is determined by three factors

`(5.10)` or (substitute vOV with vGS - Vt `(5.1)`)

> Now we have the math to describe how fast the electrons go, let's simplified the equation.

`(5.11)` 

factor 1 from `(5.9)`
$$k_n'=μ_nC_{ox}$$

the process transconductance (A/V^2), where n denotes n channel.

`(5.12)`

factor 1+2 from `(5.9)`
$$k_n=k_n'(\frac WL)=(μ_nC_{ox})(\frac WL)$$

the MOSFET transconductance parameter (A/V^2)
And we can see this parameter is a constant.
- (W/L): aspect ratio -> dimensionless
  - The length has a minimum value, and is limited to our manufacture technology.

> vOV, the one value that rules them all. It directly determines the magnitude of electron charge in the channel. and is in fact, determined by vGS, the gate voltage.


the reciprocal of conductance is resistance
> These describes..

## 5.1.5 Operation as vDS is Increased
> but wait. vOS doesn't rule it all, there's another contender...vDS, and the channel is getting askew. vOV - (1/2) vDS

> Astelor: lmao wtf am I writing

