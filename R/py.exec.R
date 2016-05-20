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
#' @param stopOnException if \code{TRUE} then \code{stop} will be called if a 
#' Python exception occurs, otherwise only a warning will be flagged
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
#' # Error in py.exec("raise Exception('Stop the presses!')") (from py.exec.R#48) : 
#' #   Traceback (most recent call last):
#' #   File "<string>", line 2, in <module>
#' # Exception: Stop the presses!
#' }
#' 
#' py.exec("raise Exception('Houston, we have a problem!')", stopOnException = FALSE)
#' # Warning message:
#' # In py.exec("raise Exception('Houston, we have a problem!')", stopOnException = FALSE) :
#' #   Traceback (most recent call last):
#' #   File "<string>", line 2, in <module>
#' # Exception: Houston, we have a problem!
py.exec <- function(code, stopOnException = TRUE) {
  # execute code with exception handling
  rcpp_Py_run_code(
    sprintf(
      "try:\n%s\nexcept:\n    _SnakeCharmR_exception = traceback.format_exc()",
      paste0("    ", unlist(sapply(code, stringr::str_split, "\n|\r\n"), use.names = F),
             collapse = "\n")
    )
  )

  # try to read the stored exception
  exception = rcpp_Py_get_var("_SnakeCharmR_exception")
  if (!is.na(exception)) {
    py.rm("_SnakeCharmR_exception")
    if (stopOnException)
      stop(exception)
    else
      warning(exception)
  }

  return(invisible(NULL))
}



