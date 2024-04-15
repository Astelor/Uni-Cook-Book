# Fuck it we ball

> All things I should write down but too lazy to find where it belongs.
>
> Chapter and section designations will be noted to make future organizing easier.

# Chapter 1,  Introduction

## TB1 LED

> Exciting a pn junction (diode) with voltage, the **recombination** of electrons and holes generates **photons**, which is light.

## TB2 Solar Cells

What is a solar cell?
- A photovoltaic device
- Converts solar energy into electricity

What are the relevant effects?
- Photoelectric effect

(光電效應)

> "Emission of electrons from a material caused by photon."
>
> TL;DR, photons hit the material, the material ejects electrons 

- Photovoltaic effect

(光伏效應)

> "Generation of voltage and electric current in a material upon exposure to light."
>
> TL;DR, photons hit into the n-type semiconductor, giving electrons energy to move.

---

**PV Cells** (photovoltaic cells)

Factors of conversion efficiency:

- Incident light: 
  - light absorbed (good)
  - light reflected (bad)

> Solution to reflected light:
>
> Insert antireflective coating between upper glass layer and n-type semiconductor layer.

- Band gap energy:
  - Material parameter.
  - Only a fraction of solar energy spectrum will be absorbed.
  - → weaker spectrum cannot be absorbed

> Solution to not absorbing weaker spectrum:
>
> Multijunction PV device.
>
> - Top cell: highest band gap energy
> - Subsequent cells: second highest

---
Comparison:

- Solar cells: 
  - light → electricity
- LED (light emitting diodes): 
  - electricity → light

# Chapter 2, Transmission Lines

- Transverse electromagnetic (TEM) transmission lines:
  - Electric field and magnetic field
  - Neither has a component along the line axis
- Higher-order transmission lines
  - At least one significant field component in the direction of propagation.

> Only TEM-mode is discussed here
> - more commonly used in practice
> - less mathematical rigor required

## 2-2 Lumped-Element Model

> TEM mode → lumped-element model

Huh?

- two parallel lines z
  - two conductors in a transmission line
- subdividing z into Δz
  - into differentiable sections

Transmission line parameters:

- R': combined resistance
- L': combined inductance
- G': conductance of the insulation medium
- C': capacitance of the two conductors

$$R'=\frac {R_s} {2\pi} (\frac 1a + \frac 1b)$$

$$R_s= \sqrt{\frac{\pi f \mu_c}{σ_c}}$$

$$L'=\frac {\mu}{2 \pi} \ln(\frac ba)$$

$$G'=\frac {2 \pi σ}{\ln(b/a)}$$

$$C'=\frac {2 \pi ε}{\ln(b/a)}$$

---

`(2.14)`



`(2.18a)`

$$-\frac {d \tilde{V}(z)}{dz}=(R'+jωL')\tilde{I}(z)$$

`(2.18b)`