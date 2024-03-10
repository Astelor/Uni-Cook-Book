# Chapter 5, MOSFET
> Metal-oxide-semiconductor field-effect transistor.

> I made this more "concept oriented" and try to explain how it happens or where it comes from. This maybe a one man note but it is, in fact, notes.

- [Chapter 5, MOSFET](#chapter-5-mosfet)
- [Keys](#keys)
- [5.1 Device Structure and Physical Operation](#51-device-structure-and-physical-operation)
  - [5.1.1 Device Structure](#511-device-structure)
  - [5.1.2 Operation with Zero Gate Voltage](#512-operation-with-zero-gate-voltage)
  - [5.1.3 Creating a Channel for Current Flow](#513-creating-a-channel-for-current-flow)
  - [5.1.4 Applying a Small vDS](#514-applying-a-small-vds)
  - [5.1.5 Operation as vDS is Increased](#515-operation-as-vds-is-increased)
  - [5.1.6 Operation for vDS ≥ vOV: Channel Pinch-Off and Current Saturation](#516-operation-for-vds--vov-channel-pinch-off-and-current-saturation)
  - [5.1.7 The p-Channel MOSFET](#517-the-p-channel-mosfet)
  - [5.1.8 Complementary MOS or CMOS](#518-complementary-mos-or-cmos)
- [5.2 Current-Voltage Characteristics](#52-current-voltage-characteristics)
  - [5.2.1 Circuit Symbol](#521-circuit-symbol)
  - [5.2.2 The iD-vDS Characteristics](#522-the-id-vds-characteristics)
    - [5.2.2s Triode Region](#522s-triode-region)
    - [5.2.2s Saturation Region](#522s-saturation-region)
    - [5.2.2s Graph](#522s-graph)
  - [5.2.3 The iD-vGS Characteristic](#523-the-id-vgs-characteristic)
  - [5.2.4 Finite Output Resistance in Saturation](#524-finite-output-resistance-in-saturation)
  - [5.2.5 Characteristics of the p-channel MOSFET](#525-characteristics-of-the-p-channel-mosfet)

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
  - 5.2.4 Finite Output Resistance in Saturation
  - 5.2.5 Characteristics of the p-Channel MOSFET
- 5.3 MOSFET Circuits at DC
- 5.4 Technology Scaling (Moore's Law) and Other Topics
  - 5.4.1 Technology Scaling
  - 5.4.2 Subthreshold Conduction and Leakage Currents
  - 5.4.3 The Role of the Substrate- The Body Effect
  - 5.4.4 Temperature Effects
  - 5.4.5 Breakdown and Input Protection
  - 5.4.6 The Depletion-Type MOSFET

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

Turning on the transistor:
- Gate terminal positively charged: (and causes the following effect)
  - push free holes in the substrate down -> uncovers bound negative charge (creates depletion region)
  - attracts electrons from n+ regions to the channel region (underneath the oxide plate, still in the substrate)
- Sufficient electrons in the "channel" -> the channel connects S and D terminals.

In short, Gate positive voltage -> attract electrons -> n-channel.

The gate voltage(+) and channel(-) create an parallel-plate capacitor:
```
+----------------+
| Gate plate (+) |
+----------------+
| the oxide      | ↓ Electric
+----------------+   field ∝ vOV
| n-channel (-)  |
+----------------+
```
with the oxide acting as the capacitor dielectric, and an electric field that controls the amount of charge in the channel (5.2) -> field-effect transistor (hence the name)

`!(5.1)`
$$v_{GS}-V_t≡v_{OV}$$

Activation of the transistor:
- Vt: threshold voltage
  - the minimum voltage required between G and S to turn the transistor on.
  - fixed value -> manufacture
  - is positive for NMOS
  - typically 0.3V~1.0V
- **vOV**: effective voltage or overdrive voltage
  - the excess of vGS over Vt
  - also the average voltage that gives rise to channel charge
- vGS: voltage applied to the gate

> The gate voltage must exceed the threshold voltage to create an effective voltage between the parallel plate capacitor, so that it holds charges for the channel.

`(5.2)`
$$|Q|=[C_{ox}(WL)]v_{OV}$$

Magnitude of the electron charge in the channel:
- |Q|: yes
- Cox: oxide capacitance (F/m^2)
  - capacitance of the parallel-plate capacitor per unit gate area
- W: width of the channel (in the substrate)
  - can be as WIDE as you want (?)
- **L**: length of the channel (between the n+ regions)

> because the channel itself is one side of a capacitor

`!(5.3)`
$$C_{ox}=\frac{ϵ_{ox}}{t_{ox}}$$

How to get Cox from the specifications:
- ϵox: permittivity of the silicon dioxide
  - 3.9ϵ0 = 3.9 x 8.854 x 10^(-12) = 3.45 x 10^(-11) (F/m)
- **tox**: the thickness of the oxide

> How many charges the channel can hold is decided by its capacitance, which is a fixed value decided by its physical properties (dielectric material, thickness, plate surface area)

## 5.1.4 Applying a Small vDS
> Now the channel has electrons, let's make it flow! Applying vDS and vDS ≪ vOV. "Triode Region".

The current is carried by free electrons going from S to D, hence the names, the source and drain for electrons.
```
            (vGS>0)
(ground)    [G]       (vDS>0)
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

`!(5.6)`
$$Electron\ drift\ velocity=μ_n|E|=μ_n\frac{v_{DS}}{L}$$

- μn: mobility of the electrons (at the surface of the channel)

`!(5.7)`

with (5.4) (5.6) we get (C/m)*(m/s) = (C/s) = (Ampere)
$$i_D=[ (μ_nC_{ox})(\frac WL) ]v_{OV} v_{DS}$$

> Ampere is the rate at which the charges go through a cross-sectional area, you have (5.4) dictates how many charges are in a two dimensional area, and (5.6) dictates how "long" the charges passes for an unit second, creating a three dimensional volume, so you have how exactly many charges that have passed through the said area in a second. Which is, Ampere!

`(5.8)`

and we can substitute vOV with vGS - Vt (5.1)
$$i_D=[ (μ_nC_{ox})(\frac WL) ](v_{GS} - V_t) v_{DS}$$

`(5.9)`

dividing the current by its voltage, we get the conductance as well!
$$g_{DS}=[ (μ_nC_{ox})(\frac WL) ]v_{OV}=\frac{i_D}{v_{DS}}$$

- The conductance is determined by three factors

`(5.10)` or (substitute vOV with vGS - Vt (5.1))

---
> Now we have the math to describe how fast the electrons go, let's simplified the equation.

`(5.11)` 

factor 1 from (5.9)
$$k_n'=μ_nC_{ox}$$

the process transconductance (A/V^2), where n denotes n channel.

`!(5.12)`

factor 1+2 from (5.9)
$$k_n=k_n'(\frac WL)=(μ_nC_{ox})(\frac WL)$$

the MOSFET transconductance parameter (A/V^2) 
And we can see this parameter is a constant.
- **(W/L)**: aspect ratio -> dimensionless
  - The length has a minimum value, and is limited to our manufacture technology.

> vOV, the one value that rules them all. It directly determines the magnitude of electron charge in the channel. And is in fact, determined by vGS, the gate voltage.

---

`(5.13a)`

the reciprocal of conductance is resistance
$$r_{DS}=\frac{1}{g_{DS}}=\frac{v_{DS}}{i_D}$$


`(5.13b)` 

you can replace gDS with its own definition (5.9), and substitute vOV to vDS - Vt (5.1)

$$r_{DS}=\frac{1}{(μ_nC_{ox})(W/L)(v_{GS}-V_t)}$$

Note:
$$r_{DS}=∞,\ when\ vGS ≤ Vt$$

> When the gate voltage is lower than the threshold voltage, it doesn't conduct (not enough charge, no channel, no current). When the gate voltage is larger, more charges will gather, it's a capacitor ok.

Resistance decreases as vGS is increased above Vt, thus enhancing the channel, hence the names enhancement-mode operation and enhancement-type MOSFET.

> Astelor: I still don't understand what figure 5.4 is about

## 5.1.5 Operation as vDS is Increased
> But wait, vOV doesn't rule it all, there's another contender vDS, and the channel is getting askew. Applying vDS, and vDS ≤ vOV, average voltage is vOV - (1/2) vDS.
> "Triode Region".

> Astelor: lmao wtf am I writing

```
            (vGS>0)
(ground)    [G]       (vDS>0)
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

![5.1.5-5.6ab](attachments/5.1.5-5.6ab.png)

$$v_{GD}+v_{DS}=v_{GS}=V_t+v_{OV}$$

$$v_{GD}=v_{GS}-v_{DS}=V_t+v_{OV}-v_{DS}$$

The applied vDS is a voltage drop from the drain end to the source end (0V).

vOV remains constant -> vGS remains constant, the shallowest end at the drain has the depth proportional to vOV - vDS

`(5.14)`

taking the "tapered channel" into consideration, while vDS < vOV
$$i_D=k_n'(\frac WL)(v_{OV}-\frac{1}{2}v_{DS})v_{DS}$$

> Since the average voltage that gives rise to channel charge (vOV) is affected by a voltage drop created by vDS, the average voltage became vOV-(1/2)vDS -> thus when vDS ≪ vOV, the "tapering effect" is negligible

`(5.15)`

writing (5.14) in an alternate form
$$i_D=k_n'(\frac WL)(v_{OV}v_{DS}-\frac 12v_{DS}^2)$$

`(5.16)` we can also replace vOV with "vGS - Vt" and rewrite (5.15)

current voltage characteristic:
![5.1.5-5.7](attachments/5.1.5-5.7.png)

vOV is a constant here, the graph can be referred to equation (5.15)

## 5.1.6 Operation for vDS ≥ vOV: Channel Pinch-Off and Current Saturation
> We know vDS can affect the average voltage(vOV-(1/2)vDS) that gives rise to the channel charge (5.2), what happens when vDS is LARGE? applying vDS, and vDS ≥ vOV. average voltage is (1/2)(vOV^2)
> "Saturation Region".

> Spoiler: the "tapering effect" stops at vDS = vOV, the channel depth at the drain(vOV - vDS = 0) is pinch-off. When vDS > vOV, (ideally) nothing happens, the drain current saturates at vDS = vOV, and iD remains the same. The excess voltage of vDS will be dropped like your internet packets at school.

please refer to the graph at 5.1.5 for the simplified diagram :)

```
  Voltage
     |
     |----+
 Vt ↕|    | ↕ vGD = Vt
     |----+ pinch-off
   ↑ |   /| ↑
vOV| |  / | | vDS = vOV
   | | /  | |
   ↓ |/   | ↓
     +--------> x
     0    L
```

`(5.17)`

rewriting equation (5.14), when vDS = vOV

$$i_D=\frac 12k_n'(\frac WL)(v_{OV}^2)$$

`(5.18)`

$$v_{DSsat}=v_{OV}=v_{GS}-V_t$$

The voltage vDS at which the saturation occurs is denoted vDSsat

- MOSFET enters saturation region
  - iD remains the same. (5.17)
  - any increase in vDS above vOV appears as a voltage drop across the depletion region. (5.17)
  - the drain end has channel pinch-off, (5.18)

`(5.19)` we can also replace vOV with vGS - Vt and rewrite (5.17)

> SECTION SUMMARY:
>
> We now know how to activate a transistor (vGS ≥ Vt, vOV=vGS-Vt), how many charges are in the transistor's channel (|Q|=Cox(WL)vOV), and how fast the charges goes when applying voltage at the drain channel (iD=kn vOV vDS). 
> 
> With the drain voltage we analyzed how different magnitude of vDS affects the iD (vDS versus vOV), the vDS creates a voltage drop across the drain and source terminals, subsequently affects the effective voltage (aka overdrive voltage) that give rise to the channel charge, and affects how we write the iD equation (iD=kn (vOV-((1/2)vDS)) vDS) (5.7).

> look at da graph!

---
> Astelor: you might want a cheat sheet for the equations for quick reviewing.

## 5.1.7 The p-Channel MOSFET
> The reverse of NMOS, PMOS and NMOS are complementary devices

```
        +-----------+
        |Gate(metal)|
   +--+ +-----------+ +--+
   |S | |oxide(SiO2)| |D |
+-+------+---------+------+-+
| | p+   | Channel | p+   | |
| +------+ region  +------+ |
| n-type substrate          |
+---------------------------+
          | Body |
```

Instead of npn, PMOS is pnp, gate voltage is negative, drain voltage is negative, the S -> the source of positive carriers, creating a p channel.

```
            (vGS<0)
(ground)    [G]       (vDS<0)
     [S]     |↓iG=0   [D]
iS=iD↓| =============  |↑ iD
   ==== ============= ====
+-+------+---------+------+-+
| |  p+  |    iD→  |  p+  | |
| +------+ <--L--> +------+ | 
|  n-type substrate         | 
+---------------------------+
          ======
             |
            [B] (ground)    
```

$$v_{GS}≤V_{tp}<0$$
$$|v_{SG}|≥|V_{tp}|$$

- Vtp: threshold voltage for PMOS by convention is **negative**

$$k_p'=μ_pC_{ox}$$
$$k_p=k_n'(W/L)$$

- μp: mobility of the holes in the induced p-channel (μp=0.25μn ~ 0.5μn)
  - is process-technology dependent

## 5.1.8 Complementary MOS or CMOS
> NMOS + PMOS = CMOS, most widely used of all the IC technologies in both analog and digital circuits

![5.1.8-5.10](attachments/5.1.8-5.10.png)

- more difficult to fabricate
- makes many powerful circuit configuration possible

> how and why CMOS though?

# 5.2 Current-Voltage Characteristics
> Static characteristics -> measured at dc or low frequencies

> The dynamic effects will be discussed in chapter 10.

## 5.2.1 Circuit Symbol
> SYMBOL

Circuit symbol for the n-channel enhancement-type MOSFET:
```
       D
       |
    |--+
G--||<---B
    |--+
       |
       S
(a)
```
Modified circuit symbol with an arrowhead on the source terminal to distinguish it from the drain and to indicate device polarity:
```
       D
       |
    |--+
G--||----B
    |->+
       |
       S
(b)
```
Simplified circuit symbol when the source is connected to the body, or when the effect of the body on device operation is unimportant:
```
       D
       |
    |--+
G--||
    |->+
       |
       S
(c)
```

> In practice, the polarity of the voltage applied across the device that determines the source and drain, the drain is always positive relative to the source in a n-channel MOSFET

## 5.2.2 The iD-vDS Characteristics
> The graph about iD-vDS characteristics is shown in [5.1.5](#515-operation-as-vds-is-increased)

> Table 5.1 covers NMOS triode region and saturation region.

> We can use the drain voltage to achieve triode and saturation region, we can also use the gate voltage to do the same thing -> it governs total charge in the channel.

### 5.2.2s Triode Region
Continuous channel (not pinched-off):
$$v_{GD}>V_{tn}$$
or equivalently
$$v_{DS} < v_{OV}$$
then
$$i_D=k_n' (\frac WL) (v_{OV}- \frac 12 v_{DS}) v_{DS}$$
or equivalently
$$i_D=k_n'(\frac WL)[(v_{GS}-V_{tn})v_{DS}-\frac 12v_{DS}^2]$$

### 5.2.2s Saturation Region
Pinched-off channel:
$$v_{GD}≤V_{tn}$$
or equivalently
$$v_{DS}≥v_{OV}$$
then
$$i_D=\frac 12k_n'(\frac WL)v_{OV}^2$$
or equivalently
$$i_D=\frac 12k_n'(\frac WL)(v_{GS}-V_{tn})^2$$

### 5.2.2s Graph

![5.2.2-5.13](attachments/5.2.2-5.13.png)
vOV=vGS-Vtn, we use the overdrive voltage as a constant in each iteration of the functions. And the points where vDS=vOV (MOSFET enters saturation region) can be described by:

`(5.20)`

$$i_D=\frac 12k_n'(\frac WL)v_{DS}^2$$
when vDS=vOV (entering saturation region)

## 5.2.3 The iD-vGS Characteristic
> Using MOSFET as an amplifier, its operation is in the saturation region (vDS ≥ vOV).

In saturation, the drain current is a constant determined by the gate voltage(vGS or vOV), and is independent of drain voltage (vDS) -> MOSFET operates as a voltage controlled current source.

`(5.21)`

$$i_D=\frac 12k_n'(\frac WL)(v_{GS}-V_{tn})^2$$

`(5.22)` or in terms of vOV

$$i_D=\frac 12k_n'(\frac WL)v_{OV}^2$$

This implies the current-voltage characteristics (iD-vGS) is nonlinear when MOSFET is operating as an amplifier(saturation region, and is controlled by the gate voltage). (MOSFET as amp -> chapter 7)

large-signal equivalent circuit:
```
iG=0→       ←iD
G o--o    +----o D
     +vGS |    +vDS
          ▲
          ↓ (1/2)k'n(W/L)(vGS-Vtn)^2
          ▼
     -    |    -
  o----+--+----o
       |
       o S  vGS≥Vtn
            vDS≥vOV
```

## 5.2.4 Finite Output Resistance in Saturation

- Ideally: 
iD is independent of vDS -> iD remains the same with any change in vDS -> rDS is infinite. And this is base on the premise that vDS has no effect on the channel's shape once vDS≥vOV (pinched-off).

- In practice:
Pinch-off point moves slightly away from the drain when vDS≥vOV. And the phenomenon is known as channel-length modulation.

**Channel-length modulation**:
```
S+-------------+------+D
 |◤channel     |      |
 |-        vOV+|-    +| vDS-vOV
 |<---(L-∆L)-->|<-∆L->|
 |<-----L------------>|
```

`(5.23)`

We account for this effect for iD by including a factor 1+λ(vDS-vOV) or (1+λvDS)

$$i_D=\frac 12k_n'(\frac WL)(v_{GS}-V_{tn})^2(1+λvDS)$$

- λ: device parameter 
  - its unit are reciprocal volts (V^-1)
  - its value depends on both process technology and channel length L.
  - new technology -> shorter L -> more greatly impacted by channel-length modulation

## 5.2.5 Characteristics of the p-channel MOSFET
