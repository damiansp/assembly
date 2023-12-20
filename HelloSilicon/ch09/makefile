LIBOBJS = upper.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTLFGS =
LDFLAGS = -lSystem -lc -e main -arch arm64

all: upper_test

upper.e.o: upper.s
	as -arch arm64e $(DEBUGLFAG) $< -o upper.e.o

%.o: %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o $@

upper_test: upper_test.c upper.s
	clang -o upper_test upper_test.c upper.s

lubupper.a: $(LIBOBJS)
	ar -cvq libupper.a upper.o

libup.dylib: $(LIBOBJS) upper.e.o
	clang -current_version 1.0 -compatibility_version 1.0 \
		-dynamiclib	-o oibup.arm64.dylib $(LIBOBJS)
	clang -arch arm64e -current_version 1.0 -compatibility_version 1.0 \
		-dynamiclib -o libup.arm64e.dylib upper.e.o
	lip -create -output libup.A.dylib libup.arm64.dylib libup.arm64e.dylib
	mkdir -p ./lib
	mv libup.A.dylib ./lib/
	ln -sf ./lib/libup.A.dylib ./lib/libup.dylib

clean:
	rm -f *.o upper_test libupper.a upper_test? ./lib/lubup.dylib \
		./lib/libup.A.dylib
