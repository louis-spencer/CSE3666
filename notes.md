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
lw t0, 0(s1)
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

### 2/11/2025
<p>

Something something procedure call instructions - JAL <br>
For function calling in RISCV <br>
`jal rd, function_name` to jump and link <br>

`jalr rd, rs1, offset` to jump and link address in a register <br>
From the above instruction,`PC = rs1 + offset, rd = PC+r` <br>

Combine both functions to properly call a function and return. <br>

For function calls, first eight arguments passed in `a0, a1, a2 ... a7` <br>
Two values can be returned in `a0, a1` <br>

**Absolute function code in C** <br>
```c
int abs(in n) {
  int rv = n;
  if (n < 0) {
    rv = -n;
  }
  return rv;
}
```
Converting to RISCV results in: <br>
```assembly
main:
  addi a0, x0, -10
  jal ra, abs

  addi a7, x0, 10
  ecall

abs:
  # n is in a0
  # rv is in a1

  add a1, a0, x0
  bge a0, x0, skip
  sub a1, x0, a0

skip:
  add a0, a1, x0
  jalr x0, ra, 0
```

**Recursive factorial code in C** <br>
```c
int fact (int n) {
  if (n < 1) {
    return 1;
  } else {
    return n * fact(n-1);
  }
}
```
Converting to RISCV results in: <br>
```assembly
fact: # n is in a0
  addi sp, sp, -8 # allocate 8 bytes on the stack
                  # negative because stack goes down

  sw ra, 0(sp)
  sw a0, 4(sp)


  addi  t0, x0, 1
  bge   a0, t0, else
  addi  a0, x0, 1
  beq   x0, x0, exit
else:
  addi  a0, a0, -1
  jal   ra, fact

  # after fact returns, a0 is (n-1)!
  lw t0, 4(sp)  # load n

  mul   a0, a0, t0  # verify instruction correct

exit:
  lw  ra, 0(sp)
  addi sp, sp, 8  # restore stack pointer
  jalr  x0, ra, 0

```

Some issues arise with the factorial function destroying the value of n when <br>
computing n*(n-1)*(n-2)\*...<br>
Hence, use the stack




</p>