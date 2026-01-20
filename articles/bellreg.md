# Modeling count data with the Bell distribution

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
#> (Intercept) 0.98525096 0.33219473  2.9659  0.003018 ** 
#> lroll       0.00190932 0.00049004  3.8963 9.767e-05 ***
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
#> (Intercept) 0.966   0.008 0.339 0.314 0.740 0.967 1.193 1.615 1941.617 1.000
#> lroll       0.002   0.000 0.000 0.001 0.002 0.002 0.002 0.003 2348.942 1.001
#> 
#> Inference for Stan model: bellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.

log_lik <- loo::extract_log_lik(bayes$fit)
loo::loo(log_lik)
#> Warning: Some Pareto k diagnostic values are too high. See help('pareto-k-diagnostic') for details.
#> 
#> Computed from 4000 by 32 log-likelihood matrix.
#> 
#>          Estimate   SE
#> elpd_loo   -212.8 37.4
#> p_loo        70.6 22.2
#> looic       425.6 74.8
#> ------
#> MCSE of elpd_loo is NA.
#> MCSE and ESS estimates assume independent draws (r_eff=1).
#> 
#> Pareto k diagnostic values:
#>                          Count Pct.    Min. ESS
#> (-Inf, 0.7]   (good)     24    75.0%   327     
#>    (0.7, 1]   (bad)       2     6.2%   <NA>    
#>    (1, Inf)   (very bad)  6    18.8%   <NA>    
#> See help('pareto-k-diagnostic') for details.
loo::waic(log_lik)
#> Warning: 
#> 21 (65.6%) p_waic estimates greater than 0.4. We recommend trying loo instead.
#> 
#> Computed from 4000 by 32 log-likelihood matrix.
#> 
#>           Estimate   SE
#> elpd_waic   -209.9 37.4
#> p_waic        67.7 22.3
#> waic         419.9 74.8
#> 
#> 21 (65.6%) p_waic estimates greater than 0.4. We recommend trying loo instead.
```
