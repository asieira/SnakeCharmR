#' Remove a Python variable from R
#' 
#' This function uses the \code{del} Python command to remove a variable and reclaim
#' its memory. Any exceptions, such as the one that would happen if the variable did
#' not exist, will be caught and ignored.
#' 
#' @param var.name a character string containing a valid Python variable name
#' @export
#' @examples 
#' py.assign("a", "foo bar")
#' py.get("a")
#' # [1] "foo bar"
#' \dontrun{
#' py.rm("a")
#' py.get("a")
#' # Error in py.get("a") (from py.get.R#56) : NameError("name 'a' is not defined",)
#' }
py.rm <- function(var.name) {
  # parameter validation
  if (missing(var.name) || !is.character(var.name) || is.na(var.name) || length(var.name) != 1)
    stop("Bad or missing var.name parameter")

  rcpp_Py_run_code(sprintf("try:\n    del %s\nexcept Exception:\n    pass", var.name))
  invisible(NULL)
}

