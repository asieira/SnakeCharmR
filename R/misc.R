.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    sprintf("%s %s - R and Python Integration\n", pkgname, utils::packageVersion(pkgname)),
    "Contribute and submit issues at https://github.com/asieira/SnakeCharmR\n",
    paste(
      "\nPython version", 
      {
        x = paste0(py.get("sys.version"), collapse = "\n");
        if (!is.character(x) || length(x) != 1 || is.na(x)) 
          x = paste0(sapply(0:2, function(x) py.get(sprintf("sys.version_info[%i]", x))),
                     collapse = ".");
        x
      }
    )
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
  if (is.raw(x)) {
    x <- rawConnection(x)
    on.exit(close(x))
  }
  do.call(fromJSON, c(json.options, list(txt = x)))
}
