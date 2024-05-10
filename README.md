
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
#> ── R CMD build ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#>      checking for file ‘/private/var/folders/0j/_zd6vh3j60q6c73fmw7nh_4r0000gn/T/RtmpQHWvx9/remotesbf1f68336c19/ssonghaophie-perfi-6418c8e/DESCRIPTION’ ...  ✔  checking for file ‘/private/var/folders/0j/_zd6vh3j60q6c73fmw7nh_4r0000gn/T/RtmpQHWvx9/remotesbf1f68336c19/ssonghaophie-perfi-6418c8e/DESCRIPTION’
#>   ─  preparing ‘perfi’:
#>    checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘perfi_0.0.0.9000.tar.gz’
#>      
#> 
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

# read_example()
boa_data <- read_example("boa_example_data.csv")
boa_data2 <- read_example("boa_example_data2.csv")
usb_data <- read_example("usbs_example_data.csv")

# read_boa()
boa <- read_boa(boa_data)
read_boa(boa_data2)
#>          Date                                                         Description Amount      Status          Category
#> 2  2020-02-16              DD *DOORDASH STARBUCKS 02/15 PURCHASE WWW.DOORDASH. CA -15.38 Expenditure              Food
#> 3  2020-02-16                       Zelle payment to JOHN WILLIAM Conf# dtn8onqc1  -5.14 Expenditure       Transaction
#> 4  2020-02-20                  GRUBHUBORIENTALTASTE 02/16 PURCHASE GRUBHUB.COM NY -17.85 Expenditure              Food
#> 5  2020-02-20                            GRUBHUBCVS 02/18 PURCHASE GRUBHUB.COM NY -17.17 Expenditure          Pharmacy
#> 6  2020-02-20                             CVS/PHARM 0189 02/20 PURCHASE BOSTON MA -40.45 Expenditure          Pharmacy
#> 7  2020-02-23                   Zelle payment from MARY ELIZABETH Conf# x77lowrro   8.80     Deposit       Transaction
#> 8  2020-02-23                     Zelle payment to JENNIFER HUANG Conf# ep2a1con6 -18.00 Expenditure       Transaction
#> 9  2020-02-26                  DD DOORDASH MOGETEE 02/23 PURCHASE 855-973-1040 CA -20.32 Expenditure              Food
#> 10 2020-02-26                              WEEE INC. 02/24 PURCHASE XXXXX34967 CA -75.67 Expenditure           Grocery
#> 11 2020-03-01                   Zelle payment from JENNIFER HUANG Conf# ppdwrdcf6  20.30     Deposit       Transaction
#> 12 2020-03-04      Online Banking transfer from SAV 2109 Confirmation# XXXXX07767  50.00     Deposit       Transaction
#> 13 2020-03-04                         IC* INSTACART 03/03 REFUND HTTPSINSTACAR CA   6.02     Deposit           Grocery
#> 14 2020-03-04                         UEP*ORIENTAL TASTE 03/01 PURCHASE BOSTON MA -40.57 Expenditure              Food
#> 15 2020-03-04                  BLUE BOTTLE COFFEE 03/01 PURCHASE HTTPSBLUEBOTT CA -51.18 Expenditure Drink and Dessert
#> 16 2020-03-04                  BLUE BOTTLE COFFEE 03/01 PURCHASE HTTPSBLUEBOTT CA -74.38 Expenditure Drink and Dessert
#> 17 2020-03-04                       IC* INSTACART 03/02 PURCHASE HTTPSINSTACAR CA -17.09 Expenditure           Grocery
#> 18 2020-03-04                 CVS/PHARMACY #01893 03/03 MOBILE PURCHASE BOSTON MA -12.99 Expenditure          Pharmacy
#> 19 2020-03-04                        NNT T. ROOTS 03/03 MOBILE PURCHASE BOSTON MA -19.13 Expenditure              Food
#> 20 2020-03-05                          Zelle payment to CAREN LEE Conf# hte8cd2nr  -9.50 Expenditure       Transaction
#> 21 2020-03-07      Online Banking transfer from SAV 2109 Confirmation# XXXXX91122 150.00     Deposit       Transaction
#> 22 2020-03-07                     Zelle payment to JENNIFER HWANG Conf# fuefdvzik -18.56 Expenditure       Transaction
#> 23 2020-03-08                           BYT* PVTA 03/07 PURCHASE TONY.GARCIA@B MA  -1.50 Expenditure    Transportation
#> 24 2020-03-08                           BYT* PVTA 03/07 PURCHASE TONY.GARCIA@B MA  -1.50 Expenditure    Transportation
#> 25 2020-03-08                               Zelle payment to JOHN Conf# dm2awb85p -31.57 Expenditure       Transaction
#> 26 2020-03-11                           BYT* PVTA 03/08 PURCHASE TONY.GARCIA@B MA  -3.00 Expenditure    Transportation
#> 27 2020-03-11                       IC* INSTACART 03/08 PURCHASE HTTPSINSTACAR CA  -8.98 Expenditure           Grocery
#> 28 2020-03-12 Zelle payment from CAREN LEE for Happy Birthday!”; Conf# zvukm0bmb" 200.00     Deposit       Transaction
#> 29 2020-03-15             GRECOURT BOOKSHOP #1354 03/14 MOBILE PURCHASE BOSTON MA -21.25 Expenditure          Shopping
#> 30 2020-03-18      Online Banking transfer from SAV 2109 Confirmation# XXXXX07802 150.00     Deposit       Transaction
#> 31 2020-03-18                            UBER *EATS 03/18 REFUND San Francisco CA  66.36     Deposit              Food
#> 32 2020-03-18                NJT - WEB XXXXX0010005 03/14 PURCHASE XXX-XX86463 NJ -14.00 Expenditure    Transportation
#> 33 2020-03-18                 ALTAR'D STATE #231 03/16 MOBILE PURCHASE NEWYORK NY -31.90 Expenditure           Clothes
#> 34 2020-03-18                       HUI LAO SHAN 03/16 MOBILE PURCHASE NEWYORK NY -18.32 Expenditure Drink and Dessert
#> 35 2020-03-18                    LYFT RIDE SAT 8PM 03/17 PURCHASE 855-865-9553 CA -66.78 Expenditure    Transportation
#> 36 2020-03-18                        Lyft *Ride S 03/17 PURCHASE SAN FRANCISCO CA -45.81 Expenditure    Transportation
#> 37 2020-03-18          SQ *BLUEBIRD FARM ALPAC 03/17 MOBILE PURCHASE Far Hills NJ -51.18 Expenditure             Misc.
#> 38 2020-03-18                        Lyft *Ride S 03/17 PURCHASE SAN FRANCISCO CA -20.68 Expenditure    Transportation
#> 39 2020-03-18                          UBER *EATS 03/18 PURCHASE San Francisco CA -67.03 Expenditure              Food
#> 40 2020-03-18                          UBER *EATS 03/18 PURCHASE San Francisco CA  -2.00 Expenditure              Food

# read_USBank()
usb <- read_USBank(usb_data)

# summary_stats()
summary_stats(boa)
#> # A tibble: 2 × 2
#>   Status       Total
#>   <chr>        <dbl>
#> 1 Deposit      1200.
#> 2 Expenditure -1379.

# avg_spend()
avg_spend(boa)
```

<img src="man/figures/README-example-1.png" width="100%" />

``` r

# budget_income()
budget_income(1000, freq = "weekly")
#> $needs
#> [1] 1000
#> 
#> $wants
#> [1] 600
#> 
#> $savings
#> [1] 400

# generate_pie()
generate_pie(boa)
```

<img src="man/figures/README-example-2.png" width="100%" />

## Contributors

- Olivia Wang
- Sophie Song
- Rachel Tolentino.
