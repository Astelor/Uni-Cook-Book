# chapter 6, capacitors and inductors


# 6.1 introduction

- what are capacitor & inductors:
  - passive linear circuit element
  - store energy → storage elements

# 6.2 capacitors

- **physical form**
  - a capacitor consists of two conducting plates separated by an insulator (or dielectric)
    - the plates: aluminum foil
    - dielectric: air, ceramic, paper, mica
- **elaboration**
  - voltage source *v* connected to the capacitor
  - the source deposits a positive charge *q* or on plate, and a negative charge *-q* on the other
  - the capacitor is said to store the *electric charge*
    - or storing energy via *electric field*
- **characteristic**
  - $q=Cv$
  - C: the *constant* of proportionality aka *capacitance*
    - unit: farad (F)
    - 1 farad = 1 coulomb/volt
  - $C=\frac{\epsilon A}{d}$
    - does not depend on *q* or *v*
    - depends on *physical dimensions* of the capacitor (thus a constant)
  - A: *surface area* of the plates
  - d: *spacing* between the plates
  - $\epsilon$: permittivity of the material

```
      +--------------+
      |(metal plate) |
============== +q    |
 [dielectric]        | +
============== -q   [v]
      |              | -
      +--------------+
```

- **current-voltage relationship** of the capacitor
  - $i=C\frac{dv}{dt}$
    - $q=Cv \to \frac{dq}{dt}= C\frac{dv}{dt}$
    - and $i=\frac{dq}{dt}$
  - capacitors that satisfy such relationship is said to be *linear*
- **voltage-current relationship** of the capacitor
  - $v(t) = \frac{1}{C}\int_{-\infty}^{t}{i(t)dt}$
    - from a very very long time ago to now (t)
  - or $v=\frac{1}{C}\int_{t_0}^{t}{i\,dt}+v(t_0)$
    - from a certain time (t_0) to another certain time (t)
- **instantaneous power** delivered to the capacitor
  - $p=vi=Cv\frac{dv}{dt}$
    - unit: Joule/time
- **energy stored** in the capacitor
  - $w=\frac{1}{2}Cv^2=\frac{q^2}{2C}$
    - unit: Joule
    - represents the *energy stored in the electric field* that exists between the plates of the capacitor
    - from $w=\int_{-\infty}^{t}{p\,dt}=C\int_{-\infty}^{t}{v\frac{dv}{dt}\,dt}=C\int_{-\infty}^{t}{v\,dv}=\frac{1}{2}Cv^2|_{t=-\infty}^{t}$

- **important properties** of a capacitor
  1. a capacitor is an *open circuit to dc* 
     - when the voltage across a capacitor is not changing with time (dc voltage), the *current through the capacitor is zero*
  2. *voltage* on a capacitor *cannot change abruptly*
     - according to $i=C\frac{dv}{dt}$ if voltage were to change abruptly
       - $\frac{dv}{dt} \approx \infty \to i \approx \infty$ and is impossible to have infinite current
     - current through a capacitor can change instantaneously
  3. the *ideal capacitor* does not dissipate energy (heat)
  4. a *real non-ideal capacitor* has a *parallel-model leakage resistance*
     - the resistance dissipates energy

# 6.3 series and parallel capacitors

> why is this a stand-alone section?

- **equivalent capacitance**
  - N-parallel-connected capacitor
    - $C_{\text{eq}}=C_1+C_2+\dots+C_N$
  - N-series connected capacitor
    - $\frac{1}{C_{\text{eq}}}= \frac{1}{C_1}+\frac{1}{C_2}+\dots+\frac{1}{C_N}$

