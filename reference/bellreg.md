# Bell regression model

Fits the Bell regression model to overdispersed count data.

## Usage

``` r
bellreg(
  formula,
  data = NULL,
  approach = c("mle", "bayes"),
  hessian = TRUE,
  link = c("log", "sqrt", "identity"),
  hyperpars = list(mu_beta = 0, sigma_beta = 10),
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

- link:

  assumed link function (log, sqrt or identiy); default is log.

- hyperpars:

  a list containing the hyperparameters associated with the prior
  distribution of the regression coefficients; if not specified then
  default choice is hyperpars = c(mu_beta = 0, sigma_beta = 10).

- ...:

  further arguments passed to either
  [`rstan::optimizing`](https://mc-stan.org/rstan/reference/stanmodel-method-optimizing.html)
  or
  [`rstan::sampling`](https://mc-stan.org/rstan/reference/stanmodel-method-sampling.html).

## Value

bellreg returns an object of class "bellreg" containing the fitted
model.

## Examples

``` r
# \donttest{
data(faults)
# ML approach:
mle <- bellreg(nf ~ lroll, data = faults, approach = "mle")
summary(mle)
#> Call:
#> bellreg(formula = nf ~ lroll, data = faults, approach = "mle")
#> 
#> Coefficients:
#>               Estimate     StdErr z.value   p.value    
#> (Intercept) 0.98526055 0.33219397  2.9659  0.003018 ** 
#> lroll       0.00190932 0.00049003  3.8963 9.767e-05 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
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
#> (Intercept) 0.974   0.006 0.335 0.302 0.754 0.970 1.204 1.603 2668.060 1.000
#> lroll       0.002   0.000 0.000 0.001 0.002 0.002 0.002 0.003 3035.398 0.999
#> 
#> Inference for Stan model: bellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.
#> 
# }
```
