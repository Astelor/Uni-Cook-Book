# Chapter 1, Introduction

- [Chapter 1, Introduction](#chapter-1-introduction)
- [Keys](#keys)
- [HUH?](#huh)
- [Signal and system theory](#signal-and-system-theory)
- [SLTI Causal systems](#slti-causal-systems)
  - [Linearity](#linearity)
  - [Time-Invariant](#time-invariant)
- [System models (linear)](#system-models-linear)
- [Signal models](#signal-models)
  - [Euler Formula](#euler-formula)

# Keys
where?

# HUH?
- does the system have to be LTI for an impulse response to exist?
  - can I find impulse response without checking LTI?
  - if it's not LTI, what will happen if I try to find its impulse response?

# Signal and system theory
> Basic things you should know before starting.

Signal:
- Continuous time (CT): x(t)
- Discrete time (DT): x[n], n ∈ integer

> Signals in this class (Electrical Engineering) appeared in volt or ampere.

System:
- Analog: process CT signals
- Digital: process DT signals


Block diagram of someone giving a speech to an audience:
```
                                       [tape recorder]
       ξ(t)                                   ↑
        ↓                                     |e(t)
x(t)-->[+]-->[+]-->[microphone]-->[amplifier]-+->[speaker]-+->y(t)
              ↑                                            ↓
              |  r(t)                                      |
              +--------[room acoustic]---------------------+
```
> Block diagram are often used by engineers to model signals and systems.
> Another way is by more compact "flow graph"

Flow graph to the block diagram above:
```
           Audience                   Tape
           Noise ξ(t)                 Recorder
                 ●                        ●
                 |                        |
                 ▼                        ▲
Singer's         |                        |  Speaker
Voice x(t) ●--►--●------►-----●------►----●----►----●--►--● y(t)
                 | Microphone   Amplifier e(t)      |
            r(t) |                                  |
                 +------------◄---------------------+
                         Room Acoustics      
```
# SLTI Causal systems
> Stable Linear Time-Invariant. LTI -> the basic things to check on a system.

- **Stable**: Bounded input, bounded output (BIBO stable)
- **Linear**: Superposition of inputs leads to the same superposition of outputs
- **Time-Invariant**: System's response to a specific input does not depend on when the input is applied. (not time-invariant = time-varying)
- **Causality**: System's output only depends on current input and previous input, but not on future input

Stability & Causality are usually difficult to verify. But if the system is LTI, then a simple way exists for verification. -> impulse response.

## Linearity
> :CHECKING:

SOP: To check its linearity, suppose we have a system, its input is x(t) and output is y(t)
```
x(t) -->[T()]--> y(t)
```

We find if it's linear or not by additivity.

```
x1(t) -->[T()]--> y1(t)
x2(t) -->[T()]--> y2(t)

x(t)=a⋅x1(t)+b⋅x2(t) -->[T()]--> y(t)≟a⋅y1(t)+b⋅y2(t)

y(t)=T[x(t)] = T[a⋅x1(t) + b⋅x2(t)]
             ≟ a⋅y1(t) + b⋅y2(t)
```

If y(t)=a⋅y1(t)+b⋅y2(t), then we say this system is linear.

## Time-Invariant
> Astelor: which means the result does not change when the input is the same, not matter what time you do it.

SOP: To check if it's time-invariant, suppose we have a system, its input is x(t) and output is y(t)
```
x(t) -->[T()]--> y(t)
```

We find if it's time-invariant or not by shifting the input by τ.
```
x1(t) -->[T()]--> y1(t)

x(t)=x1(t-τ) -->[T()]--> y(t)≟y1(t-τ)

y(t)=T[x(t)]=T[x1(t-τ)]≟y1(t-τ)
```

If y(t)=y1(t-τ), then we say this system is time-invariant.

# System models (linear)

The following properties are LTI:
- Addition: x1(t)+x2(t)
- Subtraction: x1(t)-x2(t)
- Multiplication: A⋅x1(t), A ∈ constant
- Integration: $\int_{-∞}^{t}x(τ)\,dτ$
- Differentiation: $\frac{dx(t)}{dt}$
- Delay (time shift): x(t-τ)

- Division is **not** a linear operation $\frac{x_1(t)}{x_2(t)}$

# Signal models
- real numbers
- complex numbers:
  - canonical form: $z=a+bj$
  - polar form: $z=r⋅e^{jθ}$

$r=\sqrt{a^2+b^2}$, $θ=tan^{-1}(\frac ba)$

$a=r⋅cos(θ)$, $b=r⋅sin(θ)$

$θ∈(0,2π)$

## Euler Formula
$$e^{jθ}=cos(θ)+j⋅sin(θ)$$
$$e^{-jθ}=e^{j(-θ)}=cos(θ)-j⋅sin(θ)$$

$$cos(θ)=\frac{e^{jθ}+e^{-jθ}}{2}$$
$$sin(θ)=\frac{e^{jθ}-e^{-jθ}}{2j}$$