UPPER_OBJS = main.o upper.o
UPPER_MACRO_OBJS = main_macro.o


ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =


all: upper upper_macro

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

main_macro.o: main_macro.s upper_macro.s
	as $(DEBUGFLGS) $(LSTFLGS) -arch arm64 $< -o main_macro.o

%.o: %.s
	as $(DEBUGFLGS) $(LSTFLGS) -arch arm64 $< -o $@

upper: $(UPPER_OBJS)
	ld -o upper $(LDFLAGS) $(UPPER_OBJS)

upper_macro: $(UPPER_MACRO_OBJS)
	ld -o upper_macro $(LDFLAGS) $(UPPER_MACRO_OBJS)

clean:
	rm -f $(UPPER_MACRO_OBJS) $(UPPER_OBJS) upper upper_macro upper_macro.o
