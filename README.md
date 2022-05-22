
<!-- README.md is generated from README.Rmd. Please edit that file -->

# testpkg4

<!-- badges: start -->
<!-- badges: end -->

testpkg4 is my fourth package that aims to collects convenent simple
functions to solve daily analysis.

## Installation

You can install the development version of testpkg4 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("MTRBEKTCBT/testpkg4")
```

## Example

This is a basic example which shows you how to calculate basic summary
statistics.

``` r
library(testpkg4)
suppressPackageStartupMessages(library(dplyr))

my_summarise_across(mtcars, am, .vars = mpg)
#> # A tibble: 2 × 5
#>      am mpg_n mpg_mean mpg_sd mpg_sum
#>   <dbl> <int>    <dbl>  <dbl>   <dbl>
#> 1     0    19     17.1   3.83    326.
#> 2     1    13     24.4   6.17    317.
```

Default argument for `.vars` is `where(is.numeric)` and second variable
is passed to `group_by()`. Be careful with that second variable is `...`
so you have to explicitly declare an argument name for third. (`.vars`)

When you want summaries for all of columns in a data frame, you can just
pass the data to the function. Then it makes summaries for all of
numeric columns.

``` r
my_summarise_across(sleep)
#> # A tibble: 1 × 4
#>   extra_n extra_mean extra_sd extra_sum
#>     <int>      <dbl>    <dbl>     <dbl>
#> 1      20       1.54     2.02      30.8
```
