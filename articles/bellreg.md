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
#> (Intercept) 0.9675 0.3402 0.2799 0.9713 1.6228 2528.233 1.0000
#> lroll       0.0019 0.0005 0.0009 0.0019 0.0029 2813.234 0.9998
#> 
#> Inference for Stan model: bellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.

log_lik <- loo::extract_log_lik(bayes$fit)
loo::loo(log_lik)
#> 
#> Computed from 4000 by 32 log-likelihood matrix.
#> 
#>          Estimate  SE
#> elpd_loo    -91.1 4.0
#> p_loo         2.0 0.6
#> looic       182.1 7.9
#> ------
#> MCSE of elpd_loo is 0.0.
#> MCSE and ESS estimates assume independent draws (r_eff=1).
#> 
#> All Pareto k estimates are good (k < 0.7).
#> See help('pareto-k-diagnostic') for details.
loo::waic(log_lik)
#> Warning: 
#> 1 (3.1%) p_waic estimates greater than 0.4. We recommend trying loo instead.
#> 
#> Computed from 4000 by 32 log-likelihood matrix.
#> 
#>           Estimate  SE
#> elpd_waic    -91.0 4.0
#> p_waic         2.0 0.6
#> waic         182.1 7.9
#> 
#> 1 (3.1%) p_waic estimates greater than 0.4. We recommend trying loo instead.
```
