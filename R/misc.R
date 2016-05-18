.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    c("SnakeCharmR v1.0.0 - R and Python Integration\n",
      "Contribute and submit issues at https://github.com/asieira/SnakeCharmR")
  )
}

.onLoad <- function(libname, pkgname) {
  rcpp_Py_Initialize()
}

.onUnload <- function(libpath) {
  rcpp_Py_Finalize()
  library.dynam.unload("SnakeCharmR", libpath)
}

.py.toJSON <- function(x, json.options = list()) {
  json.options$x <- x
  paste0(
    "json.loads('''",
    str_replace_all(
      do.call(toJSON, json.options),
      regex("(['\\\\])"),
      "\\\\\\1"
    ),
    "''')"
  )
}

.py.fromJSON <- function(x, json.options = list()) {
  json.options$txt = x
  do.call(fromJSON, json.options)
}
