.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    sprintf("SnakeCharmR %s - R and Python Integration\n", utils::packageVersion("SnakeCharmR")),
    "Contribute and submit issues at https://github.com/asieira/SnakeCharmR\n",
    paste("\nPython version", py.get("sys.version"))
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
