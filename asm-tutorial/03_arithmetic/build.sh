as -o arithmetic.o arithmetic.s && \
    ld -o arithmetic arithmetic.o -lSystem \
    -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
    -e _start -arch arm64
./arithmetic
echo "exit: $?"
