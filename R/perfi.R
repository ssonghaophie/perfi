#' @title Reading transaction spreadsheet and output personal finance statistics
#' @description
#' @importFrom utils read.csv dplyr mutate
#' @export
#'
#'

# read boa transaction data
read_boa <- function(data_url, ...) {
  # read csv
  data <- utils::read.csv(data_url, skip = 5)
  # drop unnecessary row, column
  data <- data[-1, -4]
  # create a column for expenditure, deposit
  data <- data |>
    dplyr::mutate(Status = ifelse(Amount < 0, "Expenditure", "Deposit"))
  return(data)
}
