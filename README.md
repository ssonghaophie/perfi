
<!-- README.md is generated from README.Rmd. Please edit that file -->

# perfi

<!-- badges: start -->

[![R-CMD-check](https://github.com/ssonghaophie/perfi/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ssonghaophie/perfi/actions/workflows/R-CMD-check.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/perfi)](https://CRAN.R-project.org/package=perfi)
<!-- badges: end -->

### Overview

Perfi is a personal finance R package that provides a suite of tools for
importing, cleaning, analyzing, and visualizing personal finance
transaction data from different sources like Bank of America and US Bank
accounts. More specifically, Perfi features functions which allows users
to import and clean their bank transactions, visualize expenditure
distribution, budget their income, calculate average spending and
summarize their personal finance statistics. The package currently
contains dependencies on dplyr, utils, RColorBrewer, graphics and
ggplot2.

### Target Audience

This package was developed with the goal of simplifying personal finance
analysis for individuals of all backgrounds. Whether you’re a seasoned
financial analyst or someone new to managing finances, our aim is to
provide an accessible and intuitive tool for analyzing bank statements.
Our package offers a user-friendly interface and actionable insights to
help users gain a comprehensive understanding of their financial
situation.

### Installation

You can install the development version of perfi from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ssonghaophie/perfi")
#> Downloading GitHub repo ssonghaophie/perfi@HEAD
#> munsell    (0.5.0 -> 0.5.1) [CRAN]
#> gtable     (0.3.4 -> 0.3.5) [CRAN]
#> tidyselect (1.2.0 -> 1.2.1) [CRAN]
#> ggplot2    (3.4.4 -> 3.5.1) [CRAN]
#> Installing 4 packages: munsell, gtable, tidyselect, ggplot2
#> Installing packages into '/private/var/folders/rd/9w0kch9d007c_h3yj9pn0xlr0000gn/T/Rtmp0ksbVV/temp_libpath1d4228db59a'
#> (as 'lib' is unspecified)
#> 
#> The downloaded binary packages are in
#>  /var/folders/rd/9w0kch9d007c_h3yj9pn0xlr0000gn/T//RtmpJBf232/downloaded_packages
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/private/var/folders/rd/9w0kch9d007c_h3yj9pn0xlr0000gn/T/RtmpJBf232/remotes20d517b1f30c/ssonghaophie-perfi-360589e/DESCRIPTION’ ... OK
#> * preparing ‘perfi’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘perfi_0.0.0.9000.tar.gz’
#> Installing package into '/private/var/folders/rd/9w0kch9d007c_h3yj9pn0xlr0000gn/T/Rtmp0ksbVV/temp_libpath1d4228db59a'
#> (as 'lib' is unspecified)
```

### Datasets Included

- `boa_example_data`: A CSV that contains Bank of America transactions.
- `boa_example_data`: A CSV that contains Bank of America transactions
  including information such as beginning the balance, ending balance,
  date, description, amount and running balance.
- `usbs_example_data`: A CSV that contains US Bank transactions
  including information such as date, transaction, name, memo, amount.

### Functions Included

Functions inside the package: + `read_example`: Retrieves file paths for
example transaction data files in the “perfi” package’s directory. +
`read_boa`: Reads, cleans, categorizes, and assigns categories to Bank
of America transaction data. + `summary_stats`: Generates summary tables
of personal finance statistics, calculating totals grouped by
transaction status. + `avg_spend`: Calculates average daily and weekly
spending from transaction data and visualizes weekly spending trends. +
`budget_income`: Calculates budget allocations for needs, wants, and
savings based on user income and preferences. + `read_USBank`: Reads,
cleans, categorizes, and assigns categories to US Bank transaction data
from a specified URL. + `generate_pie`: Creates a pie chart illustrating
expenditure distribution by category based on transaction data.

### Package Usage Examples

Load perfi R package.

``` r
# Load the package 
library(perfi)
```

## Contributors

- Olivia Wang
- Sophie Song
- Rachel Tolentino.
