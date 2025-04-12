# chapter 6, non-equilibrium excess carriers in semiconductors

> oh well I need to remind myself every now and then there's actual stuff to study, not just the damn cryptography stuff. 
> at least the textbook I can understand, the papers on the other hand looks like literal ciphertexts to me

- excess carriers
  - occurs when an *external excitation* is applied to the semiconductor
- [**ambipolar transport**](#63-ambipolar-transport)
  - the excess electrons and holes do not move independently of each other

# 6.1 carrier generation and recombination

- **generation**
  - the process whereby electrons and holes are *created*
- **recombination**
  - the process whereby electrons and holes are *annihilated*

- example of **non-equilibrium condition**, *changing the carrier concentrations*
  - any deviation from thermal equilibrium
    - a sudden increase in temperature
  - an external excitation, such as light (a flux of photons)
- **direct band-to-band** generation and recombination
  - 1 free electron created = 1 hole created

## 6.1.1 the semiconductor in equilibrium

> tl;dr. 
> no external force = semiconductor in thermal equilibrium, in "dynamic equilibrium," and is **perfectly balanced**

- **thermal-generation rates**
  - $G_{n0}$, $G_{p0}$ for electrons and holes
  - units: $\#/cm^3-s$
  - for *direct band-to-band*: $G_{n0}=G_{p0}$
- **recombination rates** for a semiconductor in **thermal equilibrium**
  - $R_{n0}$, $R_{p0}$ for electrons and holes
  - units: $\#/cm^3-s$
  - for *direct band-to-band*: $R_{n0}=R_{p0}$
- **in thermal equilibrium**
  - the concentrations of electrons and holes are *independent of time*
  - $G_{n0}=G_{p0}=R_{n0}=R_{p0}$
  
## 6.1.2 excess carrier generation and recombination

> tl;dr. 
> yes external force = semiconductor having excess electrons and holes and in **non-equilibrium**

- the **excess carriers** are *generated* by an **external force** *at a particular rate*
    - perturbing the equilibrium condition
    - → semiconductor no longer in thermal equilibrium
    - **steady-state generation** of excess carriers will *not* cause a *continual buildup of the carrier concentrations*
      - electrons recombine with holes in pairs
        - electrons fall down to valence band and combine with holes 
- **generation rate** of **excess** electrons and holes
  - $g_n'$, $g_p'$
    - units: $\#/cm^3-s$
  - $g_n'=g_p'$ for *direct band-to-band*
    - the excess electrons and holes are created in pairs
- **electron and hole concentration** when **excess** carriers are created
  - $n=n_0+\delta n$
  - $p=p_0+\delta p$
  - $n_0$, $p_0$: thermal equilibrium concentrations
  - in such non-equilibrium condition: $np\ne n_0 p_0=n_i^2$
- **recombination rate** of **excess** electrons and holes
  - $R_n'$, $R_p'$
    - units: $\#/cm^3-s$
  - $R_n' = R_p'$ for *direct band-to-band*

### 6.1.2.a math process of getting "carrier regeneration rate"

> reminder: regeneration rate = recombination rate, for direct band-to-band ([6.1.2](#612-excess-carrier-generation-and-recombination))

- **net rate of change in the electron concentration** (given)
  - $\frac{dn(t)}{dt} = \alpha_r[n_i^2 - n(t)p(t)]$ 
    - $\alpha_r n_i^2$: thermal-equilibrium generation rate
    - $n(t) = n_0 + \delta n(t)$
    - $p(t) = p_0 + \delta p(t)$
    - **$\delta n(t) = \delta p(t)$**: excess electrons and holes are *created and recombined in pairs*
    - > it's *equilibrium* $n_i^2=n_0p_0$ minus *non-equilibrium* $n(t)p(t)$ 
- **$\delta n(t) = \delta p(t)$**, substitute $n(t)$ as $n_0+\delta n(t)$
  - $\begin{align*} \frac{d(\delta n(t))}{dt} &= \alpha_r [n_i^2 -(n_0+\delta n(t))(p_0+\delta p(t))] \\&= -\alpha_r \delta n(t)[(n_0+p_0)+\delta n(t)] \end{align*}$
    - $n_0, p_0$ is independent of time
      - $n_0p_0=n_i^2$
    - can be solved under *low-level injection*
- considering **p-type** material, impose **low-level injection**
  - $\frac{d(\delta n(t))}{dt} = -\alpha_r p_0 \delta n(t)$
    - $p_0 \gg n_0$: *p-type* material 
    - $p_0 \gg \delta n(t)$: under *low-level injection*
      - $n_0, \delta n(t)$ terms are negligible, according to the limitations
- → solving the simplified equation
  - $\delta n(t) = \delta n(0)e^{-\alpha p_0 t} = \delta n(0)e^{-t/\tau_{n0}}$
    - *exponential decay* from the initial excess concentration
    - **$\tau_{n0} = (\alpha_r p_0)^{-1}$**: a constant for the low-level injection
      - aka **excess minority carrier lifetime**
      - > it's essentially a time constant
- → **recombination rate** of *excess minority carrier* of **electrons**
  - $R_n' = \frac{-d(\delta n(t))}{dt} =+ \alpha_r p_0 \delta n(t) = \frac{\delta n(t)}{\tau_{n0}}$
    - is defined as a positive quantity

- for direct band-to-band recombination, ***excess majority carrier* recombine at the same rate**
  - for **p-type** material
    - **$R_n' = R_p' = \frac{\delta n(t)}{\tau_{n0}}$**
  - for **n-type** material
    - **$R_n' = R_p' = \frac{\delta n(t)}{\tau_{p0}}$**
---
- considering **n-type** material, impose *low-level injection*
  - $n_0 \gg p_0$: *n-type* material
  - $n_0 \gg \delta n(t)$: under *low-level injection*
  - **$\tau_{p0} = (\alpha_r n_0)^{-1}$**: time constant
    - aka **excess minority carrier lifetime**

- **generation** & **recombination** rates may be functions of the *space coordinates* and *time*

### 6.1.2.b low and high level injection

> tl;dr. 
> the minority carrier << the majority carrier in low level injection. 
> the minority carrier ~= the majority carrier in high level injection. 

- **low-level injection**
  - puts *limits* on the *magnitude* of the *excess carrier concentration* compared with the *thermal-equilibrium carrier concentrations*
  - **n-type** extrinsic material
    - $n_0 \gg p_0$
    - $n_0 \gg \delta p(t)$
  - **p-type** extrinsic material
    - $p_0 \gg n_0$
    - $p_0 \gg \delta n(t)$
- **high-level injection**
  - occurs when the *excess carrier concentration* becomes *comparable* to or greater than the *thermal-equilibrium majority carrier concentrations*
  - > not common to occur


# 6.2 characteristics of excess carriers

- **ambipolar transport**
  - excess electrons and holes *do not move independently of each other*
  - they *diffuse* and *drift* with the same *effective diffusion coefficient* and *effective mobility*
- **result**
  - for an *extrinsic semiconductor* under *low injection*
  - the *effective diffusion coefficient* and *mobility* parameters are those of the *minority carrier*

## 6.2.1 continuity equations

- **differential volume element** (figure 6.4)
  - where a one-dimensional *hole-particle flux*
    - → *entering* the differential element at *x*
    - → *leaving* the differential element at *x+dx*
- → for the *x component* of the *particle current density* shown
  - $F_{px}^{+}(x+dx) = F_{px}^{+}(x) \frac{\partial F_{px}^+}{\partial x}\cdot dx$
    - **$F_{px}^+$**: **hole-particle flux/flow**
      - units: number of holes/cm^2-s
    - *Taylor expansion* of $F_{px}^+ (x+dx)$
      - the *differential length* *dx* is small
      - only the *first two terms* in the expansion are significant

![F-6.4](attachments/F-6.4.png)

### 6.2.1.a math process of getting "continuity equation"

> tl;dr. 2 equations, one from particle flux in the differential volume, one from combining the factors accounting the generation/annihilation of holes. both are given

- the **net increase** in the *number of holes per unit time* within the *differential volume element* **due to the *x-component of hole flux*** (given)
  - **$\frac{\partial p}{\partial t} dx\,dy\,dz = [F_{px}^+ (x) - F_{px}^+ (x+dx)]dy\,dz = -\frac{\partial F_{px}^+}{\partial x}dx\,dy\,dz$**
  - if $F_{px}^+ > F_{px}^+ (x+dx)$
    - there wil be a *net increase* in the number of holes in the *differential volume element* *with time*
  - > - if we generalize to a *three-dimensional hole flux*, the right side of the equation may be written as $\nabla\cdot F_{px}^+ dx\,dy\,dz$
    > - $\nabla\cdot F_{p}^+$: divergence of flux vector
    > - we will limit ourselves to one-dimensional analysis
- the *generation rate* & *recombination rate of holes* will also affect the *hole concentration* in the *differential volume*
- the **net increase** in the *number of holes per unit time* in the *differential volume element* (given)
  - **$\frac{\partial p}{\partial t} dx\,dy\,dz = -\frac{\partial F_p^+}{\partial x} dx\,dy\,dz + g_p dx\,dy\,dz - \frac{p}{\tau_{pt}}dx\,dy\,dz$**
    - $p$: number of holes
    - $\frac{p}{\tau_{pt}}$: recombination rate for holes. ([regen rate and recom rate](#612a-math-derivation-of-carrier-regeneration-rate))
    - **$\tau_{pt}$**: *thermal-equilibrium carrier lifetime* + *excess carrier lifetime*
    - 1st term: *increase* in the *number of holes* per unit time *due to the* **hole flux**
    - 2nd term: *increase* in the *number of holes* per unit time *due to the* **generation of holes** 
    - 3rd term: *decrease* in the *number of holes* per unit time *due to the* **recombination of holes**
- divide both sides of the equation by the *differential volume* $dx\,dy\,dz$
- the **net increase** in the *hole concentration per unit time*
  - aka **continuity equation** for **holes**
  - **$\frac{\partial p}{\partial t} = -\frac{\partial F_p^+}{\partial x}+g_p-\frac{p}{\tau_{pt}}$**
- one-dimensional **continuity equation** for **electrons**
  - **$\frac{\partial n}{\partial t} = -\frac{\partial F_n^-}{\partial x}+g_n-\frac{n}{\tau_{nt}}$**
    - **$F_n^-$**: **electron-particle flux/flow**
      - units: number of electrons/cm^2-s

## 6.2.2 time-dependent diffusion equations

### 6.2.2.a math process

- **current densities** of hole and electron (given in one-dimension, [chapter 5](05-carrier-transport-phenomena.md))
  - $J_p = e\mu_p p\text{E} - e D_p\frac{\partial p}{\partial x}$
  - $J_n = e\mu_n n\text{E} + e D_n\frac{\partial n}{\partial x}$
    - 1st term: *drift* current density
    - 2nd term: *diffusion* current density
- **particle flux** obtained by dividing the *current density* by e
  - +e for *hole*, -e for *electron*
    - $F_p^+ = \frac{J_p}{+e} = +\mu_p p\text{E} - D_p\frac{\partial p}{\partial x}$
    - $F_n^- =\frac{J_n}{-e} = -\mu_n n\text{E} - D_n\frac{\partial n}{\partial x}$
  - take **divergence** of the *particle flux*
    - $\frac{\partial F_p^+}{\partial x} = +\mu_p\frac{\partial (p\text{E})}{\partial x}-D_p\frac{\partial^2p}{\partial^2x}$
    - $\frac{\partial F_n^-}{\partial x} = -\mu_n\frac{\partial (n\text{E})}{\partial x} - D_n\frac{\partial^2 n}{\partial^2 x}$
- **continuity equation** substituted by the *divergence* 
  - $\frac{\partial p}{\partial t} = -\mu_p\frac{\partial (p\text{E})}{\partial x} + D_p\frac{\partial^2p}{\partial^2x} + g_p - \frac{p}{\tau_{pt}}$
  - $\frac{\partial n}{\partial t} = +\mu_n\frac{\partial (n\text{E})}{\partial x} + D_n\frac{\partial^2n}{\partial^2x} + g_n - \frac{n}{\tau_{nt}}$
- expand the derivative of the product as
  - $\frac{\partial (p\text{E})}{\partial x} = \text{E}\frac{\partial p}{\partial x} + p\frac{\partial \text{E}}{\partial x}$
  - > - because we are limiting ourselves to one-dimensional analysis
    > - in a more general three-dimensional analysis, this will be replaced by a vector identity

### 6.2.2.b result (time-dependent diffusion equations)

- **time-dependent diffusion equations** for holes and electrons
  - describes **space and time behavior** of the **excess carriers**
  - $D_p\frac{\partial^2p}{\partial^2t}-\mu_p(\text{E}\frac{\partial p}{\partial x}+p\frac{\partial\text{E}}{\partial x})+g_p-\frac{p}{\tau_{pt}} = \frac{\partial p}{\partial t}$
  - $D_n\frac{\partial^2n}{\partial^2t}+\mu_n(\text{E}\frac{\partial n}{\partial x}+n\frac{\partial\text{E}}{\partial x})+g_n-\frac{n}{\tau_{nt}} = \frac{\partial n}{\partial t}$
- for **homogeneous** semiconductor
  - **$n_0$, $p_0$** are **independent** of the **space coordinates**
    - *total concentration(x,t)* = **thermal equilibrium concentration** + *excess concentration(x,t)*:
      - $n(x,t) = n_0 + \delta n(x,t)$
      - $p(x,t) = p_0 + \delta p(x,t)$
  - **$D_p\frac{\partial^2 (\delta p)}{\partial^2t}-\mu_p(\text{E}\frac{\partial (\delta p)}{\partial x}+p\frac{\partial\text{E}}{\partial x})+g_p-\frac{p}{\tau_{pt}} = \frac{\partial (\delta p)}{\partial t}$**
  - **$D_n\frac{\partial^2 (\delta n)}{\partial^2t}+\mu_n(\text{E}\frac{\partial (\delta n)}{\partial x}+n\frac{\partial\text{E}}{\partial x})+g_n-\frac{n}{\tau_{nt}} = \frac{\partial (\delta n)}{\partial t}$**

# 6.3 ambipolar transport

- **assumption**
  - excess holes and electrons *will tend* to drift in opposite directions
- **fact**
  - holes and electrons are charged particle
  - → *separation* induces an *internal electric field* between the *two sets of particles*
  - → this *electric field* will create a force *attracting* the electrons and holes *back towards each other*
- the **electric field term** in the *time-dependent diffusion equations*
  - $\text{E}=\text{E}_{\text{app}} + \text{E}_{\text{int}}$
  - $\text{E}_{\text{app}}$: applied electric field
  - **$\text{E}_{\text{int}}$**: **induced internal field**
    - hold the pulses of *excess electrons* and *excess holes* together
    - → **drift or diffuse together** with a *single effective mobility or diffusion coefficient*
    - → *ambipolar transport*

## 6.3.1 derivation of the ambipolar transport equation

- **Poisson's equation**
  - the *third equation* that relates the *excess electron and hole concentrations* to the *internal electric field*
  - $\nabla\cdot\text{E}_{\text{int}}=\frac{e(\delta p-\delta n)}{\epsilon_s} = \frac{\partial\text{E}_{\text{int}}}{\partial x}$
    - $\epsilon_s$: permittivity of the semiconductor material

### 6.3.1.a math process 1

- **goal**
  - making the *[time-dependent diffusion equation](#622b-result-time-dependent-diffusion-equations)* and *Poisson's equation* more *tractable*
  - → make approximations
- $|\text{E}_{\text{int}}|\ll |\text{E}_{\text{app}}|$
  - **relatively small** *internal electric field* is sufficient to keep the excess carriers *drifting and diffusing together*
- $\nabla\cdot\text{E}_{\text{int}}$ term *may not be negligible*
  - impose condition of **charge neutrality**: $\delta n \approx \delta p$
    - > assume that the *excess electron concentration* is balanced by an **equal** *excess hole concentration* at any point in space and time
      > → if the assumption were *exactly true*, there will be *no induced internal electric field* to keep the two sets of particles together 
    - **very small difference** in the *excess carrier concentrations* will set up a sufficiently large *internal E-field* 
      - e.g. 1% difference in $\delta p$ and $\delta n$
      - → non-negligible values of the $\nabla\cdot\text{E}=\nabla\cdot\text{E}_{\text{int}}$

### 6.3.1.b math process 2

- **goal**
  - combine [time-dependent diffusion equations](#622b-result-time-dependent-diffusion-equations) to eliminate the $\nabla\cdot\text{E}_{\text{int}} = \frac{\partial \text{E}}{\partial x}$ term
  - deriving the *ambipolar transport equation*
- preliminary: **charge neutrality** → **$\delta n \approx \delta p$**
- define: *generation rate of carriers*
  - $g_n = g_p \equiv g$
- define: *recombination rate of carriers*
  - $R_n = \frac{n}{\tau_{nt}} = R_p = \frac{p}{\tau_{pt}} \equiv R$
  - $\tau_{nt}$, $\tau_{pt}$: thermal-equilibrium lifetime + excess carrier lifetime
- *denote* $\delta n$ as excess carrier concentrations
  - $D_p\frac{\partial^2(\delta n)}{\partial x^2}-\mu_p(\text{E}\frac{\partial(\delta n)}{\partial x}+p\frac{\partial\text{E}}{\partial x})+g-R = \frac{\partial (\delta n)}{\partial t}$
  - $D_n\frac{\partial^2(\delta n)}{\partial x^2}+\mu_n(\text{E}\frac{\partial(\delta n)}{\partial x}+n\frac{\partial\text{E}}{\partial x})+g-R = \frac{\partial (\delta n)}{\partial t}$
- *multiply* the former by $\mu_n n$, the latter by $\mu_p p$ and *add the two equations*
  - $(\mu_n n D_p+\mu_p p D_p)\frac{\partial (\delta n)}{\partial x^2}+(\mu_n\mu_p)(p-n)\text{E}\frac{\partial(\delta n)}{\partial x}+(\mu_n n+\mu_p p)(g-R)=(\mu_n n+\mu_p p)\frac{\partial (\delta n)}{\partial t}$
  - divide the equation by $(\mu_n n +\mu_p p)$ next we get...
- **ambipolar transport equation**:
  - **$D'\frac{\partial(\delta n)}{\partial x^2} + \mu'\text{E}\frac{\partial(\delta n)}{\partial x} + g - R = \frac{\partial (\delta n)}{\partial t}$**
  - describes the *behavior of the excess electrons and holes* in *time and space*
  - nonlinear differential equation
- **ambipolar diffusion coefficient**
  - $D' = \frac{\mu_n n D_p + \mu_p p D_n}{\mu_n n + \mu_p p}=D'(n,p)$
  - $D' = \frac{D_nD_p(n+p)}{D_n n+D_p p}$
  - > Einstein relation: $\frac{\mu_n}{D_n}=\frac{\mu_p}{D_p}=\frac{e}{kT}$
- **ambipolar mobility**
  - $\mu' = \frac{\mu_n \mu_p(p-n)}{\mu_n n +\mu_p p} = \mu'(n,p)$

## 6.3.2 limits of extrinsic doping and low injection

- **simplify** and **linearize** the *ambipolar transport equation* by:
  - considering an *extrinsic semiconductor*
  - considering *low-level injection*
- $D' = \frac{D_n D_p[(n_0 + \delta n) + (p_0 + \delta n)]}{D_n (n_0 + \delta n) + D_p(p_0+\delta n)}$
  - $n = n_0 + \delta n$
  - $p = p_0 + \delta p$

### 6.3.2.a p-type semiconductor

- low injection
  - $\delta n \ll p_0$
- p-type semiconductor
  - $n_0\ll p_0$
- **ambipolar diffusion coefficient**
  - $D' = D_n$
- **ambipolar mobility**
  - $\mu'=\mu_n$