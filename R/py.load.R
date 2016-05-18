#' Executes Python code.
#' 
#' This function runs Python code contained in a file.  Typically, this file
#' would contain functions to be called via \code{\link{py.call}} or other
#' functions in this package.
#' 
#' The \code{get.exception} option allows the user to disregard Python
#' exceptions in cases where safe calls to avoid the overhead of checking for
#' them.
#' 
#' @param file a file containing python code to be executed
#' @param get.exception logical value indicating whether to check or not for
#' exceptions in Python
#' @return None.  If the code produces some output, it is up to the caller to
#' go and fetch if from Python using function \code{\link{py.get}}.
#' @keywords manip
#' @export
#' @examples
#' a <- 1:4
#' b <- 5:8
#' 
#' # this file contains the definition of function concat
#' py.load( system.file( "concat.py", package = "rPython" ) )
#' py.call( "concat", a, b)
py.load <- function(file, get.exception = TRUE){
  py.exec(readLines(file), stopOnException = get.exception)
}



