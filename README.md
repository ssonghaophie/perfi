
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
#> Installing packages into '/private/var/folders/rd/9w0kch9d007c_h3yj9pn0xlr0000gn/T/RtmpzRm3Sf/temp_libpathe0c76f777c9'
#> (as 'lib' is unspecified)
#> 
#> The downloaded binary packages are in
#>  /var/folders/rd/9w0kch9d007c_h3yj9pn0xlr0000gn/T//Rtmpd1xGsM/downloaded_packages
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/private/var/folders/rd/9w0kch9d007c_h3yj9pn0xlr0000gn/T/Rtmpd1xGsM/remotes116a645b5c4d/ssonghaophie-perfi-6418c8e/DESCRIPTION’ ... OK
#> * preparing ‘perfi’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘perfi_0.0.0.9000.tar.gz’
#> Installing package into '/private/var/folders/rd/9w0kch9d007c_h3yj9pn0xlr0000gn/T/RtmpzRm3Sf/temp_libpathe0c76f777c9'
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

Functions inside the package: - `read_example`: Retrieves file paths for
example transaction data files in the “perfi” package’s directory. -
`read_boa`: Reads, cleans, categorizes, and assigns categories to Bank
of America transaction data. - `summary_stats`: Generates summary tables
of personal finance statistics, calculating totals grouped by
transaction status. - `avg_spend`: Calculates average daily and weekly
spending from transaction data and visualizes weekly spending trends. -
`budget_income`: Calculates budget allocations for needs, wants, and
savings based on user income and preferences. - `read_USBank`: Reads,
cleans, categorizes, and assigns categories to US Bank transaction data
from a specified URL. - `generate_pie`: Creates a pie chart illustrating
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
#>          Date
#> 2  2020-02-16
#> 3  2020-02-16
#> 4  2020-02-20
#> 5  2020-02-20
#> 6  2020-02-20
#> 7  2020-02-23
#> 8  2020-02-23
#> 9  2020-02-26
#> 10 2020-02-26
#> 11 2020-03-01
#> 12 2020-03-04
#> 13 2020-03-04
#> 14 2020-03-04
#> 15 2020-03-04
#> 16 2020-03-04
#> 17 2020-03-04
#> 18 2020-03-04
#> 19 2020-03-04
#> 20 2020-03-05
#> 21 2020-03-07
#> 22 2020-03-07
#> 23 2020-03-08
#> 24 2020-03-08
#> 25 2020-03-08
#> 26 2020-03-11
#> 27 2020-03-11
#> 28 2020-03-12
#> 29 2020-03-15
#> 30 2020-03-18
#> 31 2020-03-18
#> 32 2020-03-18
#> 33 2020-03-18
#> 34 2020-03-18
#> 35 2020-03-18
#> 36 2020-03-18
#> 37 2020-03-18
#> 38 2020-03-18
#> 39 2020-03-18
#> 40 2020-03-18
#>                                                            Description Amount
#> 2               DD *DOORDASH STARBUCKS 02/15 PURCHASE WWW.DOORDASH. CA -15.38
#> 3                        Zelle payment to JOHN WILLIAM Conf# dtn8onqc1  -5.14
#> 4                   GRUBHUBORIENTALTASTE 02/16 PURCHASE GRUBHUB.COM NY -17.85
#> 5                             GRUBHUBCVS 02/18 PURCHASE GRUBHUB.COM NY -17.17
#> 6                              CVS/PHARM 0189 02/20 PURCHASE BOSTON MA -40.45
#> 7                    Zelle payment from MARY ELIZABETH Conf# x77lowrro   8.80
#> 8                      Zelle payment to JENNIFER HUANG Conf# ep2a1con6 -18.00
#> 9                   DD DOORDASH MOGETEE 02/23 PURCHASE 855-973-1040 CA -20.32
#> 10                              WEEE INC. 02/24 PURCHASE XXXXX34967 CA -75.67
#> 11                   Zelle payment from JENNIFER HUANG Conf# ppdwrdcf6  20.30
#> 12      Online Banking transfer from SAV 2109 Confirmation# XXXXX07767  50.00
#> 13                         IC* INSTACART 03/03 REFUND HTTPSINSTACAR CA   6.02
#> 14                         UEP*ORIENTAL TASTE 03/01 PURCHASE BOSTON MA -40.57
#> 15                  BLUE BOTTLE COFFEE 03/01 PURCHASE HTTPSBLUEBOTT CA -51.18
#> 16                  BLUE BOTTLE COFFEE 03/01 PURCHASE HTTPSBLUEBOTT CA -74.38
#> 17                       IC* INSTACART 03/02 PURCHASE HTTPSINSTACAR CA -17.09
#> 18                 CVS/PHARMACY #01893 03/03 MOBILE PURCHASE BOSTON MA -12.99
#> 19                        NNT T. ROOTS 03/03 MOBILE PURCHASE BOSTON MA -19.13
#> 20                          Zelle payment to CAREN LEE Conf# hte8cd2nr  -9.50
#> 21      Online Banking transfer from SAV 2109 Confirmation# XXXXX91122 150.00
#> 22                     Zelle payment to JENNIFER HWANG Conf# fuefdvzik -18.56
#> 23                           BYT* PVTA 03/07 PURCHASE TONY.GARCIA@B MA  -1.50
#> 24                           BYT* PVTA 03/07 PURCHASE TONY.GARCIA@B MA  -1.50
#> 25                               Zelle payment to JOHN Conf# dm2awb85p -31.57
#> 26                           BYT* PVTA 03/08 PURCHASE TONY.GARCIA@B MA  -3.00
#> 27                       IC* INSTACART 03/08 PURCHASE HTTPSINSTACAR CA  -8.98
#> 28 Zelle payment from CAREN LEE for Happy Birthday!”; Conf# zvukm0bmb" 200.00
#> 29             GRECOURT BOOKSHOP #1354 03/14 MOBILE PURCHASE BOSTON MA -21.25
#> 30      Online Banking transfer from SAV 2109 Confirmation# XXXXX07802 150.00
#> 31                            UBER *EATS 03/18 REFUND San Francisco CA  66.36
#> 32                NJT - WEB XXXXX0010005 03/14 PURCHASE XXX-XX86463 NJ -14.00
#> 33                 ALTAR'D STATE #231 03/16 MOBILE PURCHASE NEWYORK NY -31.90
#> 34                       HUI LAO SHAN 03/16 MOBILE PURCHASE NEWYORK NY -18.32
#> 35                    LYFT RIDE SAT 8PM 03/17 PURCHASE 855-865-9553 CA -66.78
#> 36                        Lyft *Ride S 03/17 PURCHASE SAN FRANCISCO CA -45.81
#> 37          SQ *BLUEBIRD FARM ALPAC 03/17 MOBILE PURCHASE Far Hills NJ -51.18
#> 38                        Lyft *Ride S 03/17 PURCHASE SAN FRANCISCO CA -20.68
#> 39                          UBER *EATS 03/18 PURCHASE San Francisco CA -67.03
#> 40                          UBER *EATS 03/18 PURCHASE San Francisco CA  -2.00
#>         Status          Category
#> 2  Expenditure              Food
#> 3  Expenditure       Transaction
#> 4  Expenditure              Food
#> 5  Expenditure          Pharmacy
#> 6  Expenditure          Pharmacy
#> 7      Deposit       Transaction
#> 8  Expenditure       Transaction
#> 9  Expenditure              Food
#> 10 Expenditure           Grocery
#> 11     Deposit       Transaction
#> 12     Deposit       Transaction
#> 13     Deposit           Grocery
#> 14 Expenditure              Food
#> 15 Expenditure Drink and Dessert
#> 16 Expenditure Drink and Dessert
#> 17 Expenditure           Grocery
#> 18 Expenditure          Pharmacy
#> 19 Expenditure              Food
#> 20 Expenditure       Transaction
#> 21     Deposit       Transaction
#> 22 Expenditure       Transaction
#> 23 Expenditure    Transportation
#> 24 Expenditure    Transportation
#> 25 Expenditure       Transaction
#> 26 Expenditure    Transportation
#> 27 Expenditure           Grocery
#> 28     Deposit       Transaction
#> 29 Expenditure          Shopping
#> 30     Deposit       Transaction
#> 31     Deposit              Food
#> 32 Expenditure    Transportation
#> 33 Expenditure           Clothes
#> 34 Expenditure Drink and Dessert
#> 35 Expenditure    Transportation
#> 36 Expenditure    Transportation
#> 37 Expenditure             Misc.
#> 38 Expenditure    Transportation
#> 39 Expenditure              Food
#> 40 Expenditure              Food

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
