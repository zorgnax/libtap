GNU = 1

MAKE = make

ifdef GNU
	CFLAGS = -g -Wall
	CCFLAGS = -c
	CCOUT = -o 
	CLOUT = -o 
	_O = .o
	_X =
	TAPLIB = libtap.a
else
	CC = cl /nologo
	CFLAGS = /Zi /Wall /wd4255 /wd4996 /wd4127 /wd4820 \
			 /wd4100 /wd4619 /wd4514 /wd4668
	CCFLAGS = /c
	CCOUT = /Fo
	CLOUT = /Fe
	_O = .obj
	_X = .exe
	TAPLIB = tap.lib
endif
