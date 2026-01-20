# Tidy a bellreg object

Tidy a bellreg object

## Usage

``` r
# S3 method for class 'bellreg'
tidy(x, conf.int = FALSE, conf.level = 0.95, ...)
```

## Arguments

- x:

  a fitted model object.

- conf.int:

  Logical indicating whether or not to include a confidence interval in
  the tidied output. Defaults to FALSE.

- conf.level:

  the confidence level required.

- ...:

  further arguments passed to or from other methods.

## Value

a tibble with a summary of the fit.

## Details

Convert a fitted model into a tibble.

## Examples

``` r
# \donttest{
library(bellreg)
data(faults)
fit <- bellreg(nf ~ lroll, data = faults, approach = "mle")
tidy(fit)
#> # A tibble: 2 × 5
#>   term        estimate std.error statistic   p.value
#>   <chr>          <dbl>     <dbl>     <dbl>     <dbl>
#> 1 (Intercept)  0.985    0.332         2.97 0.00302  
#> 2 lroll        0.00191  0.000490      3.90 0.0000977
# }
```
