OBJS = to_upper.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =
LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

all: to_upper

%o: %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o $@

upper: $(OBJS)
	ld -o to_upper $(LDFLAGS) $(OBJS)

clean:
	rm -f *.o to_upper
