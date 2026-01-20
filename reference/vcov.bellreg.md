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
#> (Intercept)  0.1103531062 -1.556123e-04
#> lroll       -0.0001556123  2.401338e-07
# }
```
