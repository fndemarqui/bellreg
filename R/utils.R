
# auxiliary function to center covariates
center <- function(x, xbar, n, p){
  return(x - xbar)
}

get_D <- function(bar, S, has_int){
  if(has_int > 0){
    dev <- c(1, -bar/S)
    D <- diag(c(1, 1/S))
    D[1,] <- dev
  }else{
    dev <- c(-1/S)
    k <- length(dev)
    D <- diag(dev, nrow = k, ncol = k)
  }
  return(D)
}

# auxiliary function to compute new covariance function after centering covariates
update_vcov_bellreg <- function(V, xbar, S, has_int){
  D <- get_D(xbar, S, has_int)
  V <- D%*%V%*%t(D)
  return(V)
}

# auxiliary function to compute new covariance function after centering covariates
update_vcov_zibellreg <- function(V, zbar, Sz, xbar, Sx, has_int_z, has_int_x){
  D1 <- get_D(zbar, Sz, has_int_z)
  D2 <- get_D(xbar, Sx, has_int_x)
  D <- magic::adiag(D1, D2)
  V <- D%*%V%*%t(D)
  return(V)
}

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
  return(object$V)
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
  labels1 <- paste0("zero-", object$labels1)
  labels2 <- paste0("count-", object$labels2)
  V <- object$V
  colnames(V) <- c(labels1, labels2)
  rownames(V) <- c(labels1, labels2)
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
  coeffs <- object$fit$par
  labels1 <- paste0("zero-", object$labels1)
  labels2 <- paste0("count-", object$labels2)
  labels <- c(labels1, labels2)
  names(coeffs) <- labels
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
  V <- vcov(object)
  par.hat <- object$fit$par
  alpha <- 1-level
  d <- stats::qnorm(1 - alpha/2)*sqrt(diag(V))
  lower <- par.hat - d
  upper <- par.hat + d
  CI <- cbind(lower, upper)
  labels <- round(100*(c(alpha/2, 1-alpha/2)),1)
  colnames(CI) <- paste0(labels, "%")
  rownames(CI) <- object$labels
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
  V <- vcov(object)
  estimates <- coef(object)
  alpha <- 1-level
  d <- stats::qnorm(1 - alpha/2)*sqrt(diag(V))
  lower <- estimates - d
  upper <- estimates + d
  ci <- cbind(lower, upper)
  labels <- round(100*(c(alpha/2, 1-alpha/2)),1)
  colnames(ci) <- paste0(labels, "%")
  return(ci)
}


# estimates <- function(object, parm = NULL, conf.level = 0.95, ...) UseMethod("estimates")
#
# estimates.bellreg <- function(object, parm = NULL, conf.level = 0.95){
#   Estimate <- coef(object)
#   CI <- confint(object)
#   return(cbind(Estimate, CI))
# }
