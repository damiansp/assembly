MEOBJS = movexamps.o
MNAOBJS = movn_add.o
AACOBJS = add_adc.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

%.o : %.s
	as $(DEBUGFLGS) $< -o $@

all: movexamps movn_add add_adc

movexamps: $(MEOBJS)
	ld -o movexamps $(LDFLAGS) $(MEOBJS)

movn_add: $(MNAOBJS)
	ld -o movn_add $(LDFLAGS) $(MNAOBJS)

add_adc: $(AACOBJS)
	ld -o add_adc $(LDFLAGS) $(AACOBJS)

clean:
	rm *.o movexamps movn_add add_adc
