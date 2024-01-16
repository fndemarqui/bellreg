
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
#> (Intercept) 0.98524652 0.33219340  2.9659  0.003018 ** 
#> lroll       0.00190937 0.00049003  3.8964 9.763e-05 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> logLik = -88.96139   AIC = 181.9228

# Bayesian approach:
bayes <- bellreg(nf ~ lroll, data = faults, approach = "bayes")
#> 
#> SAMPLING FOR MODEL 'bellreg' NOW (CHAIN 1).
#> Chain 1: 
#> Chain 1: Gradient evaluation took 0.000214 seconds
#> Chain 1: 1000 transitions using 10 leapfrog steps per transition would take 2.14 seconds.
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
#> Chain 1:  Elapsed Time: 2.044 seconds (Warm-up)
#> Chain 1:                2.197 seconds (Sampling)
#> Chain 1:                4.241 seconds (Total)
#> Chain 1: 
#> 
#> SAMPLING FOR MODEL 'bellreg' NOW (CHAIN 2).
#> Chain 2: 
#> Chain 2: Gradient evaluation took 0.000188 seconds
#> Chain 2: 1000 transitions using 10 leapfrog steps per transition would take 1.88 seconds.
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
#> Chain 2:  Elapsed Time: 2.035 seconds (Warm-up)
#> Chain 2:                1.916 seconds (Sampling)
#> Chain 2:                3.951 seconds (Total)
#> Chain 2: 
#> 
#> SAMPLING FOR MODEL 'bellreg' NOW (CHAIN 3).
#> Chain 3: 
#> Chain 3: Gradient evaluation took 0.000194 seconds
#> Chain 3: 1000 transitions using 10 leapfrog steps per transition would take 1.94 seconds.
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
#> Chain 3:  Elapsed Time: 2.01 seconds (Warm-up)
#> Chain 3:                2.151 seconds (Sampling)
#> Chain 3:                4.161 seconds (Total)
#> Chain 3: 
#> 
#> SAMPLING FOR MODEL 'bellreg' NOW (CHAIN 4).
#> Chain 4: 
#> Chain 4: Gradient evaluation took 0.000188 seconds
#> Chain 4: 1000 transitions using 10 leapfrog steps per transition would take 1.88 seconds.
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
#> Chain 4:  Elapsed Time: 2.005 seconds (Warm-up)
#> Chain 4:                2.031 seconds (Sampling)
#> Chain 4:                4.036 seconds (Total)
#> Chain 4:
summary(bayes)
#> 
#> bellreg(formula = nf ~ lroll, data = faults, approach = "bayes")
#> 
#>              mean se_mean    sd  2.5%   25%   50%   75% 97.5%    n_eff Rhat
#> (Intercept) 0.977   0.007 0.329 0.330 0.757 0.974 1.195 1.618 2541.540    1
#> lroll       0.002   0.000 0.000 0.001 0.002 0.002 0.002 0.003 2774.748    1
#> 
#> Inference for Stan model: bellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.
```
