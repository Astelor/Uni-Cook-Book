# Chapter 1, Introduction

# Keys
where?

# HUH?
- does the system have to be LTI for an impulse response to exist?
  - can I find impulse response without checking LTI?
  - if it's not LTI, what will happen if I try to find its impulse response?

# Signal and system theory
> You want a system to...

- time variant
- linear
- BIBO stable
- causal
- 

# SLTI system
> Stable Linear Time-Invariant. LTI -> the basic things to check on a system.

- **Stable**: Bounded input, bounded output (BIBO stable) -> in impulse response section.
- **Linear**
- **Time-Invariant**
- **Causality**: System's output only depends on current input and previous input, but not on future input -> in impulse response section.

Stability & Causality are usually difficult to verify. But if the system is LTI, then simple way exists for verification. -> impulse response.

## Linearity
> Superposition of inputs leads to the same superposition of outputs.

To check its linearity, suppose we have a system, its input is x(t) and output is y(t)
```
x(t) -->[T()]--> y(t)
```

We find if it's linear or not by additivity.

```
x1(t) -->[T()]--> y1(t)
x2(t) -->[T()]--> y2(t)

x(t)=a∙x1(t)+b∙x2(t) -->[T()]--> y(t)≟a∙y1(t)+b∙y2(t)

y(t)=T[x(t)] = T[a∙x1(t) + b∙x2(t)]
             ≟ a∙y1(t) + b∙y2(t)
```

If y(t)=a∙y1(t)+b∙y2(t), then we say this system is linear.

## Time-Invariant
> System's response to a specific input does not depend on when the input is applied. -> the result does not change when the input is the same, not matter what time you do it.

To check if it's time-invariant, suppose we have a system, its input is x(t) and output is y(t)
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

## System models (LTI)

The following properties are LTI:
- addition
- subtraction
- multiplication
- integration
- differentiation
- delay (time shift)

# Impulse response
If we have an LTI system, and its y(t) is known, we can find its impulse response by replacing x(t) with δ(t) (impulse function).
```
x(t) -->[]--> y(t)
δ(t) -->[]--> h(t)
```

If the impulse response h(t) is known, we can find y(t) using convolution.
```
x(t) -->[h(t)]--> y(t)
x(t)*h(t) = y(t), where * is the convolution operator
```

> The wikipedia page about convolution has its method of computation graphically animated, it gives a pretty clear idea about how this whole thing is calculated, and makes finding the ranges of calculation (integral) easier.

## BIBO stable
The integral of the impulse response is "bounded"
$$\int_{-∞}^{∞} |h(t)|\,dt<∞$$

## Causal
$$h(t)=0,\ ∀t<0$$
