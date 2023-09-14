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

all: printdword

printdword: $(OBJS)
	ld -o printdword $(LDFLAGS) $(OBJS)

clean:
	rm *.o printdword
