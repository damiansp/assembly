HelloWorld: HelloWorld.o
	ld HelloWorld.o -o HelloWorld.exe \
		-lSystem \
		-syslibroot `xcrun -sdk macosx --show-sdk-path` \
		-e _start \
		-arch arm64 

HelloWorld.o: HelloWorld.s
	as -arch arm64 -o HelloWorld.o HelloWorld.s
