# Zero-inflated Bell model

``` r
library(bellreg)

data(cells)

# ML approach:
mle <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
summary(mle)
#> Call:
#> zibellreg(formula = cells ~ smoker + gender | smoker + gender, 
#>     data = cells, approach = "mle")
#> 
#> Zero-inflated regression coefficients:
#>             Estimate   StdErr z.value  p.value   
#> (Intercept) -1.95125  0.84424 -2.3113 0.020819 * 
#> smoker       2.17553  0.82248  2.6451 0.008167 **
#> gender      -0.49601  0.42059 -1.1793 0.238275   
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> 
#> Count regression coefficients:
#>              Estimate    StdErr z.value   p.value    
#> (Intercept)  0.716784  0.179844  3.9856 6.731e-05 ***
#> smoker      -0.611842  0.183398 -3.3361 0.0008495 ***
#> gender       0.036218  0.177484  0.2041 0.8383045    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> --- 
#> logLik = -610.3234   AIC = 1232.647

# Bayesian approach:
bayes <- zibellreg(cells ~ 1|smoker+gender, data = cells, approach = "bayes", refresh = FALSE)
summary(bayes)
#> Call:
#> zibellreg(formula = cells ~ 1 | smoker + gender, data = cells, 
#>     approach = "bayes", refresh = FALSE)
#> 
#> Zero-inflated regression coefficients:
#>               mean se_mean    sd   2.5%    25%   50%    75%  97.5%    n_eff
#> (Intercept) -1.156   0.008 0.329 -1.877 -1.342 -1.12 -0.933 -0.618 1788.084
#>              Rhat
#> (Intercept) 1.003
#> 
#> Count regression coefficients:
#>               mean se_mean    sd   2.5%    25%    50%    75%  97.5%    n_eff
#> (Intercept)  0.720   0.003 0.147  0.434  0.620  0.721  0.818  1.011 2696.769
#> smoker      -1.074   0.003 0.148 -1.368 -1.170 -1.072 -0.977 -0.783 2371.508
#> gender       0.172   0.003 0.140 -0.100  0.078  0.175  0.266  0.452 2948.729
#>              Rhat
#> (Intercept) 1.002
#> smoker      1.002
#> gender      1.000
#> --- 
#> Inference for Stan model: zibellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.

log_lik <- loo::extract_log_lik(bayes$fit)
loo::loo(log_lik)
#> Warning: Some Pareto k diagnostic values are too high. See help('pareto-k-diagnostic') for details.
#> 
#> Computed from 4000 by 511 log-likelihood matrix.
#> 
#>          Estimate    SE
#> elpd_loo  -1094.2  56.0
#> p_loo       247.0  24.1
#> looic      2188.4 112.0
#> ------
#> MCSE of elpd_loo is NA.
#> MCSE and ESS estimates assume independent draws (r_eff=1).
#> 
#> Pareto k diagnostic values:
#>                          Count Pct.    Min. ESS
#> (-Inf, 0.7]   (good)     418   81.8%   2752    
#>    (0.7, 1]   (bad)        1    0.2%   <NA>    
#>    (1, Inf)   (very bad)  92   18.0%   <NA>    
#> See help('pareto-k-diagnostic') for details.
loo::waic(log_lik)
#> Warning: 
#> 93 (18.2%) p_waic estimates greater than 0.4. We recommend trying loo instead.
#> 
#> Computed from 4000 by 511 log-likelihood matrix.
#> 
#>           Estimate   SE
#> elpd_waic  -1016.5 49.1
#> p_waic       169.4 15.8
#> waic        2033.0 98.2
#> 
#> 93 (18.2%) p_waic estimates greater than 0.4. We recommend trying loo instead.
```
