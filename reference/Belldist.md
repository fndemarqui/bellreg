# Probability function, distribution function, quantile function and random generation for the Bell distribution with parameter theta.

Probability function, distribution function, quantile function and
random generation for the Bell distribution with parameter theta.

## Usage

``` r
dbell(x, theta, log = FALSE)

pbell(q, theta, lower.tail = TRUE, log.p = FALSE)

qbell(p, theta, log.p = FALSE)

rbell(n, theta)
```

## Arguments

- x:

  vector of (non-negative integer) quantiles.

- theta:

  parameter of the Bell distribution (theta \> 0).

- log, log.p:

  logical; if TRUE, probabilities p are given as log(p).

- q:

  vector of quantiles.

- lower.tail:

  logical; if TRUE (default), probabilities are \\P\[X \le x\]\\;
  otherwise, \\P\[X \> x\]\\.

- p:

  vector of probabilities.

- n:

  number of random values to return.

## Value

dbell gives the (log) probability function, pbell gives the (log)
distribution function, qbell gives the quantile function, and rbell
generates random deviates.

## Details

Probability mass function \$\$ f(x) = \frac{\theta^{x}
e^{1-e^{\theta}}B_x}{x!}, \$\$ where \\B_x\\ is the Bell number, and x =
0, 1, ....
