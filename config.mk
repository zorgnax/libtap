GNU = 1
MAKE = make
CFLAGS = $(DEBUG)
ifdef GNU
	ALLCFLAGS = -Wall $(CFLAGS)
	DEBUG = -g
	CCFLAGS = -c
	CCOUT = -o
	CLOUT = -o
	PIC = -fPIC
	_O = .o
	_X =
	_A = .a
	_SO = .so
	TAPLIB = libtap.a
	STATICLIB.o = $(AR) rcs $@ $(filter %$(_O), $^)
	DYNAMICLIB.o = $(CC) -shared -o $@ $(filter %$(_O), $^)
else
	CC = cl /nologo
	ALLCFLAGS = /Wall /wd4255 /wd4996 /wd4127 /wd4820 \
			    /wd4100 /wd4619 /wd4514 /wd4668 $(CFLAGS)
    DEBUG = /Zi
	CCFLAGS = /c
	CCOUT = /Fo
	CLOUT = /Fe
	PIC = 
	_O = .obj
	_X = .exe
	_A = .lib
	_SO = .dll
	TAPLIB = tap.lib
	STATICLIB.o = lib /nologo /out:$@ $(filter %$(_O), $^)
	DYNAMICLIB.o = lib /nologo /out:$@ $(filter %$(_O), $^)
endif
COMPILE.c = $(CC) $(CCFLAGS) $(CPPFLAGS) $(ALLCFLAGS) $(CCOUT)$@ $(filter %.c, $^)
LINK.o = $(CC) $(ALLCFLAGS) $(CLOUT)$@ $(filter %$(_O) %.a %.so %.lib %.dll, $^) $(LDFLAGS)

%$(_X):; $(LINK.o)
%$(_A):; $(STATICLIB.o)
%$(_SO):; $(DYNAMICLIB.o)
%$(_O):; $(COMPILE.c)

