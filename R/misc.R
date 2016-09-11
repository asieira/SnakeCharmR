.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    c("SnakeCharmR v1.0.4 - R and Python Integration\n",
      "Contribute and submit issues at https://github.com/asieira/SnakeCharmR")
  )
}

.onLoad <- function(libname, pkgname) {
  rcpp_Py_Initialize()
}

.onUnload <- function(libpath) {
  rcpp_Py_Finalize()
}

.py.toJSON <- function(x, json.options = list()) {
  if (is.null(x))
    return("None")
  paste0(
    "json.loads('''",
    str_replace_all(
      do.call(toJSON, c(json.options, list(x = x))),
      regex("(['\\\\])"),
      "\\\\\\1"
    ),
    "''')"
  )
}

.py.fromJSON <- function(x, json.options = list()) {
  do.call(fromJSON, c(json.options, list(txt = x)))
}
