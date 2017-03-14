# Process this file with autoconf to produce a configure script.
# This file is based on configure.ac file distributed along with the rJava package

AC_INIT(SnakeCharmR, 1.0.6, alexandre.sieira@gmail.com)
AC_CONFIG_SRCDIR([src])

# find user defined python version, if set
if test -z "${SNAKECHARMR_PYTHON_VERSION}"
then
  echo "A specific python version to use was not provided, defaulting to the standard Python in the system."
  MYPYTHONCONFIG=python-config
  MYPYTHON=python
else
  MYPYTHON=python${SNAKECHARMR_PYTHON_VERSION}
  MYPYTHONCONFIG=python${SNAKECHARMR_PYTHON_VERSION}-config
fi

# Extract the linker and include flags for python
: ${PYTHONCONFIG=`which ${MYPYTHONCONFIG}`}
if test -z "${PYTHONCONFIG}"; then
  echo "Unable to locate ${MYPYTHONCONFIG} - please ensure SNAKECHARMR_PYTHON_VERSION environment variable is set correctly."
  exit 1
fi

PKG_LIBS=`$PYTHONCONFIG --ldflags`
PKG_CPPFLAGS=`$PYTHONCONFIG --includes`

# Find the .so library for python
: ${PYTHON=`which ${MYPYTHON}`}
if test -z "${PYTHON}"; then
  echo "could not locate ${MYPYTHON}"
  exit 1
fi

PYTHONLIBFILE=libpython`$PYTHON -c "import sys; print(sys.version[[:3]])"`.so
PKG_CPPFLAGS="$PKG_CPPFLAGS -D PYTHONLIBFILE=\\\"$PYTHONLIBFILE\\\""

AC_SUBST(PKG_LIBS)
AC_SUBST(PKG_CPPFLAGS)

AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
