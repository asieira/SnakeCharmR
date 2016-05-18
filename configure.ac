# Process this file with autoconf to produce a configure script.
# This file is based on configure.ac file distributed along with the rJava package

AC_INIT(SnakeCharmR, 1.0.0, alexandre.sieira@gmail.com)
AC_CONFIG_SRCDIR([src])
#AC_CONFIG_HEADER([src/config.h])

# find R home and set CC/CFLAGS
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi
RBIN="${R_HOME}/bin/R"
#CC=`"${RBIN}" CMD config CC`;
#CFLAGS=`"${RBIN}" CMD config CFLAGS`
CPPFLAGS=`"${RBIN}" CMD config CPPFLAGS`

RLD=`"${RBIN}" CMD config --ldflags 2>/dev/null`
has_R_shlib=no
if test -n "$RLD"; then
   has_R_shlib=yes
fi

MYPYTHONCONFIG=python-config
MYPYTHON=python

# find user defined python version, if set
if test -z "${SNAKECHARMR_PYTHON_VERSION}"
then
  echo "a specific python version to use was not provided"
  echo "defaulting to the standard python in the system"
else
  MYPYTHON=python${SNAKECHARMR_PYTHON_VERSION}
  MYPYTHONCONFIG=python${SNAKECHARMR_PYTHON_VERSION}-config
fi


# Extract the linker and include flags for python
: ${PYTHONCONFIG=`which ${MYPYTHONCONFIG}`}
if test -z "${PYTHONCONFIG}"; then
  echo "could not locate ${MYPYTHONCONFIG}"
  exit 1
fi

PKG_LIBS=`$PYTHONCONFIG --ldflags`
#PKG_CFLAGS=`$PYTHONCONFIG --includes`
PKG_CPPFLAGS=`$PYTHONCONFIG --includes`

# Find the .so library for python
: ${PYTHON=`which ${MYPYTHON}`}
if test -z "${PYTHON}"; then
  echo "could not locate ${MYPYTHON}"
  exit 1
fi

PYTHONLIBFILE=libpython`$PYTHON -c "import sys; print(sys.version[[:3]])"`.so

#PKG_CFLAGS="$PKG_CFLAGS -D PYTHONLIBFILE=$PYTHONLIBFILE"
PKG_CPPFLAGS="$PKG_CPPFLAGS -D PYTHONLIBFILE=$PYTHONLIBFILE"

AC_SUBST(PKG_LIBS)
#AC_SUBST(PKG_CFLAGS)
AC_SUBST(PKG_CPPFLAGS)

AC_PREREQ

# Checks for programs.
#AC_PROG_CC
AC_PROG_CPP

# Checks for libraries.

# Checks for header files.
#AC_HEADER_STDC
#AC_HEADER_SYS_WAIT
#AC_CHECK_HEADERS([Python.h])

# Checks for typedefs, structures, and compiler characteristics.
#AC_C_CONST
#AC_HEADER_TIME

AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
