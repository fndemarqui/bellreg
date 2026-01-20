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
#>                   zero-(Intercept) zero-smoker zero-gender count-(Intercept)
#> zero-(Intercept)        0.71348038 -0.66568664 -0.16288857        0.08672343
#> zero-smoker            -0.66568664  0.67716821  0.11222769       -0.07503321
#> zero-gender            -0.16288857  0.11222769  0.17691060       -0.03593915
#> count-(Intercept)       0.08672343 -0.07503321 -0.03593915        0.03234459
#> count-smoker           -0.06932296  0.07898434  0.02389286       -0.02221333
#> count-gender           -0.05315715  0.03930040  0.04234299       -0.02586077
#>                   count-smoker count-gender
#> zero-(Intercept)   -0.06932296  -0.05315715
#> zero-smoker         0.07898434   0.03930040
#> zero-gender         0.02389286   0.04234299
#> count-(Intercept)  -0.02221333  -0.02586077
#> count-smoker        0.03363541   0.01346544
#> count-gender        0.01346544   0.03149935
# }
```
