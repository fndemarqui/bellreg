# anova method for zibellreg models

Compute analysis of variance (or deviance) tables for one or more fitted
model objects.

## Usage

``` r
# S3 method for class 'zibellreg'
anova(...)
```

## Arguments

- ...:

  further arguments passed to or from other methods.

## Value

the ANOVA table.

## Examples

``` r
# \donttest{
library(bellreg)
data(cells)
fit1 <- zibellreg(cells ~ 1|smoker+gender, data = cells, approach = "mle")
fit2 <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
anova(fit1, fit2)
#> 
#> Model 1: cells ~ 1 | smoker + gender 
#> Model 2: cells ~ smoker + gender | smoker + gender 
#> --- 
#>            loglik       LR df  Pr(>Chi)    
#> Model 1: -622.444   24.242  2 5.444e-06 ***
#> Model 2: -610.323        -  -         -    
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# }
```
