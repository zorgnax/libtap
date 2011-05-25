include ../config.mk

CFLAGS += -I..

X := simple diesok notediag skip todo is like cmpok synopsis
X := $(patsubst %, %$(_X), $(X))
O = $(patsubst %$(_X), %$(_O), $(X))

all: $(X) ../$(TAPLIB)

../$(TAPLIB):
	$(error error $(TAPLIB) needs to be built)

$(O): %$(_O): %.c ../tap.h
$(X): %$(_X): %$(_O) ../$(TAPLIB)

clean:
	$(RM) -rv $(X) *.o *.obj *.lib *.pdb *.ilk _C

.PHONY: all clean

