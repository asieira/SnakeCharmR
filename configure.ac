# Process this file with autoconf to produce a configure script.
# This file is based on configure.ac file distributed along with the rJava package

AC_INIT(SnakeCharmR, 1.0.7, alexandre.sieira@gmail.com)
AC_CONFIG_SRCDIR([src])

PYTHON_CONFIG=python${SNAKECHARMR_PYTHON_VERSION}-config
command -v ${PYTHON_CONFIG} >/dev/null 2>&1 || { echo "Cannot find command '${PYTHON_CONFIG}'. Aborting."; exit 1; }
echo Using ${PYTHON_CONFIG}...

# find user defined python version, if set
if test -z "${SNAKECHARMR_PYTHON_VERSION}"; then
  command -v python >/dev/null 2>&1 || { echo "Cannot find command '${PYTHON_INTERPRETER}'. Aborting."; exit 1; }
  SNAKECHARMR_PYTHON_VERSION=`python -c "import sys; print(str(sys.version_info.major) + '.' + str(sys.version_info.minor))"`
  echo Found Python version ${SNAKECHARMR_PYTHON_VERSION}...
fi

PKG_LIBS=`$PYTHON_CONFIG --ldflags`
PKG_CPPFLAGS=`$PYTHON_CONFIG --includes`
PKG_CPPFLAGS+=" -D PYTHONLIBFILE=\\\"libpython${SNAKECHARMR_PYTHON_VERSION}.so\\\""

AC_SUBST(PKG_LIBS)
AC_SUBST(PKG_CPPFLAGS)

AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT

echo --------[[begin src/Makevars]]--------
cat src/Makevars
echo --------[[end src/Makevars]]--------
