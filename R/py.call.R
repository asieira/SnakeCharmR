#' Calls Python functions and methods from R
#' 
#' This function runs a Python function taking as arguments R objects and
#' returning an R object.  Some limitations exist as to the nature of the
#' objects that can be passed between R and Python, mainly which data types
#' can be converted to/from JSON in R (using \code{jsonlite}) and Python
#' (using the \code{json} module).
#' 
#' @param fname name of function/method to call
#' @param ...  R objects to pass as arguments to the Python function or method
#' @param json.opt.args explicit arguments to pass to \code{jsonlite::toJSON} 
#' when serializing the function argument values
#' @param json.opt.ret explicit arguments to pass to \code{jsonlite::fromJSON} 
#' when deserializing the function return value
#' @return an R object containing the function or method call return value after
#' serialization to JSON in the Python environment and deserialization from JSON
#' in the R environment
#' @export
#' @examples
#' py.call("len", 1:3)
#' # [1] 3
#' 
#' py.call("repr", 1:3)
#' # [1] "[1, 2, 3]"
#' 
#' a <- 1:4
#' b <- 5:8
#' py.exec("def concat(a,b): return a+b")
#' py.call("concat", a, b)
#' # [1] 1 2 3 4 5 6 7 8
#' 
#' py.assign("a",  "hola hola")
#' py.call("a.split", " ")
#' # [1] "hola" "hola"
#' 
#' # by default jsonlite::toJSON is called on the function call arguments
#' # with auto_unbox = TRUE, so vectors of length 1 are simplified to
#' # scalar values in Python
#' py.call("repr", "foo bar")
#' # [1] "u'foo bar'"
#' 
#' # if we explicitly set auto_unbox to FALSE, a vector of length 1
#' # becomes a Python list of length 1
#' py.call("repr", "foo bar", json.opt.args = list(auto_unbox = FALSE))
#' # [1] "[u'foo bar']"
py.call <- function(fname, ...,
                    json.opt.args = getOption("SnakeCharmR.json.opt.args", 
                                              list(auto_unbox = TRUE, null = "null")),
                    json.opt.ret = getOption("SnakeCharmR.json.opt.ret", 
                                             list())) {
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
  py.exec(sprintf("_SnakeCharmR_return = json.dumps(%s(%s))", fname, foo.args.string),
          stopOnException = TRUE)
  rm(foo.args.string)

  # get return value
  retval <- rcpp_Py_get_var("_SnakeCharmR_return")
  if (length(retval) == 0)
    stop("Cannot find function call return value")
  else
    py.rm("_SnakeCharmR_return")

  return(.py.fromJSON(retval, json.opt.ret))
}

