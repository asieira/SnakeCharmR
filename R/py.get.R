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

