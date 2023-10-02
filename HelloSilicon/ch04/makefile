OBJS = printdword.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start \
	-arch arm64

%.o: %.s
	as $(DEBUGFLS) $< -o $@

all: printdword switch

printdword: $(OBJS)
	ld -o printdword $(LDFLAGS) $(OBJS)

switch: switch.o
	ld -o switch $(LDFLAGS) switch.o
clean:
	rm *.o printdword
