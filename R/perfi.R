#' @title Reading transaction spreadsheet and output personal finance statistics
#' @description
#' @importFrom utils read.csv
#' @export
#'
#'

# read boa transaction data
read_boa <- function(data_url, ...) {
  data <- utils::read.csv(data_url, skip = 6)
  return(data)
}
