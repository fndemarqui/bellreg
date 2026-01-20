# Variance-covariance matrix for a bellreg model

This function extracts and returns the variance-covariance matrix
associated with the regression coefficients when the maximum likelihood
estimation approach is used in the model fitting.

## Usage

``` r
# S3 method for class 'bellreg'
vcov(object, ...)
```

## Arguments

- object:

  an object of the class bellreg.

- ...:

  further arguments passed to or from other methods.

## Value

the variance-covariance matrix associated with the regression
coefficients.

## Examples

``` r
# \donttest{
data(faults)
fit <- bellreg(nf ~ lroll, data = faults)
vcov(fit)
#>               (Intercept)         lroll
#> (Intercept)  0.1103533481 -1.556126e-04
#> lroll       -0.0001556126  2.401343e-07
# }
```
