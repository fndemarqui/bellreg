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
#>  [1]  7.669826  9.283393 13.115782  5.480802 10.490021 14.049013  4.493721
#>  [8]  8.918530  6.839633  5.449498  9.177650  6.216875 14.792261  6.421977
#> [15]  9.125230  6.852704  7.553562 13.368612 15.077408  7.539154  7.256686
#> [22]  3.381064  9.390355  3.705575 10.960951  5.439103 10.898346 11.193594
#> [29]  6.892069 10.510069 16.493000  5.938422
# }
```
