# ZiBell regression model

Fits the Bell regression model to overdispersed count data.

## Usage

``` r
zibellreg(
  formula,
  data,
  approach = c("mle", "bayes"),
  hessian = TRUE,
  link1 = c("logit", "probit", "cloglog", "cauchy"),
  link2 = c("log", "sqrt", "identity"),
  priors = prior_spec(list(intercept ~ normal(0, 10), beta ~ normal(0, 2.5)), autoscale =
    TRUE),
  ...
)
```

## Arguments

- formula:

  an object of class "formula" (or one that can be coerced to that
  class): a symbolic description of the model to be fitted.

- data:

  an optional data frame, list or environment (or object coercible by
  as.data.frame to a data frame) containing the variables in the model.
  If not found in data, the variables are taken from
  environment(formula), typically the environment from which ypbp is
  called.

- approach:

  approach to be used to fit the model (mle: maximum likelihood; bayes:
  Bayesian approach).

- hessian:

  hessian logical; If TRUE (default), the hessian matrix is returned
  when approach="mle".

- link1:

  assumed link function for degenerate distribution (logit, probit,
  cloglog, cauchy); default is logit.

- link2:

  assumed link function for count distribution (log, sqrt or identiy);
  default is log.

- priors:

  a list containing the prior specification for the parameters; if NULL,
  default prior are used.

- ...:

  further arguments passed to either
  [`rstan::optimizing`](https://mc-stan.org/rstan/reference/stanmodel-method-optimizing.html)
  or
  [`rstan::sampling`](https://mc-stan.org/rstan/reference/stanmodel-method-sampling.html).

## Value

zibellreg returns an object of class "zibellreg" containing the fitted
model.

## Examples

``` r
# \donttest{
# ML approach:
data(cells)
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
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> 
#> Count regression coefficients:
#>              Estimate    StdErr z.value   p.value    
#> (Intercept)  0.716552  0.179846  3.9843 6.769e-05 ***
#> smoker      -0.611706  0.183400 -3.3354 0.0008519 ***
#> gender       0.036264  0.177481  0.2043 0.8380972    
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
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
#>   -1.1607    0.3127   -1.8624   -1.1355   -0.6298 2146.9654    0.9999 
#> 
#> Count regression coefficients:
#>                mean     sd    2.5%     50%   97.5%    n_eff   Rhat
#> (Intercept)  0.7199 0.1455  0.4345  0.7186  1.0134 2996.950 0.9996
#> smoker      -1.0774 0.1419 -1.3524 -1.0780 -0.7969 2405.594 1.0011
#> gender       0.1701 0.1393 -0.0970  0.1717  0.4440 3181.463 0.9994
#> --- 
#> Inference for Stan model: zibellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.
#> 
# }
```
