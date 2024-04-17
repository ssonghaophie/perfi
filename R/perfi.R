#' @title Reading transaction spreadsheet and output personal finance statistics
#' @description
#' @importFrom utils read.csv
#' @export
#'
#'

# read boa transaction data
read_boa <- function(data_url, ...) {
  # read csv
  data <- utils::read.csv(data_url, skip = 5)
  # drop unnecessary row
  data <- data[-1,]
  return(data)
}
