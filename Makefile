include config.mk

all: $(TAPLIB)
	$(MAKE) -C t/ all

$(TAPLIB): tap$(_O)
tap$(_O): tap.c tap.h

clean:
	$(RM) -rv $(TAPLIB) *.o *.obj *.lib *.pdb *.ilk _C
	$(MAKE) -C t/ clean

ifdef GNU
install: $(TAPLIB) tap.h
	sudo cp $(TAPLIB) /usr/lib
	sudo cp tap.h /usr/include

uninstall:
	sudo $(RM) /usr/lib/$(TAPLIB) /usr/include/tap.h
endif

dist:
	$(RM) -v libtap.zip
	zip -r libtap *

check:
	prove

.PHONY: all clean install uninstall dist check

