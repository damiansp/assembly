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
