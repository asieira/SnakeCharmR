#' Assign values to Python variables from R
#' 
#' \code{py.assign} assigns values to variables in Python.
#' Objects are serialized as JSON strings on R with \code{jsonlite::toJSON},
#' are transferred to Python and are converted back to a Python value using
#' \code{json.loads}.
#' 
#' @param var.name a character string containing a valid Python variable name
#' @param value an R object whose equivalent wants to be assigned to the
#' variable in Python
#' @param json.opt.args explicit arguments to pass to \code{jsonlite::toJSON} 
#' when serializing the value
#' @export
#' @examples
#' py.assign("a", 1:4)
#' py.get("a")
#' # [1] 1 2 3 4
#' 
#' py.assign("b", list(one = 1, foo = "bar"))
#' str(py.get("b"))
#' # List of 2
#' #  $ foo: chr "bar"
#' #  $ one: int 1
#' 
#' py.exec("import math")
#' py.get("math.pi")
#' # [1] 3.141593
#' 
#' # by default jsonlite::toJSON is called on the value to be assigned
#' # with auto_unbox = TRUE, so vectors of length 1 are simplified to
#' # scalar values in Python
#' py.assign("c", "foo bar")
#' py.exec("crepr = repr(c)")
#' py.get("crepr")
#' # [1] "u'foo bar'"
#' 
#' # if we explicitly set auto_unbox to FALSE, a vector of length 1
#' # becomes a Python list of length 1
#' py.assign("d", "foo bar", json.opt.args = list(auto_unbox = FALSE))
#' py.exec("drepr = repr(d)")
#' py.get("drepr")
#' # [1] "[u'foo bar']"
py.assign <- function(var.name, value,
                      json.opt.args = getOption("SnakeCharmR.json.opt.args", 
                                                list(auto_unbox = TRUE, null = "null"))) {
  # input validation
  if (missing(var.name) || !is.character(var.name) || is.na(var.name) || length(var.name) != 1)
    stop("Bad or missing var.name parameter")
  if (!is.list(json.opt.args))
    stop("Bad json.opt.args parameter")

  # assign value to variable and then convert from JSON
  py.exec(paste0(var.name, " = ", .py.toJSON(value, json.opt.args)))

  return(invisible(NULL))
}
