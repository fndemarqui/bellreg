# Akaike information criterion

Akaike information criterion

## Usage

``` r
# S3 method for class 'bellreg'
AIC(object, ..., k = 2)
```

## Arguments

- object:

  an object of the class bellreg.

- ...:

  further arguments passed to or from other methods.

- k:

  numeric, the penalty per parameter to be used; the default k = 2 is
  the classical AIC.

## Value

the Akaike information criterion value when a single model is passed to
the function; otherwise, a data.frame with the Akaike information
criterion values and the number of parameters is returned.

## Examples

``` r
# \donttest{
library(bellreg)
data(faults)
fit1 <- bellreg(nf ~ 1, data = faults, approach = "mle")
fit2 <- bellreg(nf ~ lroll, data = faults, approach = "mle")
AIC(fit1, fit2)
#>    fit      aic npars
#> 1 fit2 181.9228     2
#> 2 fit1 195.5679     1
# }
```
