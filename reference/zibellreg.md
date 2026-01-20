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
  hyperpars = list(mu_psi = 0, sigma_psi = 10, mu_beta = 0, sigma_beta = 10),
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

- hyperpars:

  a list containing the hyperparameters associated with the prior
  distribution of the regression coefficients; if not specified then
  default choice is hyperpars = c(mu_psi = 0, sigma_psi = 10, mu_beta =
  0, sigma_beta = 10).

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
#> (Intercept) -1.95228  0.84486 -2.3108 0.020845 * 
#> smoker       2.17643  0.82307  2.6443 0.008186 **
#> gender      -0.49560  0.42057 -1.1784 0.238639   
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> 
#> Count regression coefficients:
#>             Estimate   StdErr z.value   p.value    
#> (Intercept)  0.71652  0.17985  3.9841 6.774e-05 ***
#> smoker      -0.61170  0.18340 -3.3354 0.0008518 ***
#> gender       0.03633  0.17747  0.2047 0.8378028    
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
#> Zero-inflated regression coefficients:
#>               mean se_mean    sd   2.5%    25%    50%    75%  97.5%    n_eff
#> (Intercept) -1.148   0.007 0.317 -1.856 -1.322 -1.119 -0.931 -0.623 2008.085
#>              Rhat
#> (Intercept) 1.002
#> 
#> Count regression coefficients:
#>               mean se_mean    sd   2.5%    25%    50%    75%  97.5%    n_eff
#> (Intercept)  0.716   0.003 0.144  0.437  0.618  0.716  0.815  0.998 3186.806
#> smoker      -1.069   0.003 0.143 -1.353 -1.163 -1.068 -0.973 -0.783 2654.165
#> gender       0.176   0.003 0.141 -0.098  0.078  0.175  0.272  0.455 3094.795
#>             Rhat
#> (Intercept)    1
#> smoker         1
#> gender         1
#> --- 
#> Inference for Stan model: zibellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.
#> 
# }
```
