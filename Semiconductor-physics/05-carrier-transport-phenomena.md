# chapter 5, carrier transport phenomena

# 5.1 carrier drift

- **electric field** applied to a semiconductor
  - force on electrons & holes
  - net acceleration & net movement
  - when there are available energy states in the conduction & valence band
  - net drift of charge ---> **drift current**

## 5.1.1 drift current density

- **drift current density** (definition)
  - $J_{drf} = \rho v_d$
  - $\rho$: positive volume charge density
  - $v_d$: average drift velocity
  - > a volume of charges moving at a certain speed is current
  - units: $J_{drf} = (\frac{Coul}{cm^3})\cdot(\frac{cm}{s}) = \frac{Coul}{cm^2 \cdot s} = \frac{A}{cm^2}$

- *drift current density* **due to holes**
  - $J_{p|drf} = \rho v_{dp} = (ep) v_{dp} = e\mu_p p \text{E}$
  - $v_{dp}$: *average drift velocity* of the **holes**
- *drift current density* **due to electrons**
  - $J_{n|drf} = \rho v_{dn} = (-en)v_{dn} = (-en)(-\mu_n\text{E}) = e\mu_n n\text{E}$
    - net charge density of electron is negative
  - $v_{dn}$: *average drift velocity* of **electrons**

- **average drift velocity**
  - $v_{dp} = \mu_p\text{E}$
  - $v_{dn} = -\mu_n\text{E}$
    - electron is negatively charged, the *net motion of electron* is *opposite* to the *electric field direction*
  - $\mu_p$: hole mobility (cm^2/V-s)
  - $\mu_n$: electron mobility (cm^2/V-s)
    - function of temperature & doping concentration

- **total drift current density**
  - $J_{drf} = e(\mu_n n+\mu_p p)\text{E} = J_{n|drf}+J_{p|drf}$

---

- **motion** of a *positively charged hole* in *electric field*
  - $F = m_{cp}^* a = e\text{E}$
  - $e$: magnitude of the electronic charge
  - $a$: acceleration
  - $\text{E}$: electric field
  - $m_{cp}^*$: *conductivity* effective mass of the *hole*

- **scattering events** aka collisions
  - charged particle collides with an atom
    - lost most or all of its energy
  - particle gaining an *average drift velocity*
      - is directly proportional to electric field for *low electric fields*

## 5.1.2 mobility effects

- **math**, deriving from the motion equation:
  - $F = m_{cp}^*\frac{dv}{dt} = e\text{E}$
  - $v$: velocity of the particle due to the electric field
    - does not include the *random thermal velocity*
  - $\int{dv} = \frac{e\text{E}}{m_{cp}^*}\int{dt}$
  - $v = \frac{e\text{E}t}{m_{cp}^*}$
    - assuming the initial drift velocity is zero
  - $\tau_{cp}$: mean time between collisions

- when a small **electric field** is applied (E-field)
  - net drift of the hole in the direction of the E-field
  - net *drift velocity* will be a small perturbation on the *random thermal velocity*
    - so the time between collisions will not be altered appreciably

- **mean peak velocity** just prior to a collision or scattering event
  - $v_{d|peak}=(\frac{e\tau_{cp}}{m_{cp}^*})\text{E}$
- **average drift velocity** is one half of the peak value
  - $\langle v_d\rangle = \frac 12(\frac{e\tau_{cp}}{m_{cp}^*})\text{E}$
  - > the collision process is *not as simple* as this model, but is *statistical in nature*. 
    > 
    > in a *more accurate model* including the *effect of a statistical distribution*, the factor 1/2 does not appear
- **hole/electron mobility**
  - $\mu_p = \frac{v_{dp}}{\text E} = \frac{e\tau_{cp}}{m_{cp}^*}$
  - $\mu_n = \frac{v_{dn}}{\text E} = \frac{e\tau_{cn}}{m_{cn}^*}$

### phonon or lattice scattering

> not photon, **phonon**
>
> in short, the atoms in the crystal lattice above 0K vibrates and collides with the passing carriers

- **thermal energy** at temperature above absolute zero
- lattice atoms **randomly vibrate** about
  - disruption in the perfect periodic potential function
  -  interaction between the electrons or holes and the vibrating lattice atoms
- **$\mu_L$**: **mobility** that would be observed if *only lattice scattering existed*
  - $\mu_L \propto T^{-3/2}$
  - **mobility increase as the temperature decrease**

### ionized impurity scattering

> the ionized impurities (doped semiconductor) above 0K 

- impurities are **ionized at room temperature**
- **coulomb interaction** exist between the electron/holes and the *ionized impurities*
  - produces scattering or collisions
  - **alters the velocity characteristics** of the *charge carrier*
- **$\mu_l$**: **mobility** that would be observed if *only ionized impurity scattering existed*
  - $\mu_l \propto \frac{T^{+3/2}}{N_l}$
  - $N_l = N_d^++N_a^-$: **total ionized impurity concentration** of the semiconductor
- **temperature increases** 
  - -> *random thermal velocity* of a carrier *increases*
  - -> *reducing the time* the carrier spends in the *vicinity* of the *ionized impurity centers*
  - -> **expected value of $\mu_l$ increase**, the scattering effect decrease
- **impurity concentration ($N_l$) increases**
  - number of *ionized impurity center* increases
    - -> probability of a *carrier* encountering an *ionized impurity center* increases
      - **smaller $\mu_l$**

### total probability of a scattering event

- $\tau_L$: mean time between collisions due to lattice scattering
  - $dt/d\tau_L$: probability of a lattice scattering event occurring in a differential time $dt$
- $\tau_l$: mean time between collisions due to ionized impurity scattering
  - $dt/d\tau_l$: probability of a ionized impurity scattering event occurring in a differential time $dt$
- **total probability of a scattering event**
  - $\frac{dt}{\tau} =\frac{dt}{\tau_L} + \frac{dt}{\tau_l}$ 
  - if the two scattering processes are independent
  - $\tau$: mean time between any scattering event
  - $\frac{1}{\mu} = \frac{1}{\mu_L} + \frac{1}{\mu_l}$
  - $\mu$: net mobility
