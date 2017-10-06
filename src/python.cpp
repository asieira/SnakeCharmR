#include <Rcpp.h>
using namespace Rcpp;

#include <Python.h>
#include <string.h>
#include <bytesobject.h>

#if !defined(_WIN32) && !defined(WIN32)
#include <dlfcn.h>
#endif

// fix R check warning as per https://github.com/RcppCore/Rcpp/issues/636#issuecomment-280985661
// void R_init_SnakeCharmR(DllInfo* info) {
//   R_registerRoutines(info, NULL, NULL, NULL, NULL);
//   R_useDynamicSymbols(info, TRUE);
// }

// [[Rcpp::export]]
void rcpp_Py_Initialize() {
#if !defined(_WIN32) && !defined(WIN32)
  dlopen( PYTHONLIBFILE, RTLD_NOW | RTLD_GLOBAL );		// Passed as a macro at compile time
#endif
  
  Py_Initialize();
  PyRun_SimpleString("import json");
  PyRun_SimpleString("import traceback");
  PyRun_SimpleString("import sys");
}

// [[Rcpp::export]]
void rcpp_Py_Finalize() {
  Py_Finalize();
}

// [[Rcpp::export]]
int rcpp_Py_run_code(String code) {
#if RCPP_VERSION > Rcpp_Version(0,12,6)
  if (code.get_encoding() != CE_UTF8)
    code.set_encoding(CE_UTF8);
#else
  if (code.get_encoding() != "UTF-8")
    code.set_encoding("UTF-8");
#endif
  code.push_front("# -*- coding: utf-8 -*-\n");
  return PyRun_SimpleString(code.get_cstring());
}

// [[Rcpp::export]]
RawVector rcpp_Py_get_var(String varname) {
  PyObject *value = PyDict_GetItemString(PyModule_GetDict(PyImport_AddModule("__main__")),
                                         varname.get_cstring());
  if (value == NULL)
    return RawVector(0);

  char *str;
  if (PyUnicode_Check(value)) {
#if RCPP_VERSION > Rcpp_Version(0,12,6)
    str = PyBytes_AS_STRING(PyUnicode_AsUTF8String(value));
#else
    str = PyBytes_AS_STRING(PyUnicode_AsUTF8String(value));
#endif
  } else if (PyBytes_Check(value))
    str = PyBytes_AS_STRING(value);
  else
    throw std::invalid_argument("variable is not a string");
  
  RawVector retval(0);
  while (*str != 0) {
    retval.push_back(*str);
    str++;
  }
  return retval;
}
