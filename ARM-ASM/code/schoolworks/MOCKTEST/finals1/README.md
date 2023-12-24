# quick notes
## Question 1
the question asks us to use STM (store multiple) to complete the task
```
STMIA{cond} r0, {r1,r2,r3,r4}   ; Increment After
STMIB{cond} Rn, {Rlist}         ; Increment Before
STMDA{cond} Rn, {Rlist}         ; Decrement After
STMDB{cond} Rn, {Rlist}         ; Decrement Before

STMIA{cond} Rn!, {Rlist}        ; the ! increments the base Rn
```
- it will store the contents within `r1, r2, r3, r4` to the address held in `r0` subsequently
- STMIA -> Rn is incremented AFTER each store operation

- the question ask us NOT to use ! so ehhhhhhhhhhhhh

## Question 2
the question asks us to use subroutines
```
        ENTRY
        BL func1
stop    B  stop
func1
        ; some code here
        BX lr ; will link back to the next instruction below "BL func1"

        END
```
- just know that it does the job correctly

```


```