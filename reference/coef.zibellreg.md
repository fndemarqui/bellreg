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
#>  zero-(Intercept)       zero-smoker       zero-gender count-(Intercept) 
#>       -1.95194107        2.17614547       -0.49590496        0.71655217 
#>      count-smoker      count-gender 
#>       -0.61170559        0.03626424 
# }
```
