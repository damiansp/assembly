# Basics
### Assemble a .s file to an object file
`as -o program.o program.s`


### Link the object file into an executable
```
ld -o program(.exe) program.o -lSystem \
   -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
   -e _start -arch arm64
```

### Execute
`./program(.exe)`



# Program Introspection
### Show the Mach-O header and load commands
`otool -l ./hello`

### Show the disassembled __text section
`otool -tV ./hello`

### Show all symbols
`nm ./hello`

### High-level summary (segments, sections, size)
`size -m ./hello`

### The Swiss Army knife — shows everything
`llvm-objdump -d --macho ./hello`



## Registers
Name|Alt name|Purpose
----|--------|-------
x0–x7||Function arguments and return values. x0 = first arg / return value.
x8|xr|Indirect result location (pointer to large return struct)
x9–x15||Caller-saved temporaries — free to use, not preserved across calls
x16–x17|ip0, ip1|Intra-procedure-call scratch. x16 = macOS syscall number.
x18||Reserved by the platform (do not use on macOS)
x19–x28||Callee-saved — you must preserve these if you use them
x29|fp|Frame pointer — base of the current stack frame
x30|lr|Link register — holds return address for function calls (bl)
sp||Stack pointer — must stay 16-byte aligned at all times on macOS
xzr||Zero register — always reads as 0, writes are discarded
pc||Program counter — current instruction address (not directly writable)


## Arithmethic & Logic
Instruction|Syntax|Operation
-----------|------|---------
add|add x0, x1, x2|x0 = x1 + x2
sub|sub x0, x1, x2|x0 = x1 - x2
mul|mul x0, x1, x2|x0 = x1 * x2 (lower 64 bits)
sdiv|sdiv x0, x1, x2|x0 = x1 / x2 (signed integer)
udiv|udiv x0, x1, x2|x0 = x1 / x2 (unsigned integer)
msub|msub x0, x1, x2, x3|x0 = x3 - (x1 * x2) — useful for modulo
neg|neg x0, x1|x0 = -x1
adds / subs|adds x0, x1, x2|Same as add/sub, but also updates condition flags (NZCV)
and|and x0, x1, x2|Bitwise AND
orr|orr x0, x1, x2|Bitwise OR
eor|eor x0, x1, x2|Bitwise XOR
lsl|lsl x0, x1, #3|Logical shift left by 3 (multiply by 8)
lsr|lsr x0, x1, #1|Logical shift right by 1 (unsigned divide by 2)
asr|asr x0, x1, #2|Arithmetic shift right (preserves sign bit)


## Branches & Loops
Instruction|Syntax|Meaning
-----------|------|-------
cmp|cmp x0, x1|Sets flags based on x0 - x1 (discards result)
b|b label|Unconditional branch to label
b.eq|b.eq label|Branch if equal (Z flag set)
b.ne|b.ne label|Branch if not equal
b.lt|b.lt label|Branch if less than (signed)
b.gt|b.gt label|Branch if greater than (signed)
b.le|b.le label|Branch if less than or equal
b.ge|b.ge label|Branch if greater than or equal
cbz|cbz x0, label|Branch if x0 == 0 (no separate cmp needed)
cbnz|cbnz x0, label|Branch if x0 != 0
bl|bl function|Branch with link — call a function (saves PC+4 into lr)
ret|ret|Return from function (branches to address in lr)


## Functions
- First 8 args go in x0 - x7; Additional args go on the stack
- Return value in x0 (and x1 for 128-bit results)
- x0 - x18: caller must save if needed after the `bl` call
- x19 - x28: fp, lr: caller must save/restore if it uses them
- sp must be 16-byte aligned before any `bl` call (else bus error)
- x29 (fp) points to the saved fp/lr pair at the base of your frame
