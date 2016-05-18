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

