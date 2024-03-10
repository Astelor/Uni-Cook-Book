# Chapter 1, Waves and Phasors
> Introduction chapter, all the basic things you should know

- [Chapter 1, Waves and Phasors](#chapter-1-waves-and-phasors)
- [Keys](#keys)
- [1-3 The Nature of Electromagnetism](#1-3-the-nature-of-electromagnetism)
  - [1-3.1 Gravitational Force: A Useful Analogue](#1-31-gravitational-force-a-useful-analogue)
  - [1-3.2 Electric Fields](#1-32-electric-fields)
    - [1-3.2s Coulomb's law](#1-32s-coulombs-law)
    - [1-3.2s Two important properties of electric charge](#1-32s-two-important-properties-of-electric-charge)
    - [1-3.2s Polarization of dielectric material](#1-32s-polarization-of-dielectric-material)
  - [1-3.3 Magnetic Fields](#1-33-magnetic-fields)
  - [1-3.4 Static and Dynamic Fields](#1-34-static-and-dynamic-fields)
    - [1-3.4s The three branches of electromagnetics](#1-34s-the-three-branches-of-electromagnetics)
    - [1-3.4s parameters mentioned](#1-34s-parameters-mentioned)
- [1-4 Traveling Waves](#1-4-traveling-waves)
  - [1-4.1 Sinusoidal Waves in a Lossless Medium](#1-41-sinusoidal-waves-in-a-lossless-medium)

# Keys
- 1-1 Historical Timeline
- 1-2 Dimensions, Units, and Notation
- 1-3 The Nature of Electromagnetism
- TB1 LET Lighting
- 1-4 Traveling Waves
- 1-5 The Electromagnetic Spectrum
- 1-6 Review of Complex Numbers
- TB2 Solar Cells
- 1-7 Review of Phasors

> please revisit 1.1 and 1.2 if you need to

# 1-3 The Nature of Electromagnetism

Four fundamental forces of nature:
- nuclear force (1)
  - strongest
  - but its range is limited to subatomic scale (nucleons)
  - the force that binds protons and neutrons -> makes protons stay together.
- electromagnetic force (10^ -2)
  - between charged particles
  - dominant force in microscopic system (e.g. atoms & molecules)
- weak-interaction force (10^ -14)
  - radioactive decay (e.g. beta decay)
- gravitational force (10^ -41)
  - weakest
  - dominant force in macroscopic systems. (e.g. solar system)

```
+---------------------+
| (protons)(neutrons) |
+---------------------+

(+)(-)

[beta decay]

[you]-->[sun]<--[pluto]
```
I tried

---

## 1-3.1 Gravitational Force: A Useful Analogue
> The way gravity works is similar to electric forces, so let's look at this first.

According to **Newton's law of gravity**, the gravitational force Fg21 acting on mass m2 due to a mass m1 at a distance R12 from m2 is given by:

`(1.2)`

$$F_{g_{21}}=-\hat{R_{12}}\frac{Gm_1m_2}{R^2_{12}}\ (N)$$

- Fg21: m2 experiencing gravitational force because of m1.

> m2 "moves" because there's another mass, m1 pulling at m2. Fg21 is acted on m2, and it points from m2 to m1 (thus the notation 21).

> Two masses, vector for direction, distance for intensity, I think.

```
  Fg12        Fg21
  -->         <--
[m1]-->R12     [m2]
 |----------R12--|
```

---

Phenomenon of action at a distance -> **Concept of fields** -> mass m1 induces a gravitational field (doesn't physically emanate from the object)

```
          -R  
 ↘   ↓   ↙
   ↘ ↓ ↙   Ψ1
→ → [m1] ← ← [m2]
   ↗ ↑ ↖
 ↗   ↑   ↖
```

`(1.3)`

$$F_{g_{21}}=Ψ_1m_2$$

The force acting on m2 when placed near m1.

`(1.4)`

$$Ψ_1=-\hat R\frac{Gm_1}{R^2}\ (N/kg)$$

Gravitation field induced by m1.

`(1.5)`

Generalizing the field concept, at any point in space when a test mass m is placed, we can test its gravitational field (Fg acting on the test mass, Fg may be due to a single mass or a collection of many masses).

$$Ψ=\frac{F_g}{m}$$

> I don't really wanna note the vector nature into the variables, if its definition has vector, then it's a vector, it pointy.

---

## 1-3.2 Electric Fields

Differences between gravitational force:
- source of electrical field is the electric charge
- positive and negative polarity -> attractive or repulsive 

```
  Fe12           Fe21
 <--             -->
[+q1]-->R12     [+q2]
  |----------R12--|
```

`(1.6)`

$$e=1.6×10^{-19}\ (C)$$
Magnitude of electron, measured in coulomb.

### 1-3.2s Coulomb's law
> Coulomb's conclusions on how charges behave.

1. two like charges repel one another, whereas two charges of opposite polarity attract
2. the force acts along the line joining the charges
3. its strength is proportional to the product of the magnitudes of the two charges (q1*q2) and inversely proportional to the square of the distance between them (1/R^2)

```
[+]→ ←[-]
[+]← →[+] [-]← →[-]
[--]←← →→[-]
```

```
Fe12←[+q1]<---R12--->[+q2]→Fe21
```

`(1.7)`

Coulomb's law expressed mathematically:

$$F_{e_{21}}=\hat R_{12}\frac{q_1q_2}{4πε_0R^2_{12}}$$

The electric force Fe21 acting on q2 due to q1.

- ε0: electrical permittivity of free space = 8.854×10^-12 (F/m)

$$F_{e_{21}}=-F_{e_{12}}$$
- Fe12 and Fe21 is **equal in magnitude** but opposite in direction

`(1.8)`

extending the analogy in [1-3.1](#1-31-gravitational-force-a-useful-analogue) for existence of an **electric field intensity** E

$$E=\hat R\frac{q}{4πε_0R^2}\ (V/m) $$
(in free space)

- R: radial unit vector pointing away from the charge

### 1-3.2s Two important properties of electric charge
> what you should know before dealing with charges

1. **law of conservation of electric charge** -> net charge can neither be created nor destroyed (it doesn't be "gone", unless radioactive things is involved)
2. **principle of linear superposition** -> "the total vector electric field at a point in space due to a system of point charges is equal to the vector sum of the electric fields at that point due to the individual charges".

> The first one makes our physical world (math) correct, the second one makes sense of our physical world (and make our math easier). (they both sort of do the same things though)
---
Explanation and examples of the two properties:

1. Law of conservation:
> it's about the number of charges (no matter the polarity), and they do not just be "gone" and go "poof" when e+(-e).

`(1.9)`

$$q=n_pe-n_ee=(n_p-n_e)e$$

Net charge q of a volume that contains protons(+) and electrons(-), even if np=ne, q remains unchanged. Because "the protons inside the atom's nucleus and the electrons outside it do NOT allow them to combine"

2. Principle of linear superposition:
> The forces are linear functions, the fields are an area of forces, they combine.

The field concept satisfy the additivity and homogeneity and is a "linear function".

3 charges pushes 1 charge away:
```
O ↘
O → O →
O ↗
```
---
### 1-3.2s Polarization of dielectric material
> What happens when the conceptional field is in a material?

Polarization of the atoms of a dielectric material by a positive charge:
```
dielectric material
+-------------+
|     [±]     |
|[+-] (+) [-+]|
|     [∓]     |
+-------------+
```
- electric dipole: the polarized atoms [+-]
  - the orientation -> axis connecting its two poles [+-] is directed toward the point charge (+).
- polarization: the distortion process [+-] (+) [-+]
  - the degree -> the distance between the point charge (+) and the atoms

`(1.10)`

$$E=\hat R \frac{q}{4πεR^2}\ (V/m)$$
(material with permittivity ε)

`(1.11)`

$$ε=ε_rε_0\ (F/m)$$
- εr: relative permittivity, or dielectric constant
  - relative to ε0, is dimensionless (just a constant)
  - εr = 1 for vacuum, εr = 1.0006 for air near Earth's surface

`(1.12)`
$$D=εE\ (C/m^2)$$

One of the two fundamental pairs of electromagnetic fields:
- D: electric flux density (C/m^2)
- E: electric field intensity (V/m)

> so wtf is flux? I'll be a bit upset if it's not elaborated in future chapters

## 1-3.3 Magnetic Fields
> Electric charges can be isolated, but magnetic poles always exist in pairs.

Pattern of magnetic field lines around a bar magnet:
```
      ↖  ↑  ↗
        ↖↑↗
   ←  ← +-+ → →
 ↙  ↙   |N|   ↘  ↘
↓  ↓    | |    ↓   ↓ B
 ↘  ↘   |S|   ↙  ↙
   →  → +-+ ← ←
        ↗↑↖
      ↗  ↑  ↖
    ↗    ↑    ↖
```

The magnetic field induced by a steady current flowing in the z direction:
```
    ↑z
    |↑I
    |
 ↙←←|←←↖Φ
↓   |-r--↑ B
 ↘→→|→→↗
    |_____y
   /|
  / ↺ B
 x  
```

`(1.13)`

Biot-Savart Law:

$$B=\hat Φ\frac{μ_0I}{2πr}\ (T)$$

Relating magnetic flux density B at a point in space to the current I in the conductor.
- r: radial distance from the current
- Φ: azimuthal unit vector
  - expressing magnetic-field direction is tangential to the circle surrounding the current.
- T: an unit, tesla
- μ0: magnetic permeability of free space
  - analogous to the electric permittivity ε0

**When an electric charge q is placed in...**:
- electric field E -> Fe=qE -> electric force.
- magnetic field B -> Fm -> **only if the charge is in motion** and its velocity u is in a direction anti-parallel to B -> magnetic force.

`(1.14)`
$$c=\frac{1}{\sqrt{μ_0ε_0}}=3×10^8\ (m/s)$$
- c: velocity of light in free space

`(1.15)`
$$μ=μ_rμ_0\ (H/m)$$

Magnetic permeability, accounts for magnetization properties of a material.
- μr: relative magnetic permeability
  - relative to vacuum, is dimensionless.
- nonmagnetic: its permeability = μ0. 

`(1.16)`
$$B=μH$$
- H: magnetic field intensity
- B: magnetic flux density

## 1-3.4 Static and Dynamic Fields

definition of time related adjectives:
- Static: describes a quantity that does not change with time.
- Dynamic: a quantity that varies with time.
- Waveform: plot of the magnitude profile of a quantity as a function of time.
- Periodic: its waveform repeats itself at a regular interval.
- Sinusoidal: aka ac, a quantity that varies sinusoidally with time.

### 1-3.4s The three branches of electromagnetics
> The relationship between E (electric field) and B (magnetic flux density) depends on whether I is static or dynamic. 

Branches: condition -> field quantities (units)
- Electrostatics: stationary charges (∂q/∂t = 0)
> electric field intensity E (V/m)
> electric flux density D (C/m^2)
> D=εE

- Magnetostatics: steady currents (∂I/∂t = 0)
> magnetic flux density B (T)
> magnetic field intensity H (A/m)
> B=μH

- Dynamics (time-varying fields): time-varying currents (∂I/∂t ≠ 0)
> E, D, B, and H
> (E,D) coupled to (B,H)

### 1-3.4s parameters mentioned 

Constitutive parameter of materials:
- electrical permittivity ε (F/m): ε0 = 8.854×10^-12 ≈ 1/36π ×10^-9
- magnetic permeability μ (H/m): μ0 = 4π×10^-7
- conductivity σ (S/m): 0

(Parameter (units): free-space value)

misc:
- if σ = 0 -> perfect dielectric
- if σ = ∞ -> perfect conductor
- if a medium is homogeneous -> its constitutive parameters are constant throughout the medium.

# 1-4 Traveling Waves
> Introduction to all the wonders about waves.

**Common properties of waves**:
- Moving waves carry energy.
- Waves have velocity
  - It takes time for a wave to travel from one point to another.
- Many waves exhibit a property called linearity
  - Waves that do not affect the passage of other waves -> linear -> linear superposition

**Two types of waves**:
- transient waves -> caused by sudden disturbances
- continuous periodic waves -> generated by a repetitive source

**Dimensions of waves**:
- One-dimensional wave: 
  - vertical displacement with time and location along the length of the string. (only up or down as magnitude of energy, and the 'x' location on the "time line")
  - it's one-dimensional because it only goes one way.
- Two-dimensional wave:
  - propagates out across a surface
  - it has two space variables, like ripple on a pond
  - circular waves.
- Three-dimensional wave:
  - propagates through a volume
  - three space variables, like explosion shock wave
  - plane waves, cylindrical waves, and spherical waves.

## 1-4.1 Sinusoidal Waves in a Lossless Medium
> lossless -> the medium does not attenuate the amplitude of the wave traveling within or on its surface.

A traveling wave can be described mathematically:

`!(1.17)`
$$y(x,t)=Acos(\frac{2πt}{T}-\frac{2πx}{λ}+ϕ_0)\ (m)$$

- y: the height
- x: the distance of wave travel
- A: amplitude of the wave
- T: time period
- λ: spatial wavelength
- ϕ0: reference phase

`(1.18)`
$$y(x,t)=A\ cos\ ϕ(x,t)\ (m)$$
where

`(1.19)`
$$ϕ(x,t)=(\frac{2πt}{T}-\frac{2πx}{λ}+ϕ_0)\ (rad)$$
the angle -> phase of the wave

---
First let's make it that ϕ0=0:

`(1.20)`
$$y(x,t)=A\ cos(\frac{2πt}{T}-\frac{2πx}{λ})\ (m)$$

We can analyze it from two perspectives:
- stop the time and sweep through the wave's length -> y(x,0)
- choose a location "on the wave"(e.g. the peak P) and follow it in time -> y(0,t)
  - we can measure the **phase velocity** of the wave

And we can plot it accordingly

`(1.21)`
$$ϕ(x,t)=\frac{2πt}{T}-\frac{2πx}{λ}=2nπ,\ n∊N$$
At the peaks of the wave pattern, the phase is equal to zero or multiples of 2π radians.

`(1.22)`
$$y(x,t)=y_0=A\ cos(\frac{2πt}{T}-\frac{2πx}{λ})$$

or

`(1.23)`
$$\frac{2πt}{T}-\frac{2πx}{λ}=cos^{-1}(\frac{y_0}{A})=constant.$$

`(1.24)`

The apparent velocity of the fixed height is obtained by taking the time derivative of (1.23).
$$\frac{2π}{T}-\frac{2π}{λ}\frac{dx}{dt}=0$$

`(1.25)`
$$u_p=\frac{dx}{dt}=\frac λT\ (m/s)$$
Phase velocity up
- up: aka propagation velocity, the velocity of the wave pattern.

---
> A whole lotta rewriting to simplify the equation

`(1.26)`
$$f=\frac 1T\ (Hz)$$

`(1.27)`
$$u_p=fλ (m/s)$$

`(1.28)`

rewriting (1.20) using (1.26)
$$y(x,t)=A\ cos(2πft-\frac{2π}{λ}x)$$
$$=A\ cos(ωt-βx)$$
**wave moving along +x direction**

`(1.29a)` `(1.29b)`

$$ω=2πf\ (rad/s)$$
$$β=\frac {2π}{λ}\ (rad/m)$$

- ω: angular velocity
- β: phase constant (or wavenumber)

`(1.30)`

In terms of the two quantities in (1.29).
$$u_p=fλ=\frac ωβ$$

`(1.31)`
$$y(x,t)=A\ cos(ωt+βx)$$
**wave moving along -x direction**

---

`(1.32)`

when the phase reference ϕ0 is not zero, rewriting (1.28)
$$y(x,t)=A\ cos(ωt-βx+ϕ_0)$$

