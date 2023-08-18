MEOBJS = movexamps.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

%.o : %.s
	as $(DEBUGFLGS) $< -o $@

all: movexamps

movexamps: $(MEOBJS)
	ld -o movexamps $(LDFLAGS) $(MEOBJS)

clean:
	rm *.o movexamps
