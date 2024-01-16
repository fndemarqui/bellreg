
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bellreg

<!-- badges: start -->

[![R build
status](https://github.com/fndemarqui/bellreg/workflows/R-CMD-check/badge.svg)](https://github.com/fndemarqui/bellreg/actions)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/bellreg)](https://cran.r-project.org/package=bellreg)
[![Downloads](https://cranlogs.r-pkg.org/badges/bellreg)](https://cran.r-project.org/package=bellreg)
[![Total
Downloads](https://cranlogs.r-pkg.org/badges/grand-total/bellreg?color=orange)](https://cran.r-project.org/package=bellreg)
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
mle <- bellreg(nf ~ lroll, data = faults, approach = "mle")
summary(mle)
#> Call:
#> bellreg(formula = nf ~ lroll, data = faults, approach = "mle")
#> 
#> Coefficients:
#>               Estimate     StdErr z.value   p.value    
#> (Intercept) 0.98524063 0.33219476  2.9659  0.003018 ** 
#> lroll       0.00190934 0.00049003  3.8963 9.766e-05 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> logLik = -88.96139   AIC = 181.9228

# Bayesian approach:
bayes <- bellreg(nf ~ lroll, data = faults, approach = "bayes")
#> 
#> SAMPLING FOR MODEL 'bellreg' NOW (CHAIN 1).
#> Chain 1: 
#> Chain 1: Gradient evaluation took 0.000242 seconds
#> Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 2.42 seconds.
#> Chain 1: Adjust your expectations accordingly!
#> Chain 1: 
#> Chain 1: 
#> Chain 1: Iteration:    1 / 2000 [  0%]  (Warmup)
#> Chain 1: Iteration:  200 / 2000 [ 10%]  (Warmup)
#> Chain 1: Iteration:  400 / 2000 [ 20%]  (Warmup)
#> Chain 1: Iteration:  600 / 2000 [ 30%]  (Warmup)
#> Chain 1: Iteration:  800 / 2000 [ 40%]  (Warmup)
#> Chain 1: Iteration: 1000 / 2000 [ 50%]  (Warmup)
#> Chain 1: Iteration: 1001 / 2000 [ 50%]  (Sampling)
#> Chain 1: Iteration: 1200 / 2000 [ 60%]  (Sampling)
#> Chain 1: Iteration: 1400 / 2000 [ 70%]  (Sampling)
#> Chain 1: Iteration: 1600 / 2000 [ 80%]  (Sampling)
#> Chain 1: Iteration: 1800 / 2000 [ 90%]  (Sampling)
#> Chain 1: Iteration: 2000 / 2000 [100%]  (Sampling)
#> Chain 1: 
#> Chain 1:  Elapsed Time: 2.927 seconds (Warm-up)
#> Chain 1:                2.618 seconds (Sampling)
#> Chain 1:                5.545 seconds (Total)
#> Chain 1: 
#> 
#> SAMPLING FOR MODEL 'bellreg' NOW (CHAIN 2).
#> Chain 2: 
#> Chain 2: Gradient evaluation took 0.000201 seconds
#> Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 2.01 seconds.
#> Chain 2: Adjust your expectations accordingly!
#> Chain 2: 
#> Chain 2: 
#> Chain 2: Iteration:    1 / 2000 [  0%]  (Warmup)
#> Chain 2: Iteration:  200 / 2000 [ 10%]  (Warmup)
#> Chain 2: Iteration:  400 / 2000 [ 20%]  (Warmup)
#> Chain 2: Iteration:  600 / 2000 [ 30%]  (Warmup)
#> Chain 2: Iteration:  800 / 2000 [ 40%]  (Warmup)
#> Chain 2: Iteration: 1000 / 2000 [ 50%]  (Warmup)
#> Chain 2: Iteration: 1001 / 2000 [ 50%]  (Sampling)
#> Chain 2: Iteration: 1200 / 2000 [ 60%]  (Sampling)
#> Chain 2: Iteration: 1400 / 2000 [ 70%]  (Sampling)
#> Chain 2: Iteration: 1600 / 2000 [ 80%]  (Sampling)
#> Chain 2: Iteration: 1800 / 2000 [ 90%]  (Sampling)
#> Chain 2: Iteration: 2000 / 2000 [100%]  (Sampling)
#> Chain 2: 
#> Chain 2:  Elapsed Time: 2.467 seconds (Warm-up)
#> Chain 2:                2.7 seconds (Sampling)
#> Chain 2:                5.167 seconds (Total)
#> Chain 2: 
#> 
#> SAMPLING FOR MODEL 'bellreg' NOW (CHAIN 3).
#> Chain 3: 
#> Chain 3: Gradient evaluation took 0.000344 seconds
#> Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 3.44 seconds.
#> Chain 3: Adjust your expectations accordingly!
#> Chain 3: 
#> Chain 3: 
#> Chain 3: Iteration:    1 / 2000 [  0%]  (Warmup)
#> Chain 3: Iteration:  200 / 2000 [ 10%]  (Warmup)
#> Chain 3: Iteration:  400 / 2000 [ 20%]  (Warmup)
#> Chain 3: Iteration:  600 / 2000 [ 30%]  (Warmup)
#> Chain 3: Iteration:  800 / 2000 [ 40%]  (Warmup)
#> Chain 3: Iteration: 1000 / 2000 [ 50%]  (Warmup)
#> Chain 3: Iteration: 1001 / 2000 [ 50%]  (Sampling)
#> Chain 3: Iteration: 1200 / 2000 [ 60%]  (Sampling)
#> Chain 3: Iteration: 1400 / 2000 [ 70%]  (Sampling)
#> Chain 3: Iteration: 1600 / 2000 [ 80%]  (Sampling)
#> Chain 3: Iteration: 1800 / 2000 [ 90%]  (Sampling)
#> Chain 3: Iteration: 2000 / 2000 [100%]  (Sampling)
#> Chain 3: 
#> Chain 3:  Elapsed Time: 2.492 seconds (Warm-up)
#> Chain 3:                2.63 seconds (Sampling)
#> Chain 3:                5.122 seconds (Total)
#> Chain 3: 
#> 
#> SAMPLING FOR MODEL 'bellreg' NOW (CHAIN 4).
#> Chain 4: 
#> Chain 4: Gradient evaluation took 0.000293 seconds
#> Chain 4: 1000 transitions using 10 leapfrog steps per transition would take 2.93 seconds.
#> Chain 4: Adjust your expectations accordingly!
#> Chain 4: 
#> Chain 4: 
#> Chain 4: Iteration:    1 / 2000 [  0%]  (Warmup)
#> Chain 4: Iteration:  200 / 2000 [ 10%]  (Warmup)
#> Chain 4: Iteration:  400 / 2000 [ 20%]  (Warmup)
#> Chain 4: Iteration:  600 / 2000 [ 30%]  (Warmup)
#> Chain 4: Iteration:  800 / 2000 [ 40%]  (Warmup)
#> Chain 4: Iteration: 1000 / 2000 [ 50%]  (Warmup)
#> Chain 4: Iteration: 1001 / 2000 [ 50%]  (Sampling)
#> Chain 4: Iteration: 1200 / 2000 [ 60%]  (Sampling)
#> Chain 4: Iteration: 1400 / 2000 [ 70%]  (Sampling)
#> Chain 4: Iteration: 1600 / 2000 [ 80%]  (Sampling)
#> Chain 4: Iteration: 1800 / 2000 [ 90%]  (Sampling)
#> Chain 4: Iteration: 2000 / 2000 [100%]  (Sampling)
#> Chain 4: 
#> Chain 4:  Elapsed Time: 2.476 seconds (Warm-up)
#> Chain 4:                2.279 seconds (Sampling)
#> Chain 4:                4.755 seconds (Total)
#> Chain 4:
summary(bayes)
#> 
#> bellreg(formula = nf ~ lroll, data = faults, approach = "bayes")
#> 
#>              mean se_mean    sd  2.5%   25%   50%   75% 97.5%    n_eff  Rhat
#> (Intercept) 0.969   0.007 0.332 0.296 0.746 0.974 1.199 1.613 2607.463 1.001
#> lroll       0.002   0.000 0.000 0.001 0.002 0.002 0.002 0.003 2909.071 1.000
#> 
#> Inference for Stan model: bellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.
```
