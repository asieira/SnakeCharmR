py.exec <- function(code, stopOnException = TRUE) {
  # execute code with exception handling
  on.exit(py.rm("_SnakeCharmR_exception"))
  rcpp_Py_run_code(
    sprintf(
      "try:\n%s\nexcept BaseException as e:\n    _SnakeCharmR_exception = json.dumps(repr(e))",
      paste0("    ", unlist(sapply(code, stringr::str_split, "\n|\r\n"), use.names = F),
             collapse = "\n")
    )
  )

  # try to read the stored exception
  retval = rcpp_Py_get_var("_SnakeCharmR_exception")
  if (!is.na(retval)) {
    if (stopOnException)
      stop(.py.fromJSON(retval))
    else
      return(.py.fromJSON(retval))
  }

  return(invisible(NULL))
}



