CFLAGS = -g -Wall -I. -fPIC
CC = gcc
PREFIX = $(DESTDIR)/usr/local
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

all: libtap.a libtap.so tests

libtap.a: tap.o

libtap.so: tap.o

tap.o: tap.c tap.h

tests: $(TESTS)

$(TESTS): %: %.o libtap.a

$(patsubst %, %.o, $(TESTS)): %.o: %.c tap.h

clean:
	rm -rf *.o t/*.o libtap.a libtap.so $(TESTS)

install: libtap.a tap.h libtap.so
	mkdir -p $(PREFIX)/lib $(PREFIX)/include
	install -c libtap.a $(PREFIX)/lib
	install -c libtap.so $(PREFIX)/lib
	install -c tap.h $(PREFIX)/include

uninstall:
	rm $(PREFIX)/lib/libtap.a $(PREFIX)/lib/libtap.so $(PREFIX)/include/tap.h

dist:
	rm libtap.zip
	zip -r libtap *

check test: all
	perl t/test.t

.PHONY: all clean install uninstall dist check test tests

