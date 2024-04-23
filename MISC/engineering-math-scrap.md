# Engineering METH

HEHEH

# The basics

- Standard basis vectors

(Vectors)

$$
\begin{align*}
\vec{i} &= (1,0,0)\\
\vec{j} &= (0,1,0)\\
\vec{k} &= (0,0,1)
\end{align*}
$$

- Unit vector
$$\vec{u}=\frac{\vec{a}}{|\vec{a}|}$$

# Inner Product (Dot Product)

$$
\begin{align*}
\vec a \cdot \vec b &= |\vec a| |\vec b| \cos(\theta)\\
&= a_1 b_1 + a_2 b_2 + a_3 b_3
\end{align*}
$$

- Work:
	- The work by a constant force can be defined as the inner product of the force F and the displacement d.

$$\vec{W}=\vec{F} \cdot \vec{d} = Fd\cos(\theta)$$

- Orthogonality
	- two vectors is called orthogonal if and only if $\vec a \cdot \vec b = 0$

- Cauchy-Schwarz inequality: 

$$|\vec a \cdot \vec b| ≤ |\vec a||\vec b|$$

- Triangle inequality: 

$$|\vec a + \vec b| ≤ |\vec a|+|\vec b| $$

- Parallelogram equality: 

$$|\vec a + \vec b|^2 + |\vec a - \vec b|^2 = 2(|\vec a|^2+|\vec b|^2)$$

> Astelor: Why am I writing these things that I'll probably never use??

# Cross Product (Vector Product)

$$\vec a \times \vec b = \sin(\theta)|\vec a| |\vec b|$$

# Vector Calculus: Derivative

- Partial Derivatives of a Vector Function
- Composite Function

- **Chain Rule**

$$w=f(x(u,v), y(u,v), z(u,v))$$

$$\frac{∂w}{∂u}=\frac{∂w}{∂x} \frac{∂x}{∂u} +\frac{∂w}{∂y} \frac{∂y}{∂u} + \frac{∂w}{∂z} \frac{∂z}{∂u}$$

- intermediate variables
- independent variables
- dependent variable

# Curve

- Length of a Curve: Integral of the absolute value of the tangent function to the curve.

$$L=\int_{-∞}^{∞} \sqrt{x'(t)^2 + y'(t)^2 + z'(t)^2} dt = \int_{-∞}^{∞}|r'(t)|dt$$

> WTF is mean value theorem??

# Arc

The arc length of a curve C starting at r(a) is given by

$$s(t)=\int_a^t |\vec{r}'(\tau)|d\tau$$

> This give a function of t, so you have s(t)=at, a∊R.
> Which means it gives the relationship between arc length (s) and the parameter (t).

# Mental Guide
- Basics of the vector
	- Vector product
	- Inner product
- Derivative of a vector function
	- Position function
	- Partial derivative
	- Composite function
	- Chain rule
- Curve and Arc length
	- Arc length as a parameter
	- Curvature

---

- The curve:

$$\vec{r}(t)$$

- Tangent of the curve: 

$$\vec{r}'(t)$$

- Arc length as a parameter → unit tangent vector:

$$\vec{r}(s)$$

> Why does $\frac{d \vec r(t)}{dt}=\frac{d \vec r(s) }{dt}$ ??

- Unit tangent vector: 

$$\vec{t}(s)=\vec{r}'(s)=\frac{\vec{r}'(t)}{|\vec{r'}(t)|}$$

- Curvature: 

$$\kappa = |\frac{d\vec t(s)}{ds}| = |\frac{d^2 r(s)}{d s^2}|$$

---

# Gradient:

- Turing a scalar field into a vector field.

> - Scalar field → a plane with different magnitude of values
> - Vector field → a plane with different "arrows" pointing at different directions.

- A gradient of a scalar function f(x,y,z) is defined as:

$$grad\ f = \nabla f = (\frac{∂f}{∂x},\frac{∂f}{∂y},\frac{∂f}{∂z})$$

- del or nabla operator is defined as:

$$\nabla = \vec i \frac{∂}{∂x} + \vec j \frac{∂}{∂y} + \vec k \frac{∂}{∂z}$$

> The partial derivatives give the rates of change of f(x,y,z)

# Directional Derivative

- Directional derivative is **a scalar**, not a vector.

> Astelor: This is quite straight-forward, derivative to f of s, the arc length.

$$\vec D_b f = \frac {df}{ds} = \nabla f \cdot \frac{\vec b}{|\vec b|} =\nabla f \cdot \vec r'(s)$$

- The vector b must be a unit vector.

Using chain rule on the composite function:

$$
\begin{align*}
\vec D_b f = \frac {df}{ds} &= \frac {∂f}{∂x} \frac{∂x}{∂s} + \frac {∂f}{∂y} \frac{∂y}{∂s} + \frac {∂f}{∂z} \frac{∂z}{∂s} \\
&= \frac {∂f}{∂x} x' + \frac {∂f}{∂y} y' + \frac {∂f}{∂z} z'
\end{align*}$$

> The $\frac {∂f}{∂x}$ part is gradient, and the $x'$ part is r'(s)

$$\vec r(s) = x(s) \vec i + y(s) \vec j + z(s) \vec k = \vec p_0 + s\vec b$$

> The vector r(s) → the position vector p0, a **unit vector b** with a arc length variable s.

$$\vec r'(s) = \vec b$$

- recipe: gradient of f, a unit vector b.

# Normal Vector of a Level Surface

- **Level surface**, a surface S represented by $f(x(t), y(t), z(t)) = c$ where c is a constant.

# Divergence

- Divergence operation turns a vector field into a **scalar field**
  - The opposite to the gradient operation.

# Green's Theorem

