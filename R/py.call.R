#' Calls Python functions and methods from R
#' 
#' This function runs a Python function taking as arguments R objects and
#' returning an R object.  Some limitations exist as to the nature of the
#' objects that can be passed between R and Python.  As of this writing, atomic
#' arguments and vectors are supported.
#' 
#' The user has to be careful to indicate named parameters as required
#' according to Python conventions.
#' 
#' @param fname name of function/method to call
#' @param ...  R objects to pass as arguments to the Python function or method
#' @param json.opt.args explicit arguments to pass for JSON transformation
#' @param json.opt.ret explicit arguments to pass for JSON transformation
#' @return An R representation of the object returned by the call to the Python function.
#' @keywords manip
#' @export
#' @examples
#' py.call( "len", 1:3 )
#' a <- 1:4
#' b <- 5:8
#' py.exec( "def concat(a,b): return a+b" )
#' py.call( "concat", a, b)
#' 
#' py.assign( "a",  "hola hola" )
#' py.call( "a", "split", " " )
#' 
#' ## simplification of arguments
#' a <- 1
#' b <- 5:8
#' 
#' \dontrun{
#' py.call("concat", a, b)}
#' 
#' # using function I()
#' py.call("concat", I(a), b)
#' 
#' # setting as.is = TRUE
#' py.call("concat", a, b, as.is = TRUE)
py.call <- function(fname, ...,
                    json.opt.args = getOption("SnakeCharmR.json.opt.args", list()),
                    json.opt.ret = getOption("SnakeCharmR.json.opt.ret", list())) {
  if (missing(fname) || !is.character(fname) || is.na(fname) || length(fname) != 1)
    stop("Bad or missing fname parameter")

  # create parameter string
  foo.args <- list(...)
  foo.args.names <- names(foo.args)
  if (length(foo.args) == 0) {
    foo.args.string <- ""
  } else {
    foo.args.string = paste0(
      sapply(
        1:length(foo.args),
        function(i) {
          if (!is.null(foo.args.names) && foo.args.names[i] != "")
            return(sprintf("%s = %s", foo.args.names[i],  .py.toJSON(foo.args[[i]],
                                                                         json.opt.args)))
          else
            return(.py.toJSON(foo.args[[i]], json.opt.args))
        }
      ),
      collapse = ", "
    )
  }
  rm(foo.args, foo.args.names)

  # execute function
  on.exit(py.rm("_SnakeCharmR_return"))
  py.exec(sprintf("_SnakeCharmR_return = json.dumps(%s(%s))", fname, foo.args.string))
  rm(foo.args.string)

  # get return value
  retval <- rcpp_Py_get_var("_SnakeCharmR_return")
  if (is.na(retval))
    stop("Cannot find function call return value")

  return(.py.fromJSON(retval, json.opt.ret))
}

