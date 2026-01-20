# Prior specification

Prior specification

## Usage

``` r
prior_spec(
  dists = list(intercept ~ normal(0, 10), beta ~ normal(0, 2.5)),
  autoscale = TRUE
)
```

## Arguments

- dists:

  a list containing the prior specification for the parameters.

- autoscale:

  logical argument indicating if the covariates should be centered and
  scaled (default is TRUE)
