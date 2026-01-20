# Support Functions for emmeans

Functions required for compatibility of bellreg with emmeans. Users are
not required to call these functions themselves. Instead, they will be
called automatically by the `emmeans` function of the emmeans package.

## Usage

``` r
# S3 method for class 'bellreg'
recover_data(object, ...)

# S3 method for class 'zibellreg'
recover_data(object, term = c("zero", "count"), ...)
```

## Arguments

- object:

  An object of the same class as is supported by a new method.

- ...:

  Additional parameters that may be supported by the method.

- term:

  character specifying whether zero or count term regression
  coefficients are to be used.
