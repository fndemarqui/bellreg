# Confidence intervals for the regression coefficients

Confidence intervals for the regression coefficients

## Usage

``` r
# S3 method for class 'bellreg'
confint(object, parm = NULL, level = 0.95, ...)
```

## Arguments

- object:

  an object of the class bellreg

- parm:

  a specification of which parameters are to be given confidence
  intervals, either a vector of numbers or a vector of names. If
  missing, all parameters are considered.

- level:

  the confidence level required

- ...:

  further arguments passed to or from other methods

## Value

A matrix (or vector) with columns giving lower and upper confidence
limits for each parameter. These will be labelled as (1-level)/2 and 1 -
(1-level)/2 in \\

## Examples

``` r
# \donttest{
data(faults)
fit <- bellreg(nf ~ lroll, data = faults)
confint(fit)
#>                     2.5%       97.5%
#> (Intercept) 0.3341774576 1.636354354
#> lroll       0.0009488571 0.002869757
# }
```
