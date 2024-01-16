

#---------------------------------------------
#' Extract Model Fitted Values
#'
#' @aliases fitted.bellreg
#' @description This function returns the fitted values.
#' @export
#' @param object an object of the class bellreg.
#' @param ... further arguments passed to or from other methods.
#' @return  a vector with the fitted values (for MLE approach) or a matrix containing the posterior sample of the fitted values.
#'
#' @examples
#' \donttest{
#' data(faults)
#' fit <- bellreg(nf ~ lroll, data = faults)
#' fitted.values(fit)
#' }
#'
fitted.bellreg <- function(object, ...){
  X <- stats::model.matrix(object, data = object$mf)
  if(object$approach == "mle"){
    beta <- coef(object)
    eta <- X%*%beta
    mu <- as.vector(exp(eta))
  }else{
    beta <- rstan::extract(object$fit)$beta
    eta <- beta%*%t(X)
    mu <- exp(eta)
    #mu <- as.vector(apply(exp(eta), 2, mean))
  }

  return(mu)
}



qresiduals <- function(object){
  y <- stats::model.response(object$mf)
  mu <- fitted.bellreg(object)
  theta = LambertW::W(mu)
  a <- purrr::map2_dbl(y-1, theta, pbell)
  b <- purrr::map2_dbl(y, theta, pbell)
  u <- purrr::map2_dbl(a, b, runif, n = 1)
  return(qnorm(u))
}



dev_bell <- function(y, mu){
  W_y <- LambertW::W(y)
  W_mu <- LambertW::W(mu)
  dev <- ifelse(
    y == 0,
    exp(1-W_mu ),
    exp(W_mu) - exp(W_y) + y *( log(W_y) - log(W_mu) )
  )
  return(dev)
}

deviance <- function(object){
  y <- stats::model.response(object$mf)
  mu <- fitted.bellreg(object)
  W_y <- LambertW::W(y)
  W_mu <- LambertW::W(mu)
  dev <- dev_bell(y, mu)
  return(dev)
}

deviance_residuals <- function(object){
  y <- stats::model.response(object$mf)
  mu <- fitted.bellreg(object)
  r <- sign(y-mu)*dev_bell(y, mu)
  return(r)
}


dmu_deta <- function(lp, link = c("log", "sqrt", "identity")){
  link = match.arg(link)
  dmu <- switch(link,
                "log" = exp(lp),
                "sqrt" = 0.5*(lp^(-0.5)),
                "identity" = 1
  )
  return(dmu)
}

vmu <- function(mu){
  V <- mu*(1+LambertW::W(mu))
  return(V)
}




