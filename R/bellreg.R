

#---------------------------------------------
#' Bell regression model
#' @aliases bellreg
#' @export
#' @description Fits the Bell regression model to overdispersed count data.
#' @param formula an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted.
#' @param data an optional data frame, list or environment (or object coercible by as.data.frame to a data frame) containing the variables in the model. If not found in data, the variables are taken from environment(formula), typically the environment from which ypbp is called.
#' @param approach approach to be used to fit the model (mle: maximum likelihood; bayes: Bayesian approach).
#' @param hessian hessian logical; If TRUE (default), the hessian matrix is returned when approach="mle".
#' @param link assumed link function (log, sqrt or identiy); default is log.
#' @param hyperpars a list containing the hyperparameters associated with the prior distribution of the regression coefficients; if not specified then default choice is hyperpars = c(mu_beta = 0, sigma_beta = 10).
#' @param ... further arguments passed to either `rstan::optimizing` or `rstan::sampling`.
#' @return bellreg returns an object of class "bellreg" containing the fitted model.
#'
#' @examples
#' \donttest{
#' data(faults)
#' # ML approach:
#' mle <- bellreg(nf ~ lroll, data = faults, approach = "mle")
#' summary(mle)
#'
#' # Bayesian approach:
#' bayes <- bellreg(nf ~ lroll, data = faults, approach = "bayes", refresh = FALSE)
#' summary(bayes)
#' }
#'
bellreg <- function(formula, data = NULL, approach = c("mle", "bayes"),
                    hessian = TRUE, link = c("log", "sqrt", "identity"),
                    hyperpars = list(mu_beta=0, sigma_beta=10), ...){
  approach <- match.arg(approach)
  link <- match.arg(link)
  mf <- stats::model.frame(formula=formula, data=data)
  Terms <- stats::terms(mf)
  X <- as.matrix(stats::model.matrix(attr(mf, "terms"), data=mf))
  labels <- colnames(X)
  y <- stats::model.response(mf)
  n <- nrow(X)
  p <- ncol(X)

  if(match("(Intercept)", labels)==1){
    X_std <- scale(X[,-1])
    x_mean <- array(c(0, attr(X_std, "scaled:center")))
    x_sd <- array(c(1, attr(X_std, "scaled:scale")))
    X_std <- cbind(1, X_std)
    Delta <- diag(1/x_sd)
    Delta[1,] <- Delta[1,] -  x_mean/x_sd
  }else{
    X_std <- scale(X)
    x_mean <- array(attr(X_std, "scaled:center"))
    x_sd <- array(attr(X_std, "scaled:scale"))
    Delta <- diag(1/x_sd)
  }

  Link <- switch(link,
    "log" = 1,
    "sqrt" = 2,
    "identity" = 3
  )

  stan_data <- list(y=y, X=X_std, n=n, p=p, x_mean=x_mean, x_sd=x_sd,
                    mu_beta = hyperpars$mu_beta, sigma_beta=hyperpars$sigma_beta,
                    approach=0, link = Link)



  if(approach=="mle"){
    fit <- rstan::optimizing(stanmodels$bellreg, hessian=hessian,
                             data=stan_data, verbose=FALSE, ...)
    if(hessian==TRUE){
      fit$hessian <- - fit$hessian
    }
    fit$par <- fit$theta_tilde[-(1:p)]
    B <- c()
    for(i in 1:length(y)){
      B[i] <- numbers::bell(y[i])
    }
    fit$value <- fit$value + sum(log(B) - lgamma(y+1)) + n
    AIC <- -2*fit$value + 2*p
    fit <- list(fit=fit, logLik = fit$value, AIC = AIC, Delta = Delta)
  }else{
    stan_data$approach <- 1
    fit <- rstan::sampling(stanmodels$bellreg, data=stan_data, verbose=FALSE, ...)
    fit <- list(fit=fit)
  }

  fit$mf <- mf
  fit$n <- n
  fit$p <- p
  # fit$x_mean <- x_mean
  # fit$x_sd <- x_sd

  fit$call <- match.call()
  fit$formula <- stats::formula(Terms)
  fit$terms <- stats::terms.formula(formula)
  fit$labels <- labels
  fit$approach <- approach
  fit$link <- link
  class(fit) <- "bellreg"
  return(fit)
}


