-include ../config.mak

ifdef GNU
	LDFLAGS = -L.. -ltap
else
	LDFLAGS = ../$(TAPLIB)
endif

X = simple$(_X) diesok$(_X) notediag$(_X) skip$(_X) todo$(_X)

O1 = simple$(_O)
O2 = diesok$(_O)
O3 = notediag$(_O)
O4 = skip$(_O)
O5 = todo$(_O)
O = $(O1) $(O2) $(O3) $(O4) $(O5)

$(O): ../$(TAPLIB) ../tap.h

.PHONY: all
all: $(X) ../$(TAPLIB)

simple$(_X): $(O1) ../$(TAPLIB)
	$(CC) $(CFLAGS) $(CLOUT)$@ $(O1) $(LDFLAGS)

simple$(_O): simple.c
	$(CC) $(CCFLAGS) $(CCOUT)$@ $(CFLAGS) simple.c

diesok$(_X): $(O2) ../$(TAPLIB)
	$(CC) $(CFLAGS) $(CLOUT)$@ $(O2) $(LDFLAGS)

diesok$(_O): diesok.c
	$(CC) $(CCFLAGS) $(CCOUT)$@ $(CFLAGS) diesok.c
	
notediag$(_X): $(O3) ../$(TAPLIB)
	$(CC) $(CFLAGS) $(CLOUT)$@ $(O3) $(LDFLAGS)

notediag$(_O): notediag.c
	$(CC) $(CCFLAGS) $(CCOUT)$@ $(CFLAGS) notediag.c

skip$(_X): $(O4) ../$(TAPLIB)
	$(CC) $(CFLAGS) $(CLOUT)$@ $(O4) $(LDFLAGS)

skip$(_O): skip.c
	$(CC) $(CCFLAGS) $(CCOUT)$@ $(CFLAGS) skip.c

todo$(_X): $(O5) ../$(TAPLIB)
	$(CC) $(CFLAGS) $(CLOUT)$@ $(O5) $(LDFLAGS)

todo$(_O): todo.c
	$(CC) $(CCFLAGS) $(CCOUT)$@ $(CFLAGS) todo.c

.PHONY: clean
clean:
	$(RM) -rv $(X) *.o *.obj *.lib *.pdb *.ilk _C
