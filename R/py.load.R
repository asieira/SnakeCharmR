python.load <- function(file, get.exception = TRUE){
  python.exec(readLines(file), get.exception = get.exception)
}



