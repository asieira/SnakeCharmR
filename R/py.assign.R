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
