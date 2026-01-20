# Construct Design Matrices for zibellreg models

Construct Design Matrices for zibellreg models

## Usage

``` r
# S3 method for class 'zibellreg'
model.matrix(object, which = c("all", "zero", "count"), ...)
```

## Arguments

- object:

  an object of class 'zibellreg'.

- which:

  character indicating which design matrix to extract: "all" (default),
  "zero", or "count".

- ...:

  further arguments passed to or from other methods.

## Value

A design matrix.

## Examples

``` r
library(bellreg)
data(cells)
fit <- zibellreg(formula = cells ~ smoker + gender | age, data = cells, approach = "mle")
head(model.matrix(fit))
#>   (Intercept) smoker gender ageold ageyoung
#> 1           1      0      1      0        1
#> 2           1      0      1      0        1
#> 3           1      0      1      0        1
#> 4           1      0      1      0        1
#> 5           1      0      1      0        1
#> 6           1      0      1      0        1
head(model.matrix(fit, "all"))
#>   (Intercept) smoker gender ageold ageyoung
#> 1           1      0      1      0        1
#> 2           1      0      1      0        1
#> 3           1      0      1      0        1
#> 4           1      0      1      0        1
#> 5           1      0      1      0        1
#> 6           1      0      1      0        1
head(model.matrix(fit, "zero"))
#>   (Intercept) smoker gender
#> 1           1      0      1
#> 2           1      0      1
#> 3           1      0      1
#> 4           1      0      1
#> 5           1      0      1
#> 6           1      0      1
head(model.matrix(fit, "count"))
#>   (Intercept) ageold ageyoung
#> 1           1      0        1
#> 2           1      0        1
#> 3           1      0        1
#> 4           1      0        1
#> 5           1      0        1
#> 6           1      0        1
```
