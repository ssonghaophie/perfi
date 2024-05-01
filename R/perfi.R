
#' @title Getting path to example data
#' @description There are 3 example transaction data files in `inst/extdata` directory of a perfi package.
#' This function returns a file path of the example data to utilize them.
#' @param file Name of example data file in string. Default is `NULL`, and it will list out the example files.
#' @export
#' @examples
#' read_example()
#' read_example("boa_example_data.csv")

read_example <- function(file = NULL) {
  # return list of the data we have if data = NULL
  if (is.null(file)) {
    dir(system.file("extdata", package = "perfi"))
  } else {
    # get the file path
    system.file("extdata", file, package = "perfi", mustWork = TRUE)
  }
}

?read.csv

#' @title Reading transaction spreadsheet of Bank of American Accounts
#' @description This function reads transaction data from Bank of America accounts stored in a CSV file. It removes unnecessary
#' rows and columns, converts the date column to the Date format, categorizes transactions into expenditure or deposit, and assigns categories based on
#' transaction descriptions.
#' @param file Name of the CSV file. It can be an absolute path, relative path, or a complete URL of the data file.
#' @return Dataframe of a transaction data
#' @importFrom utils read.csv
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom dplyr rename
#'
#' @export
#' @examples
#' read_boa(boa_data)
#' read_boa("boa_example_data.csv")

# read boa transaction data
read_boa <- function(file, ...) {
  # read csv
  data <- utils::read.csv(file, skip = 5)
  # drop unnecessary row, column
  data <- data[-1, -4]
  # converting date to Date format
  data$Date <- as.Date(data$Date, "%m/%d/%y")
  # create a column for expenditure, deposit
  data <- data |>
    dplyr::mutate(Status = ifelse(Amount < 0, "Expenditure", "Deposit"))
  # create categories
  data <- data |>
    dplyr::mutate(Desc = gsub(" \\d{2}/\\d{2}.*", "", Description, ignore.case = TRUE)) |>
    dplyr::select(-Description) |>
    dplyr::rename(Description = Desc) |>
    dplyr::mutate(Category =
                    #Transaction
                    ifelse(grepl("Zelle|Online Banking transfer|PAYROLL|ATM", Description, ignore.case = TRUE), "Transaction",
                    # Pharmacy
                    ifelse(grepl("CVS", Description, ignore.case = TRUE), "Pharmacy",
                    # Grocery
                    ifelse(grepl("INSTACART|WEEE|WAL-MART|7-ELEVEN|TRADER JOE S", Description, ignore.case = TRUE), "Grocery",
                    # Food
                    ifelse(grepl("\\*EATS|GRUBHUB|Doordash|CHIPOTLE|T. Roots|Noodles|Oriental Taste|MEXCALITO NOHO", Description, ignore.case = TRUE), "Food",
                    # Drink and Desserts
                    ifelse(grepl("WOODSTAR|MOCHINUT|HUI LAO SHAN|MOCHA EMPORIUM|THE ROOST|COFFEE", Description, ignore.case = TRUE), "Drink and Dessert",
                    # Transportation
                    ifelse(grepl("Zipcar|UBER|LYFT|PVTA|NJT", Description, ignore.case = TRUE), "Transportation",
                    # Clothes
                    ifelse(grepl("URBAN OUTFITTRS|NIKE|American Eagle|FOREVER21|ALTAR'D STATE", Description, ignore.case = TRUE), "Clothes",
                    # Entertainment
                    ifelse(grepl("CINEMARK THEATRES|SPOTIFY", Description, ignore.case = TRUE), "Entertainment",
                    # Shopping
                    ifelse(grepl("THE VAULT|PAISABOYS|BLUE BOTTLE COFFEE|BARNES & NOBLE|PIER PROVISIONS|BOOKSHOP|ZUMIEZ|APPLE.COM", Description, ignore.case = TRUE), "Shopping",
                    # Miscellaneous
                    "Misc."
                     ))))))))))
  return(data)
}

#' @title Creating summary tables and visualizations of personal finance statistics
#' @description This function generates summary tables and visualizations of personal finance statistics based on the provided data. It calculates totals
#' grouped by transaction status (expenditure or deposit) and returns a summary table.
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

#' @title Calculating average spending (by day and week) and visualizing weekly spending
#' @description This function calculates the average spending per day and per week based on the provided transaction data. It then visualizes the weekly
#' spending along with the average spending trend over time.
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom dplyr mutate
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 geom_col
#' @importFrom ggplot2 scale_fill_brewer
#' @importFrom ggplot2 geom_line
#' @importFrom ggplot2 labs
#' @importFrom ggplot2 aes
#' @export

avg_spend <- function(data, ...) {
  spend <- data |>
    dplyr::filter(Amount < 0)
  # changing values from negative to positive for graphing purposes
  spend$Amount <- abs(spend$Amount)
  # for avg spending
  ttl <- sum(spend$Amount)
  time <- as.numeric(difftime(max(spend$Date), min(spend$Date)))
  # creating new columns and grouping rows
  spend <- spend |>
    dplyr::select(-Description, -Status) |>
    dplyr::mutate(week = cut.Date(Date, breaks = "week", labels = FALSE)) |>
    dplyr::group_by(week) |>
    dplyr::summarize(sum(Amount)) |>
    dplyr::mutate(avg_spending = round(ttl/time*7, digits = 2))
  # change col name
  colnames(spend) <- c("week", "wk_spend", "avg_spend")
  # creating graph
  plot <- ggplot2::ggplot(data = spend) +
    ggplot2::geom_col(ggplot2::aes(x = week,
                 y = wk_spend,
                 fill = factor(week))) +
    ggplot2::scale_fill_brewer(palette = "Set3")  +
    ggplot2::geom_line(ggplot2::aes(x = week,
                  y = avg_spend),
              linetype = 2,
              size = 2,
              col = "#9bb8ed") +
    ggplot2::labs(title = "Weekly Spending",
         x = "Week",
         y = "Spending",
         fill = "Week")
  return(plot)
}

#' @title Returns income budgeted for user
#' @description This function calculates and returns a budget for the user based on their income and specified percentages they want allocated for their
#' needs, wants, and savings. The budget can be calculated for different income frequencies such as weekly or bi-weekly.
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
#' @description This function reads transaction data from US Bank accounts stored in a CSV file located at the specified URL. It performs necessary data
#' manipulation steps such as dropping unnecessary rows or columns, converting the date column to the Date format, extracting descriptions from transaction names,
#' categorizing transactions into different categories, and creating a column for expenditure and deposit based on transaction amounts.
#' @importFrom utils read.csv
#' @importFrom dplyr mutate
#' @export

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

  # create categories
  data <- data |>
    dplyr::mutate(Description  = gsub(" \\d{2}/\\d{2}.*", "", Name, ignore.case = TRUE)) |>
    dplyr::mutate(Category =
                    #Transaction
                    ifelse(grepl("Zelle|Online Banking transfer|PAYROLL|ATM|DEPOSIT", Description, ignore.case = TRUE), "Transaction",
                    # Pharmacy
                    ifelse(grepl("CVS", Description, ignore.case = TRUE), "Pharmacy",
                    # Grocery
                    ifelse(grepl("INSTACART|WEEE|WAL-MART|7-ELEVEN|TRADER JOE S", Description, ignore.case = TRUE), "Grocery",
                    # Food
                    ifelse(grepl("\\*EATS|GRUBHUB|Doordash|CHIPOTLE|T. Roots|Noodles|Oriental Taste|MEXCALITO NOHO", Description, ignore.case = TRUE), "Food",
                    # Drink and Desserts
                    ifelse(grepl("WOODSTAR|MOCHINUT|HUI LAO SHAN|MOCHA EMPORIUM|THE ROOST|COFFEE", Description, ignore.case = TRUE), "Drink and Dessert",
                    # Transportation
                    ifelse(grepl("Zipcar|UBER|LYFT|PVTA|NJT", Description, ignore.case = TRUE), "Transportation",
                    # Clothes
                    ifelse(grepl("URBAN OUTFITTRS|NIKE|American Eagle|FOREVER21|ALTAR'D STATE", Description, ignore.case = TRUE), "Clothes",
                    # Entertainment
                    ifelse(grepl("CINEMARK THEATRES|SPOTIFY", Description, ignore.case = TRUE), "Entertainment",
                    # Shopping
                    ifelse(grepl("THE VAULT|PAISABOYS|BLUE BOTTLE COFFEE|BARNES & NOBLE|PIER PROVISIONS|BOOKSHOP|ZUMIEZ|APPLE.COM", Description, ignore.case = TRUE), "Shopping",
                    # Miscellaneous
                    "Misc."
                    ))))))))))
  data <- data[, -2]
  # Create a column for expenditure, deposit
  data <- data |>
    dplyr::mutate(Status = ifelse(Amount < 0, "Expenditure", "Deposit"))

  # Return the processed data
  return(data)
}

#' @title Creating a pie chart for imported transaction sheet
#' @description
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom RColorBrewer brewer.pal
#' @importFrom graphics pie
#' @export

generate_pie <- function(data, ...) {
  pie_table <- data |>
    dplyr::group_by(Category) |>
    dplyr::summarize(sum(Amount))
  colnames(pie_table) <- c("pie", "total")
  pie_table$total <- abs(pie_table$total)

  slice <- pie_table$total
  lbl <- pie_table$pie
  colors <- RColorBrewer::brewer.pal(n = length(slice), name = "Set3")

  graphics::pie(slice, labels = lbl, main = "Expenditure by Category", col = colors, cex = 0.9)
}


