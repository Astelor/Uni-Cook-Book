# Chapter 1, Waves and Phasors
> Introduction chapter, all the basic things you should know

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

## 1-3.1 Gravitational Force: A Useful Analogue
> The way gravity works is similar to electric forces, so let's look at this first.

According to Newton's law of gravity, the gravitational force Fg21 acting on mass m2 due to a mass m1 at a distance R12 from m2 is given by:

`(1.2)`

$$F_{g_{21}}=-\hat{R}\frac{Gm_1m_2}{R^2_{12}}\ (N)$$

- Fg21: m2 experiencing gravitational force because of m1.

> m2 "moves" because there's another mass, m1 pulling at m2. Fg21 is acted on m2, and it points from m2 to m1 (thus the notation 21).

> Two masses, vector for direction, distance for intensity, I think.

```
  Fg12        Fg21
  -->         <--
[m1]-->R12     [m2]
 |----------R12--|
```

Phenomenon of action at a distance -> Concept of fields -> mass m1 induces a gravitational field (doesn't physically emanate from the object)

```
gravitation field Ψ1
+------------+
|          R |
|--->[m1]<---[m2]
|            |
+------------+
```

`(1.3)`

$$F_{g_{21}}=Ψ_1m_2$$

The force acting on m2 when placed near m1.

`(1.4)`

$$Ψ_1=-\hat R\frac{Gm_1}{R^2}\ (N/kg)$$

Gravitation field induced by m1.

`(1.5)`

Generalizing the field concept, at any point in space when a test mass m is placed, we can test its gravitational field.

$$Ψ=\frac{F_g}{m}$$


> I don't really wanna note the vector nature into the variables, if its definition has vector, then it's a vector, it pointy.

## 1-3.2 Electric Fields

Differences between gravitational force:
- source of electrical field in electric charge
- positive and negative polarity -> attractive or repulsive 

`(1.6)`

$$e=1.6×10^{-19}\ (C)$$

Magnitude of electron, measured in coulomb.

Coulomb's law:
1. two like charges repel one another, whereas two charges of opposite polarity attract
2. the force acts along the line joining the charges
3. its strength is proportional to the product of the magnitudes of the two charges (q1*q2) and inversely proportional to the square of the distance between them (1/R^2)

`(1.7)`

Coulomb's law expressed mathematically:

$$F_{e_{21}}=\hat R_{12}\frac{q_1q_2}{4πε_0R^2_{12}}$$

