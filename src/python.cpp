#include <Rcpp.h>
using namespace Rcpp;

#include <string.h>

#include <Python.h>
#include <bytesobject.h>

#if PY_MAJOR_VERSION >= 3
wchar_t *SnakeCharmR_program_name = NULL;
#else
char *SnakeCharmR_program_name = NULL;
#endif

// [[Rcpp::export]]
void rcpp_Py_Initialize(String command) {
  SnakeCharmR_program_name =
#if PY_MAJOR_VERSION >= 3
    Py_DecodeLocale(command.get_cstring(), NULL);
#else
    strdup(command.get_cstring());
#endif

  Py_SetProgramName(SnakeCharmR_program_name);
  Py_Initialize();
  PyRun_SimpleString("import json");
  PyRun_SimpleString("import traceback");
  PyRun_SimpleString("import sys");
}

// [[Rcpp::export]]
void rcpp_Py_Finalize() {
  Py_Finalize();
  if (SnakeCharmR_program_name != NULL) {
#if PY_MAJOR_VERSION >= 3
    PyMem_RawFree(SnakeCharmR_program_name);
#else
    free(SnakeCharmR_program_name);
#endif
    SnakeCharmR_program_name = NULL;
  }
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
String rcpp_Py_get_var(String varname) {
  PyObject *value = PyDict_GetItemString(PyModule_GetDict(PyImport_AddModule("__main__")),
                                         varname.get_cstring());
  if (value == NULL)
    return NA_STRING;
  
  if (PyUnicode_Check(value)) {
#if RCPP_VERSION > Rcpp_Version(0,12,6)
    String retval(PyBytes_AS_STRING(PyUnicode_AsUTF8String(value)), CE_UTF8);
#else
    String retval(PyBytes_AS_STRING(PyUnicode_AsUTF8String(value)));
    retval.set_encoding("UTF-8");
#endif
    return retval;
  } else if (PyBytes_Check(value))
    return String(PyBytes_AS_STRING(value));
  else
    throw std::invalid_argument("variable is not a string");
}
