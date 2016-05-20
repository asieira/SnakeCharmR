#' Executes arbitrary Python code from R
#' 
#' This function runs Python code that is provided in a character vector.
#' 
#' The character vector containing the code to execute may consist of a single
#' string with EOL and indentation characters embedded.
#' 
#' Alternatively, it can be a character vector, each entry containing one or
#' more lines of Python code.
#' 
#' @param code a character vector containing Python code, typically a
#' single line with indentation and EOL characters as required by Python syntax
#' @param stopOnException logical value indicating whether or not to call \code{stop}
#' if a Python exception occurs
#' @return if \code{stopOnException} is \code{FALSE}, returns a character vector of
#' length 1 with a representation of any raised Python exceptions. Otherwise, returns 
#' NULL invisibly.
#' @keywords manip
#' @export
#' @examples
#' a <- 1:4
#' b <- 5:8
#' py.exec(c("def concat(a,b):", "\treturn a+b"))
#' py.call("concat", a, b)
#' # [1] 1 2 3 4 5 6 7 8
#' 
#' \dontrun{
#' py.exec("raise Exception('Stop the presses!')")
#' # Error in py.exec("raise Exception('Stop the presses!')") (from py.exec.R#41) : 
#' #   Exception('Stop the presses!',)
#' }
#' 
#' py.exec("raise Exception('Houston, we have a problem!')", stopOnException = FALSE)
#' # [1] "Exception('Houston, we have a problem!',)"
#' 
#' str(py.exec("a = 'nothing to see here'"))
#' #  NULL
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
    retval = .py.fromJSON(retval)
    if (stopOnException)
      stop(retval)
  } else {
    retval <- invisible(NULL)
  }

  return(retval)
}



