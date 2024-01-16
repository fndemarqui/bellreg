

#---------------------------------------------
#' Variance-covariance matrix for a bellreg model
#'
#' @aliases vcov.bellreg
#' @description This function extracts and returns the variance-covariance matrix associated with the regression coefficients when the maximum likelihood estimation approach is used in the model fitting.
#' @export
#' @param object an object of the class bellreg.
#' @param ... further arguments passed to or from other methods.
#' @return  the variance-covariance matrix associated with the regression coefficients.
#'
#' @examples
#' \donttest{
#' data(faults)
#' fit <- bellreg(nf ~ lroll, data = faults)
#' vcov(fit)
#' }
#'
vcov.bellreg <- function(object, ...){
  Delta <- object$Delta
  V <- MASS::ginv(object$fit$hessian)
  V <- Delta%*%V%*%t(Delta)
  colnames(V) <- object$labels
  rownames(V) <- object$labels
  return(V)
}

#---------------------------------------------
#' Covariance of the regression coefficients
#'
#' @aliases vcov.zibellreg
#' @export
#' @param object an object of the class bellreg
#' @param ... further arguments passed to or from other methods.
#' @return  the variance-covariance matrix associated with the regression coefficients.
#'
#' @examples
#' \donttest{
#' data(cells)
#' fit <- zibellreg(cells ~ smoker + gender|smoker + gender, data = cells)
#' vcov(fit)
#' }
#'
vcov.zibellreg <- function(object, ...){
  Delta <- object$Delta
  V <- MASS::ginv(object$fit$hessian)
  V <- Delta%*%V%*%t(Delta)
  colnames(V) <- with(object, c(labels1, labels2))
  rownames(V) <- with(object, c(labels1, labels2))
  return(V)
}

#---------------------------------------------
#' Estimated regression coefficients for the bellreg model
#'
#' @aliases coef.bellreg
#' @export
#' @param object an object of the class bellreg.
#' @param ... further arguments passed to or from other methods.
#' @return  a vector with the estimated regression coefficients.
#'
#' @examples
#' \donttest{
#' data(faults)
#' fit <- bellreg(nf ~ lroll, data=faults)
#' coef(fit)
#' }
#'
coef.bellreg <- function(object, ...){
  coeffs <- object$fit$par
  names(coeffs) <- object$labels
  return(coeffs)
}


#---------------------------------------------
#' Estimated regression coefficients for zibellreg model
#'
#' @aliases coef.zibellreg
#' @export
#' @param object an object of the class bellreg
#' @param ... further arguments passed to or from other methods
#' @return  a list containing the the estimated regression coefficients associated with the degenerated and Bell count distributions, respectively.
#'
#' @examples
#' \donttest{
#' data(cells)
#' fit <- zibellreg(cells ~ smoker + gender|smoker + gender, data = cells)
#' coef(fit)
#' }
#'
coef.zibellreg <- function(object, ...){
  coefs <- object$fit$par
  p <- object$p
  q <- object$q
  coeffs1 <- coefs[1:q]
  coeffs2 <- coefs[(q+1):(q+p)]
  names(coeffs1) <- object$labels1
  names(coeffs2) <- object$labels2
  coeffs1
  coeffs2
  coeffs <- list("Degenerated dist." = coeffs1, "Bell dist." = coeffs2)
  return(coeffs)
}

#---------------------------------------------
#' Confidence intervals for the regression coefficients
#'
#' @aliases confint.bellreg
#' @export
#' @param object an object of the class bellreg
#' @param parm a specification of which parameters are to be given confidence intervals, either a vector of numbers or a vector of names. If missing, all parameters are considered.
#' @param level the confidence level required
#' @param ... further arguments passed to or from other methods
#' @return  A matrix (or vector) with columns giving lower and upper confidence limits for each parameter. These will be labelled as (1-level)/2 and 1 - (1-level)/2 in \% (by default 2.5\% and 97.5\%).
#'
#' @examples
#' \donttest{
#' data(faults)
#' fit <- bellreg(nf ~ lroll, data = faults)
#' confint(fit)
#' }
#'
confint.bellreg <- function(object, parm = NULL, level=0.95, ...){
  p <- object$p
  q <- object$q
  V <- vcov(object)
  par.hat <- object$fit$par[1:p]
  alpha <- 1-level
  d <- stats::qnorm(1 - alpha/2)*sqrt(diag(V))
  lower <- par.hat - d
  upper <- par.hat + d
  CI <- cbind(lower, upper)
  labels <- round(100*(c(alpha/2, 1-alpha/2)),1)
  colnames(CI) <- paste0(labels, "%")
  if(is.null(parm)){
    return(CI)
  }else{
    CI <- CI[parm, ,drop = FALSE]
    return(CI)
  }

}


#---------------------------------------------
#' Confidence intervals for the regression coefficients
#'
#' @aliases confint.zibellreg
#' @export
#' @param object an object of the class zibellreg
#' @param parm a specification of which parameters are to be given confidence intervals, either a vector of numbers or a vector of names. If missing, all parameters are considered.
#' @param level the confidence level required
#' @param ... further arguments passed to or from other methods
#' @return  100(1-alpha)% confidence intervals for the regression coefficients
#'
#' @examples
#' \donttest{
#' data(cells)
#' fit <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
#' confint(fit)
#' }
#'

confint.zibellreg <- function(object, parm = NULL, level=0.95, ...){
  p <- object$p
  q <- object$q
  V <- vcov(object)
  par.hat <- object$fit$par
  alpha <- 1-level
  d <- stats::qnorm(1 - alpha/2)*sqrt(diag(V))
  lower <- par.hat - d
  upper <- par.hat + d
  ci <- cbind(lower, upper)
  labels <- round(100*(c(alpha/2, 1-alpha/2)),1)
  colnames(ci) <- paste0(labels, "%")
  # if(!is.null(parm)){
  #   ci <- ci[parm, ,drop = FALSE]
  # }
  CI <- list("Degenerated dist." = ci[1:p, ], "Bell dist." = ci[(q+1):(q+p),])
  return(CI)
}


# estimates <- function(object, parm = NULL, conf.level = 0.95, ...) UseMethod("estimates")
#
# estimates.bellreg <- function(object, parm = NULL, conf.level = 0.95){
#   Estimate <- coef(object)
#   CI <- confint(object)
#   return(cbind(Estimate, CI))
# }
