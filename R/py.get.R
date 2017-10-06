#' Get values from Python variables to R
#' 
#' \code{py.get} get the value of Python and returns it to the R environment.
#' Objects are serialized as JSON strings on Python with \code{json.dumps},
#' are transferred to R and are converted back to an R value using
#' \code{jsonlite::fromJSON}.
#' 
#' @param var.name a character string containing a valid Python variable name
#' @param json.opt.ret explicit arguments to pass to \code{jsonlite::fromJSON} 
#' when deserializing the value
#' @return an R object containing the variable value after serialization to JSON
#' in the Python environment and deserialization from JSON in the R environment
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
#' \dontrun{
#' py.rm("notset")
#' py.get("notset")
#' # Error in py.get("notset") (from py.get.R#60) : Traceback (most recent call last):
#' #   File "<string>", line 2, in <module>
#' # NameError: name 'notset' is not defined
#' }
py.get <- function(var.name, json.opt.ret = getOption("SnakeCharmR.json.opt.ret", list())) {
  # parameter validation
  if (missing(var.name) || !is.character(var.name) || is.na(var.name) || length(var.name) != 1)
    stop("Bad or missing var.name parameter")
  if (!is.list(json.opt.ret))
    stop("Bad json.opt.ret parameter")

  # get variable value
  rcpp_Py_run_code(
    sprintf("try:\n    _SnakeCharmR_return = json.dumps(%s)\nexcept:\n    _SnakeCharmR_exception = traceback.format_exc()", 
            var.name)
  )

  # try to read the return value
  retval = rcpp_Py_get_var("_SnakeCharmR_return")
  if (length(retval) != 0) {
    py.rm("_SnakeCharmR_return")
    return(.py.fromJSON(retval, json.opt.ret))
  }

  # value does not exist, stop with the exception value
  exception = rcpp_Py_get_var("_SnakeCharmR_exception")
  if (length(exception) == 0)
    stop(sprintf("Unexpected error reading %s, JSON encoded return value nor exception exist",
                 var.name))
  py.rm("_SnakeCharmR_exception")
  stop(rawToChar(exception))
}

