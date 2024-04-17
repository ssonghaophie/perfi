#' @title Reading transaction spreadsheet
#' @description
#' @importFrom utils read.csv
#' @importFrom dplyr mutate
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


#' @title Creating summary tables and visualizations of personal finance statistics
#' @description
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @export

summary_stats <- function(data, ...) {
  total <- data |>
    dplyr::group_by(Status) |>
    dplyr::summarize(sum(Amount))
  colnames(total) <- c("Status", "Total")
  return(total)
}
