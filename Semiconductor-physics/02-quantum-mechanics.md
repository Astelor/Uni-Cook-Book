# chapter 2, introduction to quantum mechanics

> i usually avoid using too much indents and headers, but obsidian solves this problem so it doesn't become too chaotic
>
> which means the .obsidian folder should work

**table of content**
- [chapter 2, introduction to quantum mechanics](#chapter-2-introduction-to-quantum-mechanics)
- [2.1 principles of quantum mechanics](#21-principles-of-quantum-mechanics)
  - [2.1.1 energy quanta](#211-energy-quanta)
    - [definitions](#definitions)
    - [equations](#equations)
  - [2.1.2 wave-particle duality](#212-wave-particle-duality)
  - [2.1.3 uncertainty principle](#213-uncertainty-principle)
    - [explanation](#explanation)
- [2.2 Schrodinger's wave equation](#22-schrodingers-wave-equation)
  - [2.2.1 the wave equation](#221-the-wave-equation)
    - [math process...](#math-process)
  - [2.2.2 physical meaning of the wave function](#222-physical-meaning-of-the-wave-function)
  - [2.2.3 boundary conditions](#223-boundary-conditions)
- [2.3 applications of Schrodinger's wave equation](#23-applications-of-schrodingers-wave-equation)
  - [2.3.1 electron in free space](#231-electron-in-free-space)
    - [math process...](#math-process-1)
    - [boundary condition](#boundary-condition)
  - [2.3.2 the infinite potential well](#232-the-infinite-potential-well)
    - [math process...](#math-process-2)
    - [boundary conditions](#boundary-conditions)
  - [2.3.3 the step potential function](#233-the-step-potential-function)
- [glossary](#glossary)

# 2.1 principles of quantum mechanics

**three principles**:
1. the principle of energy quanta
2. the wave-particle duality principle
3. the uncertainty principle

## 2.1.1 energy quanta

- **photoelectric effect**
  - if *monochromatic light* (light with a fixed frequency) is incident (hit) on a clean surface of a material, when the incident light's frequency is larger than the *limiting frequency* *ν_0*, electrons (photoelectrons) are emitted from the surface.

### definitions

- `quanta`:
  - > Planck: thermal radiation is emitted from a heated surface in *discrete packets of energy* called `quanta`

- `photon`:
  - > Einstein: interpreted the *photoelectric effect* by suggesting the energy in a light wave is also contained in discrete packets called `photon`.
  - *photoelectric effect*:
    - a `photon` with *sufficient energy* can knock an electron from the surface of the material.
      - `photon` hit the material, the material spits out an `photoelectron`
    - the excess `photon` energy goes into the kinetic energy of the `photoelectron`

- `photoelectron`:
  - the electron emitted from the material

> Planck and Einstein are describing the same thing, but from different experiments.

### equations

- energy of `quanta`/`photon`
  - $E=h\nu$
  - *ν* (nu): frequency of the radiation
  - *h*: **Planck's constant** *h* = 6.625 × 10^-34 J-s
  - > energy of the photon is directly related to frequency of the light

- `work function` of the material:
  - $\Phi = h\nu_0$
  - minimum photon energy required to remove an electron from the material
  - *ν_0*: the limiting frequency

- maximum kinetic energy of the `photoelectron` 
  - $T_{\text{max}} = \frac{1}{2}m\nu^2 = hv-\Phi = h\nu-h\nu_0(\nu \ge \nu_0)$
  - *hν*: the incident photon energy
  - *Φ*: work function

## 2.1.2 wave-particle duality

- **Compton effect**:
  - x-ray beam is incident on a solid
    - a portion of the x-ray beam was deflected
    - the *frequency of the deflected wave* had *shifted* compared to the incident wave 
  - collision between an x-ray `quanta`/`photon` and an electron
    - both energy and momentum are conserved

- **wave-particle duality principle**:
  - > de Broglie: existence of matter waves. since waves exhibit particle-like behavior, particles should show wave-like properties
  - momentum of a photon:
    - $p=\frac{h}{\lambda}$
    - *λ*: wavelength of the light wave
  - wavelength of a particle:
    - $\lambda=\frac{h}{p}$
    - *p*: momentum of the particle
    - *λ*: **de Broglie wavelength** of the matter wave

- experiment by Davisson and Germer:
  - electrons from a heated filament were accelerated at normal incidence onto a single crystal of nickel
    - the scattered electron were measured as a function of angle
    - existence of a peak in the density of scattered electron
      - constructive interference of waves scattered by the periodic atoms in the plane of the nickel crystal
      - similar to an interference pattern produced by light diffracted from grating.
      - > the atoms in the nickel crystal form a "grating" 

## 2.1.3 uncertainty principle

- **Heisenberg uncertainty principle**
  - applies primarily to *very small particles*
  - we cannot describe with absolute accuracy the *behavior* of these subatomic particles

- statement: **it is impossible to simultaneously describe with absolute accuracy** the [*thing one*] and [*thing two*] of a particle
  - Δ[*thing*]: uncertainty in the [*thing*]

- first statement: `momentum` ↔ `position`
  - $\Delta{p} \,\Delta{x} \ge \bar{h}$
- second statement: `energy of a particle` ↔ `instant of time the particle has this energy`
  - $\Delta{E} \,\Delta{t} \ge \bar{h}$

- $\bar{h} = h/2\pi = 1.054 \times 10^{-34} \text{J-s}$
  - modified Planck's constant

### explanation

- the simultaneous measurements are in error to a certain extent
- $\bar{h}$ is very small, so the error only significant to subatomic particles
- **probability** function of describe the position and energy

# 2.2 Schrodinger's wave equation

- on the basis of wave-particle duality principle:
  - the motion of electrons in a crystal is described by wave theory
  - the wave theory is described by Schrodinger's wave equation

## 2.2.1 the wave equation

> the result here is the **time-independent schrodinger's wave equation**

- **one dimensional, nonrelativistic Schrodinger's wave equation**
  - $\frac{-\bar{h}}{2m} \cdot \frac{\partial^2 \Psi(x,t)}{\partial x^2} + V(x)\Psi(x,t) = j\bar{h}\cdot\frac{\partial^2 \Psi(x,t)}{\partial t}$
  - *Ψ(x, t)*: `wave function`
    - describe the behavior of the system
    - can be a complex quantity
  - *V(x)*: `potential function`
  - *m*: mass of the particle
  - *j*: imaginary constant

- `wave function`
  - $\Psi(x,t) = \psi(x)\phi(t)$
  - *ψ(x)*: function of x only
  - *φ(t)*: function of t only

### math process...

> using *separation of variables* (separating *x* and *t*) with the `wave function`

- substitute the `wave function` back into the Schrodinger's wave equation
  - $\frac{-\bar{h}}{2m} \cdot \phi(t) \cdot \frac{\partial^2 \psi(x)}{\partial x^2} + V(x)\psi(x)\phi(t) = j\bar{h} \psi(x)\frac{\partial^2 \phi(t)}{\partial t}$
- divide by the `wave function`
  - $\frac{-\bar{h}}{2m} \cdot \frac{1}{\psi(x)} \cdot \frac{\partial^2 \psi(x)}{\partial x^2} + V(x) = j\bar{h}\cdot\frac{1}{\phi(t)}\cdot\frac{\partial^2 \phi(t)}{\partial t} = \eta$
  - *left side* is a function of *x* only
  - *right side* is a function of *t* only
  - *η* (eta): separation constant = the total energy of the particle *E*

---
- time-dependent portion (right side)
  - $j\bar{h}\cdot\frac{1}{\phi(t)}\cdot\frac{\partial^2 \phi(t)}{\partial t} = \eta$
- **solution of the time-dependent portion**
  - $\phi(t) = e^{-j(\eta/\bar{h})t} = e^{-j(E/\bar{h})t} = e^{-j\omega t}$
  - classical exponential form of a sinusoidal wave
  - relation for *E h ν ω η*
    - *η* = *E*
    - *E* = *hν* = *hω/2π*
    - *ω* = *η/h_bar* = *E/h_bar*
      - radian/ angular frequency of the sinusoidal wave
---

- position-dependent portion (left side)
  - $\frac{-\bar{h}}{2m} \cdot \frac{1}{\psi(x)} \cdot \frac{\partial^2 \psi(x)}{\partial x^2} + V(x) = E$
- **time-independent Schrodinger's wave equation**
  - $\frac{\partial^2 \psi(x)}{\partial x^2} + \frac{2m}{\bar{h}^2}(E-V(x))\cdot \psi(x) = 0$
  - *m*: mass of the particle
  - *V(x)*: potential experienced by the particle
  - *E*: total energy of the particle

## 2.2.2 physical meaning of the wave function

> getting `probability density function` from the `wave function`

- total `wave function`:
  - $\Psi(x,t)=\psi(x)\phi(t) = \psi(x) e^{-j(E/\bar{h})t} = \psi(x) e^{-j\omega t}$
  - a complex function → cannot by itself represent a real physical quantity 
- *probability of finding the particle* between x and x+dx at a given time
  - $|\Psi(x,t)|^2 dx$
- **probability density function** (PDF)
  - $|\Psi(x,t)|^2 = \Psi(x,t) \cdot \Psi^*(x,t)$
  - > it's just the definition of probability density function
  - math process...
    - $\Psi^*(x,t) = \psi^*(x) \cdot e^{+j\omega t}$: complex conjugate
    - $|\Psi(x,t)|^2 = \Psi(x,t) \cdot \Psi^*(x,t) = [\psi(x) \cdot e^{-j\omega t}][\psi^*(x) \cdot e^{+j\omega t}]$
  - $|\Psi(x,t)|^2 = \psi(x)\psi^*(x) = |\psi(x)|^2$
    - `PDF` is independent of time

##  2.2.3 boundary conditions

- the probability of finding the particle somewhere is certain
   - $\int^{\infty}_{-\infty}{|\psi(x)|^2 dx} = 1$
   - allow us to normalize the `wave function`
- the total energy *E* and the potential *V(x)* are finite everywhere
  1. *ψ(x)* must be finite, single-valued, and continuous
     - if the probability density become *infinite* at some point in space, the probability of finding the particle at this position would be *certain* = `uncertainty principle` violated
  2. *∂ψ(x)/∂x* must be finite, single-valued, and continuous
     - from **time-independent Schrodinger's wave equation**
       - $\frac{\partial^2\psi(x)}{\partial x^2}+\frac{2m}{\bar{h}^2}(E-V(x))\psi(x) = 0$
       - the *second derivative is finite*
     - the *first derivative* is finite and continuous 

> astelor: the remaining text here are confusing to me ehh

# 2.3 applications of Schrodinger's wave equation

- the following sections in short:
  1. free electron
  2. bound electron
  3. electron hitting a wall
  4. electron goes through the wall

## 2.3.1 electron in free space

- **free particle**
- *no force* acting on the particle
  - potential function *V(x)* will be constant
  - **E > V(x)**
- assuming $V(x) = 0, \forall x$

### math process...

> time-independent wave equation, and the *total wave function* that has *t* innit

- **time-independent wave equation**
  - $\frac{\partial^2\psi(x)}{\partial x^2}+\frac{2mE}{\bar h^2}\psi(x)=0$
- **solution** for the *time-independent wave equation*
  - $\psi(x) = A\exp(jkx) + B\exp(-jkx)$
  - *wave number*: $k = \sqrt{\frac{2mE}{\bar h^2}}$
- **total wave function solution**
  - $\Psi(x,t) = A\exp(j(kx-\omega t) + B\exp(-j(kx+\omega t))$
    - recall that $\phi(t) = \exp(-j\omega t)$
  - **free particle** is represented by a **traveling wave**
  - *first term*: wave traveling in +x direction
  - *second term*: wave traveling in -x direction
  - the value of coefficient A and B is determined by the *boundary condition* (BC)

### boundary condition

> solving for the total wave function solution *Ψ(x)*
> 
> the results here are *PDF* and *wave solution*

- assuming the particle is *traveling in +x direction*
  - coefficient *B = 0* 
- **traveling-wave solution**
  - $\Psi(x,t)=A\exp(j(kx-\omega t))$
  - *wave number*: $k=\sqrt{\frac{2mE}{\bar{h}^2}}=\sqrt{\frac{p^2}{\bar{h}^2}}=\frac{p}{\bar{h}}$
- `wavelength` written in terms of the `wave number`
  - $\lambda = \frac{2\pi}{k}$
  - or $k=\frac{2\pi}{\lambda}$
  - recall: de Broglie wavelength: $\lambda = \frac{h}{p} = \frac{2\pi \bar{h}}{p}$
- a free particle with a *well-defined energy* will also have a *well-defined wavelength* and *momentum*
- **probability density function**
  - $\Psi(x,t)\Psi^*(x,t)=AA^*$
  - is a **constant** and **independent of position** (equal probability anywhere)
    - > a free particle with a *well-defined momentum* can be found anywhere with equal probability (*AA^\**)

> astelor: what the heck is a well-defined stuff??

## 2.3.2 the infinite potential well

- **bound particle**
- potential *V(x)*:
  - infinite in *region I & III*
  - zero in *region II*
- the particle is assumed to exist in *region II*
  - between x=0 & x=a

### math process... 

> getting time-independent wave functions in *region I & III* and *region II*

- **time-independent wave function** in *region I & III*
  - $\frac{\partial^2\psi(x)}{\partial x^2}+\frac{2m}{\bar{h}^2}(E-V(x))\psi(x)=0$
  - if *E* is finite, *ψ(x)=0* in both *region I & III*
    - the particle cannot penetrate infinite potential barriers
    - probability of finding the particle here is zero
- **time-independent wave function** in *region II*
  - $\frac{\partial^2\psi(x)}{\partial x^2}+\frac{2mE}{\bar{h}^2}\psi(x)=0$
  - *particular solution*: $\psi(x)=A_1\cos(kx)+A_2\sin(kx)$
  - *wave number*: $k=\sqrt{\frac{2mE}{\bar{h}^2}}$

### boundary conditions

> solving for *ψ(x)* in *region II* for the *coefficient A_1 and A_2* with boundary conditions.
>
> the result here is the *quantized total energy* 

- *ψ(x)* must be continuous:
  - $\psi(x=0)=\psi(x=a)=0$
    - $A_1=0$ when *x=0*
    - > from the wave function result in *region I & III*, you got *ψ(x)=0*, continuous at the boundary means *ψ(0)=0* & *ψ(a)=0*. okay?
  - $\psi(x=a)=0=A_2\sin ka$
    - equation is *valid* if **$ka=n\pi$**
      - *n*: a positive integer
    - > $A_2$ is found using the normalization boundary condition
- normalization boundary condition
  - $\int^{a}_{0}A^2_2\sin^2kx\,dx=1$
  - $A_2=\sqrt{\frac{2}{a}}$
- **time-independent wave solution**
  - $\psi(x)=\sqrt{\frac{2}{a}}\sin(\frac{n\pi x}{a})$
  - **bound particle** is represented by a **standing wave**
  - $\psi(x)=\sqrt{\frac{2}{a}}\sin(k_n x)$

---
- expressions for *k*
  - $k^2\to k_n^2=\frac{2mE_n}{\bar{h}^2}=\frac{n^2\pi^2}{a^2}$
- **total energy**
  - $E=E_n=\frac{\bar{h}^2n^2\pi^2}{2ma^2}, n\in\mathbb{N}$
  - **energy of the particle is quantized**
  - > as the energy increases, the probability of finding the particle become more uniform

## 2.3.3 the step potential function


# glossary

- PDF: probability density function
- BC: boundary condition

---
> I probably need a equation area here
> EHHHHHHH
---