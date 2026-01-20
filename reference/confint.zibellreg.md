# Confidence intervals for the regression coefficients

Confidence intervals for the regression coefficients

## Usage

``` r
# S3 method for class 'zibellreg'
confint(object, parm = NULL, level = 0.95, ...)
```

## Arguments

- object:

  an object of the class zibellreg

- parm:

  a specification of which parameters are to be given confidence
  intervals, either a vector of numbers or a vector of names. If
  missing, all parameters are considered.

- level:

  the confidence level required

- ...:

  further arguments passed to or from other methods

## Value

100(1-alpha)% confidence intervals for the regression coefficients

## Examples

``` r
# \donttest{
data(cells)
fit <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
confint(fit)
#>                         2.5%      97.5%
#> zero-(Intercept)  -3.6074789 -0.2964032
#> zero-smoker        0.5632866  3.7890044
#> zero-gender       -1.3202804  0.3284704
#> count-(Intercept)  0.3640604  1.0690439
#> count-smoker      -0.9711622 -0.2522490
#> count-gender      -0.3115912  0.3841197
# }
```
