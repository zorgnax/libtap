CFLAGS = -g -Wall -I.
CC = gcc
PREFIX = /usr/local
TESTS = $(patsubst %.c, %, $(wildcard t/*.c))

ifdef ANSI
	# -D_BSD_SOURCE for MAP_ANONYMOUS
	CFLAGS += -ansi -D_BSD_SOURCE
	LDLIBS += -lbsd-compat
endif

%:
	$(CC) $(LDFLAGS) $(TARGET_ARCH) $(filter %.o %.a %.so, $^) $(LDLIBS) -o $@

%.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $(filter %.c, $^) $(LDLIBS) -o $@

%.a:
	$(AR) rcs $@ $(filter %.o, $^)

%.so:
	$(CC) -shared $(LDFLAGS) $(TARGET_ARCH) $(filter %.o, $^) $(LDLIBS) -o $@

all: libtap.a tests

libtap.a: tap.o

tap.o: tap.c tap.h

tests: $(TESTS)

$(TESTS): %: %.o libtap.a

$(patsubst %, %.o, $(TESTS)): %.o: %.c tap.h

clean:
	rm -rf *.o t/*.o libtap.a $(TESTS)

install: libtap.a tap.h
	install -c libtap.a $(PREFIX)/lib
	install -c tap.h $(PREFIX)/include

uninstall:
	rm $(PREFIX)/lib/libtap.a $(PREFIX)/include/tap.h

dist:
	rm libtap.zip
	zip -r libtap *

check test: all
	prove

.PHONY: all clean install uninstall dist check test tests

