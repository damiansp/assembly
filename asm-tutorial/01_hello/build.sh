as -o hello.o hello.s
ld -o hello.exe hello.o -lSystem \
   -syslibroot $(xcrun -sdk macosx --show-sdk-path) \
   -e _start -arch arm64
./hello.exe
echo $?


rm hello.o hello.exe
