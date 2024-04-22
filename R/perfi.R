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
  # converting date to Date format
  data$Date <- as.Date(data$Date, "%m/%d/%y")
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

#' @title Calculating average spending (by day and week)
#' @description
#' @importFrom
#' @export

avg_spend <- function(data, ...) {
  total_spd <- abs(sum(ifelse(data$Status == "Expenditure", data$Amount, NA), na.rm = TRUE))
  num_day <- as.numeric(difftime(max(data$Date), min(data$Date)))
  num_wk <- round(as.numeric(num_day/7), digits = 2)
  avg <- data.frame("Average by" = c("Day", "Week"),
             "Spending" = c(round(total_spd/num_day, digits = 2), round(total_spd/num_wk, digits = 2))
  )
  return(avg)
}

