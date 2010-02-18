CFLAGS = -g

all: libtap.a
	cd t && make

libtap.a: tap.o
	ar rcs libtap.a tap.o

tap.o: tap.c tap.h
	gcc ${CFLAGS} -c tap.c

clean:
	rm -rvf *.o libtap.a
	cd t && make clean

install: libtap.a tap.h
	cp libtap.a /usr/lib
	cp tap.h /usr/include

uninstall:
	rm /usr/lib/libtap.a /usr/include/tap.h

