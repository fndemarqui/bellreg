# The Truncated Poisson Distribution

Density, distribution function, quantile function, and random generation
for the truncated Poisson distribution with parameter `lambda`,
truncated to the interval `(lower, upper]`.

## Usage

``` r
dtpois(x, lambda, lower, upper, log = FALSE)

ptpois(q, lambda, lower, upper, lower.tail = TRUE, log.p = FALSE)

qtpois(p, lambda, lower, upper, lower.tail = TRUE, log.p = FALSE)

rtpois(n, lambda, lower, upper)
```

## Arguments

- x:

  vector of (non-negative integer) quantiles.

- lambda:

  vector of (non-negative) Poisson means.

- lower:

  vector of lower truncation bounds (exclusive).

- upper:

  vector of upper truncation bounds (inclusive).

- log:

  logical; if `TRUE`, probabilities `p` are given as `log(p)`.

- q:

  vector of quantiles.

- lower.tail:

  logical; if `TRUE` (default), probabilities are \\P\[X \le x\]\\,
  otherwise, \\P\[X \> x\]\\.

- log.p:

  logical; if `TRUE`, probabilities `p` are given as `log(p)`.

- p:

  vector of probabilities.

- n:

  number of observations. If `length(n) > 1`, the length is taken to be
  the number required.

## Value

`dtpois` gives the density.

`ptpois` gives the distribution function.

`qtpois` gives the quantile function.

`rtpois` generates random deviates.

## Details

The truncated Poisson distribution has density \$\$f(x) = \frac{P(X =
x)}{P(a \< X \le b)}\$\$ for \\x \in \\a+1, a+2, \ldots, b\\\\, where
\\X \sim \text{Poisson}(\lambda)\\, \\a\\ is the `lower` bound and \\b\\
is the `upper` bound.

## See also

`ptpois`, `qtpois`, `rtpois`

## Examples

``` r
# Density of truncated Poisson (lambda=5, truncated to (0, 10])
dtpois(1:10, lambda = 5, lower = 0, upper = 10)
#>  [1] 0.03439248 0.08598121 0.14330202 0.17912752 0.17912752 0.14927293
#>  [7] 0.10662352 0.06663970 0.03702206 0.01851103

# CDF of truncated Poisson
ptpois(3, lambda = 5, lower = 0, upper = 10)
#> [1] 0.2636757

# Quantile function of truncated Poisson
qtpois(0.5, lambda = 5, lower = 0, upper = 10)
#> [1] 5

# Random generation from truncated Poisson
rtpois(10, lambda = 5, lower = 0, upper = 10)
#>  [1] 5 2 5 6 4 5 5 3 8 4
```
