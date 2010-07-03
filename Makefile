-include config.mak

O = tap$(_O)

.PHONY: all
all: $(TAPLIB)
	$(MAKE) -C t/ all

$(TAPLIB): $(O)
ifdef GNU
	$(AR) rcs $(TAPLIB) $(O)
else
	lib /nologo /out:$(TAPLIB) $(O)
endif

tap$(_O): tap.c tap.h
	$(CC) $(CCFLAGS) $(CCOUT)$@ $(CFLAGS) tap.c

clean:
	$(RM) -rv $(TAPLIB) *.o *.obj *.lib *.pdb *.ilk _C
	$(MAKE) -C t/ clean

ifdef GNU
.PHONY: install
install: $(TAPLIB) tap.h
	sudo cp $(TAPLIB) /usr/lib
	sudo cp tap.h /usr/include

.PHONY: uninstall
uninstall:
	sudo $(RM) /usr/lib/$(TAPLIB) /usr/include/tap.h
endif

.PHONY: dist
dist:
	$(RM) -v libtap.zip
	zip -r libtap *
