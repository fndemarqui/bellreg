# bellreg

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
#> (Intercept) 0.98524220 0.33219474  2.9659  0.003018 ** 
#> lroll       0.00190934 0.00049004  3.8963 9.766e-05 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> logLik =   AIC = 181.9228

# Bayesian approach:
bayes <- bellreg(nf ~ lroll, data = faults, approach = "bayes", refresh = FALSE)
summary(bayes)
#> Call:
#> bellreg(formula = nf ~ lroll, data = faults, approach = "bayes", 
#>     refresh = FALSE)
#> 
#> Prior specifications: 
#> intercept ~ normal(0, 10)
#> beta ~ normal(0, 2.5)
#> 
#> Summary of the posterior distribution: 
#>               mean     sd   2.5%    50%  97.5%    n_eff   Rhat
#> (Intercept) 0.9934 0.3320 0.3328 0.9947 1.6252 2097.753 1.0025
#> lroll       0.0019 0.0005 0.0009 0.0019 0.0029 2337.698 1.0022
#> 
#> Inference for Stan model: bellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.
```
