include ../config.mk

X = simple$(_X) diesok$(_X) notediag$(_X) skip$(_X) todo$(_X) is$(_X) like$(_X)

.PHONY: all
all: $(X) ../$(TAPLIB)

../$(TAPLIB):
	$(error error $(TAPLIB) needs to be built)

$(O): ../tap.h
$(X): %$(_X): %$(_O) ../$(TAPLIB)

simple$(_O): simple.c
diesok$(_O): diesok.c
notediag$(_O): notediag.c
skip$(_O): skip.c
todo$(_O): todo.c
is$(_O): is.c
like$(_O): like.c

.PHONY: clean
clean:
	$(RM) -rv $(X) *.o *.obj *.lib *.pdb *.ilk _C

