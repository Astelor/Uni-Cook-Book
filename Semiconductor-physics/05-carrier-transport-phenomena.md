# chapter 5, carrier transport phenomena

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
  - ---> lost most or all of its energy
  - ---> particle gaining an *average drift velocity*
    - is directly proportional to electric field for *low electric fields*

## 5.1.2 mobility effects

- 
- $F = m_{cp}^*\frac{dv}{dt} = e\text{E}$
- $v$: velocity of the particle due to the electric field
  - does not include the random thermal velocity
- $\int{dv} = \frac{e\text{E}}{m_{cp}^*}\int{dt}$
- $v = \frac{e\text{E}t}{m_{cp}^*}$
  - assuming the initial drift velocity is zero
- $\tau_{cp}$: mean time between collisions

### photon or lattice scattering

- thermal energy at temperature above absolute zero
- lattice atoms randomly vibrate about
- ---> disruption in the perfect periodic potential function
- ---> interaction between the electrons or holes and the vibrating lattice atoms
- $\mu_L$: mobility observed if only lattice scattering existed
  - $\mu_L \propto T^{-3/2}$
  - mobility increase as the temperature decrease

### ionized impurity scattering
