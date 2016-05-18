#' Assign and get variables in Python from R
#' 
#' Functions that assign and get Python variables from R.
#' 
#' These functions can assign values to variables in Python as well as get
#' their values back to R.  Objects are serialized as json strings while being
#' transferred between R and Python.
#' 
#' @param var.name a character string containing a valid python variable name
#' @param json.opt.ret explicit arguments to pass for JSON transformation
#' @return Function \code{py.get} returns a R version of the Python variable \code{py.var}.
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
py.get <- function(var.name, json.opt.ret = getOption("SnakeCharmR.json.opt.ret", list())) {
  # parameter validation
  if (missing(var.name) || !is.character(var.name) || is.na(var.name) || length(var.name) != 1)
    stop("Bad or missing var.name parameter")
  if (!is.list(json.opt.ret))
    stop("Bad json.opt.ret parameter")

  # get variable value
  on.exit(py.rm("_SnakeCharmR_return"))
  py.exec(sprintf("_SnakeCharmR_return = json.dumps(%s)", var.name))

  retval = rcpp_Py_get_var("_SnakeCharmR_return")
  if (is.na(retval))
      stop(
        sprintf("Unexpected error reading %s, JSON encoded return value does not exist",
                var.name)
      )

  return(.py.fromJSON(retval, json.opt.ret))
}

