CFLAGS  = -g
LDFLAGS = -L.. -ltap
PROGS   = simple diesok notediag

all: ${PROGS}

simple: simple.c ../libtap.a
	gcc ${CFLAGS} -o $@ simple.c ${LDFLAGS}

diesok: diesok.c ../libtap.a
	gcc ${CFLAGS} -o $@ diesok.c ${LDFLAGS}

notediag: notediag.c ../libtap.a
	gcc ${CFLAGS} -o $@ notediag.c ${LDFLAGS}

clean:
	rm -rvf *.o ${PROGS}

