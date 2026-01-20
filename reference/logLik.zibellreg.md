# Extract Log-Likelihood from a Fitted Model

Extracts the log-likelihood function for a fitted parametric model.

## Usage

``` r
# S3 method for class 'zibellreg'
logLik(object, ...)
```

## Arguments

- object:

  a fitted model of the class zibellreg

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
data(cells)
fit1 <- zibellreg(cells ~ 1|smoker+gender, data = cells, approach = "mle")
fit2 <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
logLik(fit1, fit2)
#>    fit    loglik npars
#> 1 fit2 -610.3234     6
#> 2 fit1 -622.4444     4
# }
```
