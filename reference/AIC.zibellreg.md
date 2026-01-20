# Akaike information criterion for zibellreg objects

Akaike information criterion for zibellreg objects

## Usage

``` r
# S3 method for class 'zibellreg'
AIC(object, ..., k = 2)
```

## Arguments

- object:

  an object of the class zibellreg.

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
data(cells)
fit1 <- zibellreg(cells ~ 1|1, data = cells, approach = "mle")
fit2 <- zibellreg(cells ~ 1|smoker+gender, data = cells, approach = "mle")
fit3 <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
AIC(fit1, fit2, fit3)
#>    fit      aic npars
#> 1 fit3 1232.647     6
#> 2 fit2 1252.889     4
#> 3 fit1 1311.304     2
# }
```
