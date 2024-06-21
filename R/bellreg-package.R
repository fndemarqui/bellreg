#' The 'bellreg' package.
#'
#' @description Bell Regression models for count data with overdispersion. The implemented models account for ordinary and zero-inflated regression models under both frequentist and Bayesian approaches. Theorical details regarding the models implemented in the package can be found in \insertCite{2018_Castellares}{bellreg} and \insertCite{2020_Lemonte}{bellreg}
#'
#' _PACKAGE
#' @name bellreg-package
#' @aliases BellReg
#' @useDynLib bellreg, .registration = TRUE
#' @import methods
#' @import Rcpp
#' @importFrom dplyr %>%
#' @importFrom Rdpack reprompt
#' @importFrom rstan sampling
#' @importFrom stats coef confint fitted make.link qnorm runif vcov
#'
#' @references
#' Stan Development Team (2020). RStan: the R interface to Stan. R package version 2.19.3. https://mc-stan.org
#'
#' \insertRef{2018_Castellares}{bellreg}
#'
#' \insertRef{2020_Lemonte}{bellreg}
#'
NULL
