as -o ifelse.o ifelse.s && \
    ld -o ifelse ifelse.o -lSystem \
    -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
    -e _start -arch arm64
./ifelse
echo "exit: $?"

# cleanup
rm ifelse ifelse.o
