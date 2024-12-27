# chapter 4, the semiconductor in equilibrium

- **thermal equilibrium**:
  - no external forces are acting on the semiconductor
    - such as voltages, electric fields, magnetic fields, temperature gradients

# 4.1 charge carriers in semiconductors

## 4.1.1 equilibrium distribution

- **distribution** (with respect to energy) of *electrons*/*holes* in the *conduction*/*valence* band
  - $n(E)=g_c(E)f_F(E)$
  - $p(E)=g_v(E)[1-f_F(E)]$
  - g(E): density of quantum states
    - the density of allowed energy states
  - $f_F(E)$: Fermi-Dirac probability (distribution) function
    - total number of ways of arranging N_i particles in ith energy level (N_i ≤ g_i)

## 4.1.2 the n_0 and p_0

- **thermal-equilibrium** *electron*/*hole* **concentration** in the *conduction*/*valence* band
  - $n_0=\int{g_c(E)f_F(E)dE}=N_c\,\exp[\frac{-(E_c-E_F)}{kT}]$
  - $p_0=\int{g_v(E)[1-f_F(E)dE]}=N_v\,\exp[\frac{-(E_F-E_v)}{kT}]$
- **effective density of states function** in the *conduction*/*valence* band
  - $N_c = 2(\frac{2\pi m_n^* kT}{h^2})^{3/2}$
  - $N_v = 2(\frac{2\pi m_p^* kT}{h^2})^{3/2}$
  - > are *constant* for a *given semiconductor material* at a *fixed temperature*
  - $m_n^*$: density of states effective mass of the electron
  - $m_p^*$: density of states effective mass of the hole

## 4.1.3 the intrinsic carrier concentration

- $n_i = p_i$: **intrinsic electron/hole concentration** 
  - electron/hole concentration in the intrinsic semiconductor
- $E_F = E_{F_i}$: **intrinsic Fermi energy**
  - Fermi energy level for the intrinsic semiconductor
- $n_i$: **intrinsic carrier concentration**
  - $n_0 = n_i = N_c\,\exp[\frac{-(E_c-E_{F_i})}{kT}]$
  - $p_0 = p_i = n_i = N_v\,\exp[\frac{-(E_{F_i}-E_v)}{kT}]$
  - $n_i^2 = N_c N_v\,\exp[\frac{-(E_c-E_v)}{kT}] = N_cN_v\,\exp[\frac{-E_g}{kT}]$
  - $E_g$: bandgap energy
  - > for a given semiconductor material at a *constant temperature*, the value of n_i is *a constant*, and *independent of the Fermi energy*

## 4.1.4 the intrinsic Fermi-level position

- electron and hole concentrations are equal
- ---> able to calculate intrinsic Fermi-level position
- **math**
  - $N_c\,\exp[\frac{-(E_c-E_{F_i})}{kT}] = N_v\,\exp[\frac{-(E_{F_i}-E_v)}{kT}]$
  - $E_{F_i} = \frac{1}{2}(E_c+E_v)+\frac{1}{2}kT\ln(\frac{N_v}{N_c})$
  - $E_{F_i} = \frac{1}{2}(E_c+E_v)+\frac{3}{4}kT\ln(\frac{m_p^*}{m_n^*})$
  - $\frac{1}{2}(E_c+E_v) = E_{midgap}$
  - $E_{F_i}-E_{midgap} = \frac{3}{4}kT\ln(\frac{m_p^*}{m_n^*})$

# 4.2 dopant atoms and energy levels

- doped semiconductor -> **extrinsic** material
  - adding controlled amounts of *dopant atoms*

- **donor** impurity atom
  - **n-type** semiconductor
  - group V element (P, phosphorus)
  - 5 valence electrons
    - 4 -> covalent bonding
    - 1 -> loosely bound to the P atom
      - the **donor electron**
      - require less energy to elevate into *conduction* band
  - *adding electrons* to the conduction band *without creating holes* in the valence band

- **acceptor** impurity atom
  - **p-type** semiconductor
  - group III element (B, boron)
  - 3 valence electrons
    - 3 -> covalent bonding
    - (1) -> **acceptor atom's hole**
      - pulls an electron from Si atom
      - the electron's energy here far smaller than conduction band energy
  - *generates holes* in the valence band *without generating electrons* in the conduction band


# hack

- with a given $N_c$ at a certain temperature calculate the *new* $N_c'$ of different temperature. from [4.1.2](#412-the-n_0-and-p_0)
  - $N_c' = N_C \cdot(\frac{T}{T'})^{3/2}$

# glossary