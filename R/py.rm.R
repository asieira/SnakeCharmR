#' Remove a Python variable from R
#' 
#' This function uses the \code{del} Python command to remove a variable and reclaim
#' its memory. Any exceptions, such as the one that would happen if the variable did
#' not exist, will be caught and ignored.
#' 
#' @param var.name a character string containing a valid Python variable name
#' @param stopOnException if \code{TRUE} then \code{stop} will be called if a 
#' Python exception occurs, typically because the variable doesn't exist, 
#' otherwise only a warning will be flagged
#' @export
#' @examples 
#' py.assign("a", "foo bar")
#' py.get("a")
#' # [1] "foo bar"
#' py.rm("a")
#' \dontrun{
#' py.rm("a")
#' # Warning message:
#' # In py.rm("a") : NameError("name 'a' is not defined",) 
#' }
py.rm <- function(var.name, stopOnException = FALSE) {
  # parameter validation
  if (missing(var.name) || !is.character(var.name) || is.na(var.name) || length(var.name) != 1)
    stop("Bad or missing var.name parameter")

  rcpp_Py_run_code(
    sprintf(
      "try:\n    del %s\nexcept BaseException as e:\n    _SnakeCharmR_exception = json.dumps(repr(e))",
      var.name
    )
  )
  
  # try to read the stored exception
  exception = rcpp_Py_get_var("_SnakeCharmR_exception")
  if (!is.na(exception)) {
    rcpp_Py_run_code("del _SnakeCharmR_exception")
    exception = .py.fromJSON(exception)
    if (stopOnException)
      stop(exception)
    else
      warning(exception)
  }
  
  return(invisible(NULL))
}

