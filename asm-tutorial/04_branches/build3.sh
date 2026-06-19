as -o kuku.o kuku.s && \
  ld -o kuku kuku.o -lSystem \
    -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
    -e _start -arch arm64
./kuku
rm kuku kuku.o
