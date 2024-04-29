#' @title Reading transaction spreadsheet of Bank of American Accounts
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
  # converting date to Date format
  data$Date <- as.Date(data$Date, "%m/%d/%y")
  # create a column for expenditure, deposit
  data <- data |>
    dplyr::mutate(Status = ifelse(Amount < 0, "Expenditure", "Deposit"))
  # create categories
  data <- data |>
    dplyr::mutate(Desc = gsub(" \\d{2}/\\d{2}.*", "", Description, ignore.case = TRUE))
  data <- data |>
    dplyr::mutate(Category =
                    # Transaction
                    ifelse(grepl("Zelle|Online Banking transfer|PAYROLL|ATM", Description, ignore.case = TRUE), "Transaction",

                    # Pharmacy
                    ifelse(grepl("CVS", Description, ignore.case = TRUE), "Pharmacy",

                    # Grocery
                    ifelse(grepl("INSTACART|WEEE|WAL-MART|7-ELEVEN|TRADER JOE S", Description, ignore.case = TRUE), "Grocery",

                    # Transportation
                    ifelse(grepl("Zipcar|UBER|LYFT|PVTA|NJT", Description, ignore.case = TRUE), "Transportation",

                    # Food
                    ifelse(grepl("\\*EATS|GRUBHUB|Doordash|T. Roots|Noodles|Oriental Taste|
CHIPOTLE|MEXCALITO NOHO", Description, ignore.case = TRUE), "Food",

                    # Clothes
                    ifelse(grepl("URBAN OUTFITTERS|American Eagle|FOREVER21|ALTAR'D STATE", Description, ignore.case = TRUE), "Clothes",

                    # Shopping
                    ifelse(grepl("BLUE BOTTLE COFFEE|BOOKSHOP|THE ROOST|MOCHINUT|HUI LAO SHAN|ZUMIEZ|APPLE.COM", Description, ignore.case = TRUE), "Shopping",

                    Desc))))))))

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
  avg <- data.frame("Average_by" = c("Day", "Week"),
             "Spending" = c(round(total_spd/num_day, digits = 2), round(total_spd/num_wk, digits = 2))
  )
  return(avg)
}

#' @title Returns income budgeted for user
#' @description
#' @importFrom
#' @export

budget_income <- function(income, needs_percent = .5, wants_percent = .3, savings_percent = .2,  freq = "bi-weekly"){
  if (freq == "weekly"){
    income <- income *2
  }
  needs <- income * needs_percent
  wants <- income * wants_percent
  savings <- income * savings_percent

  budget <- list(needs = needs, wants = wants, savings = savings)
  return(budget)
}

#' @title Reading transaction spreadsheet of US Bank Accounts
#' @description
#' @importFrom utils read.csv
#' @importFrom
#' @export
#'
# Define the function to read USBank transaction data
read_USBank <- function(data_url, ...) {
  # Read CSV
  data <- utils::read.csv(data_url)

  # Drop unnecessary rows or columns if needed
  # For example:
  data <- data[, -c(2,4)]

  # Perform additional data manipulation steps if needed
  # For example, creating a column for expenditure and deposit
  # Converting date to Date format
  data$Date <- as.Date(data$Date, "%Y-%m-%d")



  # Create a column for expenditure, deposit
  data <- data |>
    dplyr::mutate(Status = ifelse(Amount < 0, "Expenditure", "Deposit"))

  # Return the processed data
  return(data)
}

# Define the file path
data_url <- "/Users/racheltolentino/documents/sample_data3.csv"
data_url1 <- "/Users/racheltolentino/documents/sample_data2.csv"

# Call the function with the file path

transaction_data <- read_USBank(data_url)
transaction_data2 <- read_boa(data_url1)

