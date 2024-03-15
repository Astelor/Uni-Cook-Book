# Chapter 2, Impulse, Impulse Response, and Convolution

- [Chapter 2, Impulse, Impulse Response, and Convolution](#chapter-2-impulse-impulse-response-and-convolution)
- [CT Unit Impulse: δ(t)](#ct-unit-impulse-δt)
  - [Impulse response](#impulse-response)
  - [BIBO stable](#bibo-stable)
  - [Causal](#causal)

# CT Unit Impulse: δ(t)
> Is a theoretical waveform.



## Impulse response
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
