#include <Rcpp.h>
using namespace Rcpp;

#include <Python.h>
#include <string.h>
#include <bytesobject.h>

#ifndef _WIN32
#include <dlfcn.h>
#endif

// [[Rcpp::export]]
void rcpp_Py_Initialize() {
#ifndef _WIN32
  dlopen( PYTHONLIBFILE, RTLD_NOW | RTLD_GLOBAL );		// Passed as a macro at compile time
#endif

  Py_Initialize();
  PyRun_SimpleString("import json");
  PyRun_SimpleString("import traceback");
}

// [[Rcpp::export]]
void rcpp_Py_Finalize() {
  Py_Finalize();
}

// [[Rcpp::export]]
int rcpp_Py_run_code(String code) {
  return PyRun_SimpleString(code.get_cstring());
}

// [[Rcpp::export]]
String rcpp_Py_get_var(String varname) {
  PyObject *result = PyDict_GetItemString(PyModule_GetDict(PyImport_AddModule("__main__")),
                                          varname.get_cstring());
  if (result == NULL)
    return NA_STRING;

#if PY_MAJOR_VERSION >= 3
  return String(PyBytes_AS_STRING(PyUnicode_AsUTF8String(result)));
#else
  return String(PyString_AS_STRING(result));
#endif
}
