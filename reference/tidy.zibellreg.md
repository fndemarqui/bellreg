# Tidy a zibellreg object

Tidy a zibellreg object

## Usage

``` r
# S3 method for class 'zibellreg'
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
data(cells)
fit <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
tidy(fit)
#> # A tibble: 6 × 5
#>   term              estimate std.error statistic   p.value
#>   <chr>                <dbl>     <dbl>     <dbl>     <dbl>
#> 1 zero-(Intercept)   -1.95       0.845    -2.31  0.0208   
#> 2 zero-smoker         2.18       0.823     2.64  0.00818  
#> 3 zero-gender        -0.496      0.421    -1.18  0.238    
#> 4 count-(Intercept)   0.717      0.180     3.98  0.0000677
#> 5 count-smoker       -0.612      0.183    -3.34  0.000852 
#> 6 count-gender        0.0363     0.177     0.204 0.838    
# }
```
