# Estimated regression coefficients for the bellreg model

Estimated regression coefficients for the bellreg model

## Usage

``` r
# S3 method for class 'bellreg'
coef(object, ...)
```

## Arguments

- object:

  an object of the class bellreg.

- ...:

  further arguments passed to or from other methods.

## Value

a vector with the estimated regression coefficients.

## Examples

``` r
# \donttest{
data(faults)
fit <- bellreg(nf ~ lroll, data=faults)
coef(fit)
#> (Intercept)       lroll 
#> 0.985242201 0.001909341 
# }
```
