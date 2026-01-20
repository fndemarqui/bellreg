# Bell regression model

Fits the Bell regression model to overdispersed count data.

## Usage

``` r
bellreg(
  formula,
  data = NULL,
  approach = c("mle", "bayes"),
  link = c("log", "sqrt", "identity"),
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

- link:

  assumed link function (log, sqrt or identiy); default is log.

- priors:

  a list containing the prior specification for the parameters; if NULL,
  default prior are used.

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
#> (Intercept) 0.98524220 0.33219474  2.9659  0.003018 ** 
#> lroll       0.00190934 0.00049004  3.8963 9.766e-05 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
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
#> (Intercept) 0.9823 0.3229 0.3348 0.9832 1.6020 2585.683 0.9996
#> lroll       0.0019 0.0005 0.0010 0.0019 0.0028 2957.287 0.9996
#> 
#> Inference for Stan model: bellreg.
#> 4 chains, each with iter=2000; warmup=1000; thin=1; 
#> post-warmup draws per chain=1000, total post-warmup draws=4000.
#> 
# }
```
