# Extract Model Fitted Values

This function returns the fitted values.

## Usage

``` r
# S3 method for class 'bellreg'
fitted(object, ...)
```

## Arguments

- object:

  an object of the class bellreg.

- ...:

  further arguments passed to or from other methods.

## Value

a vector with the fitted values (for MLE approach) or a matrix
containing the posterior sample of the fitted values.

## Examples

``` r
# \donttest{
data(faults)
fit <- bellreg(nf ~ lroll, data = faults)
fitted.values(fit)
#>  [1]  7.669791  9.283359 13.115756  5.480768 10.489988 14.048990  4.493688
#>  [8]  8.918496  6.839597  5.449464  9.177615  6.216840 14.792240  6.421942
#> [15]  9.125196  6.852669  7.553527 13.368586 15.077388  7.539118  7.256651
#> [22]  3.381035  9.390321  3.705545 10.960919  5.439069 10.898314 11.193563
#> [29]  6.892034 10.510036 16.492986  5.938387
# }
```
