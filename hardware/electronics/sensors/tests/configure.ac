AC_PREREQ([2.61])
AC_CONFIG_MACRO_DIRS([m4])
AC_INIT([libmbot_sensors], [0.0.1])
AC_CONFIG_SRCDIR([.])
AM_INIT_AUTOMAKE
CFLAGS="$CFLAGS -Wall -Werror -O2 -Wno-deprecated"
AC_PROG_CC
LT_PREREQ([2.2])
LT_INIT([dlopen])
AC_ENABLE_SHARED
AC_SUBST([LIBTOOL_DEPS])
AC_OUTPUT(Makefile lib/Makefile src/Makefile)
