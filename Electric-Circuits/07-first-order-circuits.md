# chapter 7, first-order circuits

> RC and RL circuits

- **first-order circuits**
  - first-order differential equation from analysis
  - RC and RL
- **excite the circuits**
  1. *source-free circuits*
     - initial conditions of the storage elements
     - by definition free of independent sources
  2. *independent sources*

# 7.2 the source-free RC circuit

- what is it?
  - occurs when dc source is suddenly disconnected
  - energy already stored in the capacitor is released to the resistors
- 
# 7.5 step response of an RC circuit

- **step response** of a circuit
  - the circuit's behavior when the excitation is the step function
- **transient response**
  - the circuit's temporary response that will die out with time
- **steady-state response**
  - the circuit's behavior a long time after an external excitation is applied

## 7.5.a circuit analysis on RC circuit

- goal: finding v(t)
  - applying KCL
    - $C\frac{dv}{dt}+\frac{v-V_su(t)}{R}=0$
    - $\frac{dv}{dt}+\frac{v}{RC}=\frac{V_s}{RC} u(t)$
  - for t > 0
    - $\frac{dv}{dt}+\frac{v}{RC}=\frac{V_s}{RC}$
  - rearranging the terms
    - $\frac{dv}{dt} = -\frac{v-V_s}{RC}$
    - $\frac{dv}{v-V_s}=-\frac{dt}{RC}$
  - integrating both sides and introducing the initial conditions
    - (from initial condition to "current")
    - $\ln{(v-V_s)}|^{v(t)}_{V_0}=-\frac{t}{RC}|^{t}_{0}$
      - $\ln{(v(t)-V_s)}-\ln{(V_0-V_s)} = -\frac{t}{RC}+0$
      - $\ln{\frac{v(t)-V_s}{V_0-V_s}} = -\frac{t}{RC}$
      - $\frac{v(t)-V_s}{V_0-V_s} = e^{-t/\tau}$
      - $\tau=RC$ = time constant
    - $v(t) = V_s+(V_0-V_s)e^{-t/\tau}\,,t>0$
      - **the goal**!
  - finally
    - $\begin{align*} v(t) = \begin{cases} V_0 & t<0 \\ V_s+(V_0-V_s)e^{-t/\tau} ,& t>0 \end{cases} \end{align*}$



```
        t=0 close
 +--[R]--o/↷ o--+
 |               |
+|               |  +
[Vs]            [C] v
-|               |  -
 |               |
 +---------------+
```