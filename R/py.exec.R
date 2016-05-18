#' Executes Python code contained in an R character vector.
#' 
#' This function runs Python code.  It needs to be provided by the caller in a
#' character vector.
#' 
#' The vector may consists of a single string with EOL and indentation
#' characters embedded.
#' 
#' Alternatively, it can be a character vector, each entry containing one or
#' more lines of Python code.
#' 
#' The \code{get.exception} option allows the user to disregard Python
#' exceptions in cases where safe calls to avoid the overhead of checking for
#' them.
#' 
#' @param code a character vector containing Python code, typically a
#' single line with indentation and EOL characters as required by Python syntax
#' @param stopOnException logical value indicating whether to check or not for exceptions in Python
#' @return None.  If the code produces some output, it is up to the caller to
#' go and fetch if from Python.
#' @keywords manip
#' @export
#' @examples
#' a <- 1:4
#' b <- 5:8
#' py.exec( c( "def concat(a,b):", "\treturn a+b" ) )
#' py.call( "concat", a, b)
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



