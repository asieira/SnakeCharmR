py.rm <- function(var.name) {
  # parameter validation
  if (missing(var.name) || !is.character(var.name) || is.na(var.name) || length(var.name) != 1)
    stop("Bad or missing var.name parameter")

  invisible(rcpp_Py_run_code(sprintf("try:\n    del %s\nexcept Exception:\n    pass", var.name)))
}

