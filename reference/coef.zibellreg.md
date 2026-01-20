# Estimated regression coefficients for zibellreg model

Estimated regression coefficients for zibellreg model

## Usage

``` r
# S3 method for class 'zibellreg'
coef(object, ...)
```

## Arguments

- object:

  an object of the class bellreg

- ...:

  further arguments passed to or from other methods

## Value

a list containing the the estimated regression coefficients associated
with the degenerated and Bell count distributions, respectively.

## Examples

``` r
# \donttest{
data(cells)
fit <- zibellreg(cells ~ smoker + gender|smoker + gender, data = cells)
coef(fit)
#> $`Degenerated dist.`
#> (Intercept)      smoker      gender 
#>  -1.9517137   2.1759076  -0.4959336 
#> 
#> $`Bell dist.`
#> (Intercept)      smoker      gender 
#>  0.71671200 -0.61177871  0.03614774 
#> 
# }
```
