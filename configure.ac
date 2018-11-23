# Process this file with autoconf to produce a configure script.
# This file is based on configure.ac file distributed along with the rJava package

AC_INIT(SnakeCharmR, 1.0.7, alexandre.sieira@gmail.com)
AC_CONFIG_SRCDIR([src])

if ! test -z "${SNAKECHARMR_PYTHONPATH}"; then
  PYTHONPATH=${SNAKECHARMR_PYTHONPATH}
elif test -z "${PYTHONPATH}"; then
  echo "PYTHONPATH is not set, if installation fails you might want to try setting it."
  echo "References:"
  echo "  https://docs.python.org/2/using/cmdline.html#environment-variables"
  echo "  https://docs.python.org/3/using/cmdline.html#environment-variables for more information"
fi
echo "PYTHONPATH=${PYTHONPATH}"

PYTHON_CONFIG=python${SNAKECHARMR_PYTHON_VERSION}-config
command -v ${PYTHON_CONFIG} >/dev/null 2>&1 || { echo "Cannot find command '${PYTHON_CONFIG}'. Aborting."; exit 1; }
echo "Using Python config ${PYTHON_CONFIG}"

if test -n "${SNAKECHARMR_PYTHON_INTERPRETER}"; then
  command -v ${SNAKECHARMR_PYTHON_INTERPRETER} >/dev/null 2>&1 || { echo "Cannot find command '${SNAKECHARMR_PYTHON_INTERPRETER}'. Aborting."; exit 1; }
elif command -v python${SNAKECHARMR_PYTHON_VERSION} --version  >/dev/null 2>&1; then
  SNAKECHARMR_PYTHON_INTERPRETER=python${SNAKECHARMR_PYTHON_VERSION}
elif command -v `${PYTHON_CONFIG} --prefix`/bin/python${SNAKECHARMR_PYTHON_VERSION} --version  >/dev/null 2>&1; then
  SNAKECHARMR_PYTHON_INTERPRETER=`${PYTHON_CONFIG} --prefix`/bin/python${SNAKECHARMR_PYTHON_VERSION}
elif command -v `${PYTHON_CONFIG} --prefix`/bin/python --version  >/dev/null 2>&1; then
  SNAKECHARMR_PYTHON_INTERPRETER=`${PYTHON_CONFIG} --prefix`/bin/python
elif command -v python --version  >/dev/null 2>&1; then
  SNAKECHARMR_PYTHON_INTERPRETER=python
fi
echo "Using Python interpreter ${SNAKECHARMR_PYTHON_INTERPRETER}"

# find user defined python version, if set
if test -z "${SNAKECHARMR_PYTHON_VERSION}"; then
  SNAKECHARMR_PYTHON_VERSION=`${SNAKECHARMR_PYTHON_INTERPRETER} -c "import sys; print(str(sys.version_info.major) + '.' + str(sys.version_info.minor))"`
fi
echo "Using Python version ${SNAKECHARMR_PYTHON_VERSION}"

${PYTHON_CONFIG} --ldflags
PKG_LIBS=`${PYTHON_CONFIG} --ldflags`
echo PKG_LIBS=$PKG_LIBS

PKG_CPPFLAGS=`${PYTHON_CONFIG} --includes`
echo PKG_CPPFLAGS=$PKG_CPPFLAGS

#PKG_CPPFLAGS+=" -D PYTHONLIBFILE=\\\"libpython${SNAKECHARMR_PYTHON_VERSION}.so\\\""

AC_SUBST(PKG_LIBS)
AC_SUBST(PKG_CPPFLAGS)

AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT

echo --------[[begin src/Makevars]]--------
cat src/Makevars
echo --------[[end src/Makevars]]--------
