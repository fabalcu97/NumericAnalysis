COMPILER = fpc
ROUTE = -Fu
DIRECTORY = $(sort $(dir $(wildcard ./*/)))
LIBRARIES := $(foreach library, $(DIRECTORY), $(ROUTE)$(library))

all:
	$(COMPILER) $(LIBRARIES) main.pas
	./main

clean:
	rm */*.o */*.ppu main main.o
