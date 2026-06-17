as -o loop.o loop.s && \
    ld -o loop loop.o -lSystem \
    -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
    -e _start -arch arm64
./loop
echo "exit: $?"

# cleanup
rm loop loop.o
