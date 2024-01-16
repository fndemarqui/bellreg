

#---------------------------------------------
#' Extract pointwise log-likelihood from a Stan model for a bellreg model
#'
#' @aliases extract_log_lik.bellreg
#' @importFrom loo extract_log_lik
#' @description This function extracts the pointwise log-likelihood for a bellreg model.
#' @export
#' @param object an object of the class bellreg.
#' @param ... further arguments passed to or from other methods.
#' @return  a matrix with the pointwise extracted log-likelihood associated with a bellreg model.
#'
#' @examples
#' \donttest{
#' data(faults)
#' fit <- bellreg(nf ~ lroll, data = faults, approach = "bayes")
#' loglik <- extract_log_lik(fit)
#'
#' data(cells)
#' fit <- zibellreg(cells ~ 1|smoker+gender, data = cells, approach = "bayes", chains = 1, iter = 100)
#' loglik <- extract_log_lik(fit)
#'
#' }
#'
extract_log_lik <- function(object, ...){
  log_lik = loo::extract_log_lik(object$fit, ...)
  return(log_lik)
}

