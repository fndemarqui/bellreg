# Extract Log-Likelihood from a Fitted Model

Extracts the log-likelihood function for a fitted parametric model.

## Usage

``` r
# S3 method for class 'bellreg'
logLik(object, ...)
```

## Arguments

- object:

  a fitted model of the class bellreg

- ...:

  further arguments passed to or from other methods.

## Value

the log-likelihood value when a single model is passed to the function;
otherwise, a data.frame with the log-likelihood values and the number of
parameters is returned.

## Examples

``` r
# \donttest{
library(bellreg)
data(faults)
fit1 <- bellreg(nf ~ 0 + lroll, data = faults, approach = "mle")
fit2 <- bellreg(nf ~ lroll, data = faults, approach = "mle")
logLik(fit1, fit2)
#>    fit    loglik npars
#> 1 fit2 -88.96139     2
#> 2 fit1 -93.13583     1
# }
```
