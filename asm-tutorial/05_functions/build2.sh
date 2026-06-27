as -o myprintf.o myprintf.s \
    && ld -o myprintf myprintf.o \
          -lSystem \
          -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
          -e _start \
          -arch arm64
./myprintf
echo "exit: $?"

# cleanup
rm myprintf myprintf.o
