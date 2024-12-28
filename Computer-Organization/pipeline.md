# pipeline, computer organization

1. **IF** (instruction fetch): fetch the instruction
2. **ID** (instruction decode): decode the instruction
3. **EX** (execute): execute the operation
4. **MEM** (memory): access memory operand
5. **WB** (write back): write the result into a register

the clock cycle is as fast as the slowest operation

# data hazard condition

> the time when a forwarding is necessary

- 1a EX/MEM.RegisterRd = ID/EX.RegisterRs
- 1b EX/MEM.RegisterRd = ID/EX.RegisterRt
- 2a MEM/WB.RegisterRd = ID/EX.RegisterRs
- 2b MEM/WB.RegisterRd = ID/EX.RegisterRt

```
[IF] [ID] [EX] (EX/MEM) [ME] [WB]
                  ↓
     [IF] [ID] (ID/EX)  [EX] [ME] [WB]
```

```
[IF] [ID] [EX] [ME] (MEM/WB) [WB]
     [IF] [ID] [EX]     ↓    [ME] [WB]
          [IF] [ID]  (ID/EX) [EX] [ME] [WB]
```

- 1 -> sends to the next instruction
- 2 -> sends to the next next instruction

## condition that requires a stall

- the data is immediately required after a load

**stall required**:
```
     [rt]  [rs]
lw   $t1, 4(t0)
add  $t3, $t1, $t2 
```

# branch hazard
> aka control hazard

```
[IF] [ID] [EX] [ME] [WB]
     [IF] [ID] [EX] [ME] [WB]
```
