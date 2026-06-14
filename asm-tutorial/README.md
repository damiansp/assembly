## Basics
# Assemble a .s file to an object file
as -o program.o program.s


# Link the object file into an executable
ld -o program(.exe) program.o -lSystem \
   -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
   -e _start -arch arm64


# Execute
./program(.exe)



## Program Introspection
# Show the Mach-O header and load commands
otool -l ./hello

# Show the disassembled __text section
otool -tV ./hello

# Show all symbols
nm ./hello

# High-level summary (segments, sections, size)
size -m ./hello

# The Swiss Army knife — shows everything
llvm-objdump -d --macho ./hello



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
