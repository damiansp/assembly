TOOLPATH = /usr/aarch64-linux-gnu/bin

helloWorld: helloWorld.o
	$(TOOLPATH)/ld -o helloWorld helloWorld.o

helloWorld.o: helloWorld.s
	$(TOOLPATH)/as -o helloWorld.o helloWorld.s

