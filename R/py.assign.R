#' Assign and get variables in Python from R
#' 
#' Functions that assign and get Python variables from R.
#' 
#' These functions can assign values to variables in Python as well as get
#' their values back to R.  Objects are serialized as json strings while being
#' transferred between R and Python.
#' 
#' @param var.name a character string containing a valid python variable name
#' @param value an R object whose equivalent wants to be assigned to the
#' variable in python
#' @param json.opt.args explicit arguments to pass for JSON transformation
#' @param ...  other arguments passed to the internal \code{toJSON} function
#' call
#' @return Function \code{py.get} returns a R version of the Python
#' variable \code{py.var}.
#' @references \url{http://code.google.com/p/simplejson}
#' @keywords manip
#' @export
#' @examples
#' a <- 1:4
#' py.assign( "a", a )
#' py.exec( "b = len( a )" )
#' py.get( "b" )
#' 
#' py.exec( "import math" )
#' py.get( "math.pi" )
py.assign <- function(var.name, value,
                      json.opt.args = getOption("SnakeCharmR.json.opt.args", list())) {
  # input validation
  if (missing(var.name) || !is.character(var.name) || is.na(var.name) || length(var.name) != 1)
    stop("Bad or missing var.name parameter")
  if (!is.list(json.opt.args))
    stop("Bad json.opt.args parameter")

  # assign value to variable and then convert from JSON
  py.exec(paste0(var.name, " = ", .py.toJSON(value, json.opt.args)))

  return(invisible(NULL))
}
