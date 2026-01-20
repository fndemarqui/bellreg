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
#> (Intercept) -1.95194  0.84468 -2.3109 0.020840 * 
#> smoker       2.17615  0.82290  2.6445 0.008182 **
#> gender      -0.49590  0.42061 -1.1790 0.238390   
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> 
#> Count regression coefficients:
#>              Estimate    StdErr z.value   p.value    
#> (Intercept)  0.716552  0.179846  3.9843 6.769e-05 ***
#> smoker      -0.611706  0.183400 -3.3354 0.0008519 ***
#> gender       0.036264  0.177481  0.2043 0.8380972    
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
#> Prior specifications: 
#> intercept ~ normal(0, 10)
#> psi ~ normal(mu = 0, sigma = 2.5)
#> beta ~ normal(0, 2.5)
#> 
#> Zero-inflated regression coefficients:
#>      mean        sd      2.5%       50%     97.5%     n_eff      Rhat 
#>   -1.1621    0.3179   -1.8889   -1.1278   -0.6138 1629.4543    1.0015 
#> 
#> Count regression coefficients:
#>                mean     sd    2.5%     50%   97.5%    n_eff   Rhat
#> (Intercept)  0.7177 0.1445  0.4365  0.7204  0.9915 3096.655 1.0001
#> smoker      -1.0761 0.1456 -1.3648 -1.0745 -0.7880 2524.780 1.0005
#> gender       0.1701 0.1413 -0.0988  0.1707  0.4433 2998.055 0.9999
#> --- 
#> Inference for Stan model: zibellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.
```
