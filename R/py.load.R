#' Reads and executes Python code from a file
#' 
#' This function runs Python code contained in a file. This is basically
#' a convenience function that is the equivalent of \code{py.exec(readLines(file))}.
#' 
#' For better maintainability, it might be worth investigating concentrating
#' more complex Python code that needs to be called from R into proper packages
#' that can be installed using \code{pip} and loaded with 
#' \code{py.exec("import package_name")}.
#' 
#' @param file a connection or file name that will be passed to \code{readLines} to
#' read the Python code in the file
#' @param stopOnException logical value indicating whether to check or not to
#' call \code{stop} if a Python exception occurs
#' @return if \code{stopOnException} is \code{FALSE}, invisibly returns a string
#' representation of any raised Python exceptions or NULL if none occur.
#' @export
py.load <- function(file, stopOnException = TRUE){
  py.exec(readLines(file), stopOnException = stopOnException)
}



