# bellreg 0.0.1

* Initial CRAN submission.

# bellreg 0.0.2

* The bellreg package now requires rstan version 2.26.
* Implementation of extract_log_lik method for bellreg and zibellreg objects.
* Implementation of new link functions (log, sqrt and identity for the count distribution and logit, probit, cloglog and cauchy for the degenerated distribution).
* Implementation of AIC method for bellreg and zibellreg objects.


# bellreg 0.0.2.1

* Update informatation in DESCRIPTION file.


# bellreg 0.0.2.2

* Implementation of bell() function for compatibility with stas::glm() function.


# bellreg 0.1.0

* Update of bellreg() function to accommodate . in model's formula
* Inclusion of offset terms in the linear predictors.
* coef.zibellreg() function now returns a vector of regression coefficients.
* confint.zibellreg() function now returns matrix with confidence interval limits.
* Inclusion of tidy methods for bellreg and zibellreg objects
* Implementation of prior_spec() function to specify prior distributions for model parameters.
