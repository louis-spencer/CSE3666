# NOTES
### 1/30/2025
<p>

**SHIFT RIGHT and SHIFT LEFT** <br>
```srli t0, t1, N``` (shift right logic immediate) <br>
```slli t0, t1, N``` (shift left logic immediate) <br> 
```srai t0, t1, N``` (shift right arithmatic immediate) <br>
```slai t0, t1, N``` (shift left arithmatic immediate) <br>
and corresponding non-immediate ones </br>
Note:<br>
shift logical **pads with 0** while shift arithmetic **pads with 1**<br>

```s1 = s0 * 7``` &rarr;
```assembly
slli s1, s0, 3
sub s1, s1, s0
```

```s1 = s0 * 9``` &rarr;
```assembly
slli s1, s0, 3
add s1, s1, s0
```
<br>

**AND and ANDI operations** <br>

```and t0, t1, t2``` <br>
```andi t0, t1, HEX``` the 12-bit immediate in ANDI is sign extended<br>
Use AND and ANDI as masking tools <br>

**OR and ORI operations** <br>

```or t0, t1, t2``` <br>
```ori t0, t1, HEX``` the 12-bit immediate is sign extended<br>

**XORI** <br>

```xori t0, t1, N``` the 12-bit immediate is sign extended<br>
special case of ```xori t0, t1, -1``` results in the NOT operation <br>

**Load 32-bit Constants into Register** <br>

```add``` only loads up to 12 bits <br>
use ```lui t0, HEX20``` to do so &rarr; <br>
```assembly
lui s0, 0x12345
addi s1, s1, 0x678
```
</p>

### 2/4/2025
<p>

to define a variable in RISC-V, use labels as such: <br>
```assembly
.align 2
# a word with initial value 3
x:  .word 3

# two words with inital values
y:  .word 4, 5
```
to load an address, use ```lui``` and ```addi```.<br>

**Load/Store word instructions** <br>

load a word from memory using `lw rd, offset(rs1)`<br>
save a word to memory using `sw rs2, offset(rs1)`<br>
Example:<br>
```assembly
lw`t0, 0(s1)
sw t0, 0(s2)
```
In this example, s1 is a pointer. <br>

To load an address given by a register with an offset given by another register, <br>
add the register together like so: <br>
```assembly
add t0, x2, x3
lw  x1, 0(t0)
```

To load `A[i]` into t3 where i is in s2: <br>
```assembly
slli  t0, s2, 2
add t0, t0, s1
lw  t3, 0(t0)
```
**review slides for other examples**<br>

</p>
