#' Remove a python variable
#' 
#' @param var.name a character string containing a valid python variable name
#' @return invisible result of python `del` operation.
#' @keywords manip
#' @export
py.rm <- function(var.name) {
  # parameter validation
  if (missing(var.name) || !is.character(var.name) || is.na(var.name) || length(var.name) != 1)
    stop("Bad or missing var.name parameter")

  invisible(rcpp_Py_run_code(sprintf("try:\n    del %s\nexcept Exception:\n    pass", var.name)))
}

