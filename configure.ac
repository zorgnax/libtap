#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([libtap], [0.1.0], [gelbman@gmail.com])
AC_CONFIG_SRCDIR([tap.c])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR([.auto])
AM_INIT_AUTOMAKE

# Checks for programs.
AC_PROG_CC
AC_PROG_INSTALL
LT_INIT

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h string.h sys/param.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.
AC_FUNC_FORK
AC_FUNC_MALLOC
AC_FUNC_MMAP
AC_CHECK_FUNCS([regcomp])

AC_CONFIG_FILES([Makefile t/Makefile tap.pc])
AC_OUTPUT
