
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bellreg

<!-- badges: start -->

[![R build
status](https://github.com/fndemarqui/bellreg/workflows/R-CMD-check/badge.svg)](https://github.com/fndemarqui/bellreg/actions)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/bellreg)](https://cran.r-project.org/package=bellreg)
[![Downloads](https://cranlogs.r-pkg.org/badges/bellreg)](https://cran.r-project.org/package=bellreg)
[![Total
Downloads](https://cranlogs.r-pkg.org/badges/grand-total/bellreg?color=orange)](https://cran.r-project.org/package=bellreg)
[![R-CMD-check](https://github.com/fndemarqui/bellreg/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/fndemarqui/bellreg/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of bellreg is to provide a set of functions to fit regression
models for count data with overdispersion using the Bell distribution.
The implemented models account for ordinary and zero-inflated regression
models under both frequentist and Bayesian approaches. Theoretical
details regarding the models implemented in the package can be found in
Castellares et al. (2018) <doi:10.1016/j.apm.2017.12.014> and Lemonte et
al. (2020) <doi:10.1080/02664763.2019.1636940>.

## Installation

You can install the development version of bellreg from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("fndemarqui/bellreg")
```

## Example

``` r
library(bellreg)

data(faults)

# ML approach:
mle <- bellreg(nf ~ lroll, data = faults, approach = "mle", init = 0)
summary(mle)
#> Call:
#> bellreg(formula = nf ~ lroll, data = faults, approach = "mle", 
#>     init = 0)
#> 
#> Coefficients:
#>               Estimate     StdErr z.value   p.value    
#> (Intercept) 0.98524220 0.33219474  2.9659  0.003018 ** 
#> lroll       0.00190934 0.00049004  3.8963 9.766e-05 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> logLik = -88.96139   AIC = 181.9228

# Bayesian approach:
bayes <- bellreg(nf ~ lroll, data = faults, approach = "bayes", refresh = FALSE)
summary(bayes)
#> 
#> bellreg(formula = nf ~ lroll, data = faults, approach = "bayes", 
#>     refresh = FALSE)
#> 
#>              mean se_mean    sd  2.5%   25%   50%   75% 97.5%    n_eff  Rhat
#> (Intercept) 0.984   0.007 0.334 0.331 0.758 0.978 1.213 1.627 2222.313 1.001
#> lroll       0.002   0.000 0.000 0.001 0.002 0.002 0.002 0.003 2478.992 1.001
#> 
#> Inference for Stan model: bellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.
```
