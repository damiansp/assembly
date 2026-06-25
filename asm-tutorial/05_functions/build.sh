as -o functions.o functions.s && \
    ld -o functions functions.o -lSystem \
    -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
    -e _start -arch arm64
./functions
echo "exit: $?"

# cleanup
rm functions functions.o
