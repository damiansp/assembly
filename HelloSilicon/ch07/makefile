UPPER_OBJS = main.o upper.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =

all: upper

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

%.o: %.S
	clang $(DEBUGFLGS) $(LSTFLGS) -c $< -o $@

%.o: %.s
	as $(DEBUGLFGS) $(LSTFLGS) $< -o $@

upper: $(UPPER_OBJS)
	ld -o upper $(LDFLAGS) $(UPPER_OBJS)
