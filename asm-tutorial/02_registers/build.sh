as -o registers.o registers.s && \
    ld -o registers registers.o -lSystem \
    -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
    -e _start -arch arm64
./registers ; echo "exit: $?"
