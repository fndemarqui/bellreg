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
#> Warning: longer object length is not a multiple of shorter object length
#> Warning: longer object length is not a multiple of shorter object length
#> $`Degenerated dist.`
#>            2.5%      97.5%
#> [1,] -3.6101494 -0.2955029
#> [2,]  0.5622502  3.7914147
#> [3,] -1.3203577  0.3286924
#> 
#> $`Bell dist.`
#>            2.5%      97.5%
#> [1,]  0.3639722  1.0690779
#> [2,] -0.9712645 -0.2522553
#> [3,] -0.3115964  0.3841420
#> 
# }
```
