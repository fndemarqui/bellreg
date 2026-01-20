# Covariance of the regression coefficients

Covariance of the regression coefficients

## Usage

``` r
# S3 method for class 'zibellreg'
vcov(object, ...)
```

## Arguments

- object:

  an object of the class bellreg

- ...:

  further arguments passed to or from other methods.

## Value

the variance-covariance matrix associated with the regression
coefficients.

## Examples

``` r
# \donttest{
data(cells)
fit <- zibellreg(cells ~ smoker + gender|smoker + gender, data = cells)
vcov(fit)
#>             (Intercept)      smoker      gender (Intercept)      smoker
#> (Intercept)  0.71363597 -0.66583696 -0.16290329  0.08674210 -0.06933872
#> smoker      -0.66583696  0.67731517  0.11224003 -0.07505099  0.07899997
#> gender      -0.16290329  0.11224003  0.17691599 -0.03594151  0.02389435
#> (Intercept)  0.08674210 -0.07505099 -0.03594151  0.03234666 -0.02221502
#> smoker      -0.06933872  0.07899997  0.02389435 -0.02221502  0.03363698
#> gender      -0.05316440  0.03930690  0.04234480 -0.02586169  0.01346615
#>                  gender
#> (Intercept) -0.05316440
#> smoker       0.03930690
#> gender       0.04234480
#> (Intercept) -0.02586169
#> smoker       0.01346615
#> gender       0.03149979
# }
```
