# scrap that i keep forgetting

> r2 gets changed instead of the register closest to the mnemonics, it's different from ARM or MIPS

- `RMO r1, r2`  
  - **r2 ← (r1)**
  - copy the content of r1 to r2
- `SUBR r1, r2`
  - **r2 ← (r2) - (r1)**
- `TIX m`
  - X ← (X) + 1; (X) : (m...m+2)
  - comparing by performing a `(m...m+2)` - `(X)`
  - `LT`: (X) is less then `m`


---
- `nixbpe`