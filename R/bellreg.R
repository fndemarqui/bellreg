

#---------------------------------------------
#' Bell regression model
#' @aliases bellreg
#' @export
#' @description Fits the Bell regression model to overdispersed count data.
#' @param formula an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted.
#' @param data an optional data frame, list or environment (or object coercible by as.data.frame to a data frame) containing the variables in the model. If not found in data, the variables are taken from environment(formula), typically the environment from which ypbp is called.
#' @param approach approach to be used to fit the model (mle: maximum likelihood; bayes: Bayesian approach).
#' @param link assumed link function (log, sqrt or identiy); default is log.
#' @param priors a list containing the prior specification for the parameters; if NULL, default prior are used.
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
                    link = c("log", "sqrt", "identity"),
                    priors = prior_spec(list(intercept ~ normal(0, 10), beta ~ normal(0, 2.5)), autoscale = TRUE), ...){
  approach <- match.arg(approach)
  link <- match.arg(link)
  Call <- match.call()
  mf <- match.call(expand.dots = FALSE)
  m <- match(c("formula", "data"), names(mf), 0L)
  mf <- mf[c(1L, m)]
  mf[[1L]] <- quote(stats::model.frame)
  mf <- eval(mf, parent.frame())
  mt <- attr(mf, "terms")
  X <- stats::model.matrix(mt, mf, ...)
  labels <- colnames(X)
  y <- stats::model.response(mf)
  n <- nrow(X)

  offset <- stats::model.offset(mf)
  if(is.null(offset)){
    offset <- rep(0, n)
  }

  has_int <- "(Intercept)" %in% labels
  if(has_int){
    X <- X[,-1, drop = FALSE]
  }

  p <- ncol(X)
  has_int <- as.numeric(has_int)

  priors <- check_priors(priors, model = "bellreg")

  mu_int <- priors$intercept$mu
  sigma_int <- priors$intercept$sigma
  mu_beta <- priors$beta$mu
  sigma_beta <- priors$beta$sigma

  if(approach == "bayes"){
    autoscale = priors$autoscale
  }else{
    autoscale = TRUE
  }

  if(isTRUE(autoscale)){
    X <- scale(X)
    att <- attributes(X)
    xbar <- array(att$`scaled:center`, dim = p)
    S <- array(att$`scaled:scale`, dim = p)
  }else{
    xbar <- array(0, dim = p)
    S <-  array(1, dim = p)
  }


  Link <- switch(link,
    "log" = 1,
    "sqrt" = 2,
    "identity" = 3
  )

  stan_data <- list(y=y, X=X, n=n, p=p, xbar=xbar, S = S,
                    mu_beta = mu_beta, sigma_beta = array(sigma_beta*rep(1, p)),
                    mu_int = mu_int, sigma_int = sigma_int,
                    approach=0, link = Link, offset = offset, has_int = has_int)


  p <- p + has_int

  if(approach=="mle"){
    fit <- rstan::optimizing(stanmodels$bellreg, hessian = TRUE,
                             data = stan_data, verbose = FALSE, init = 0, ...)

    o <- grep("coef_", names(fit$par))
    fit$par <- fit$par[-o]
    V <- MASS::ginv(-fit$hessian)
    if(p>0){
      V <- update_vcov_bellreg(V, xbar, S, has_int)
    }

    colnames(V) <- labels
    rownames(V) <- labels

    lbn <- c()
    for(i in 1:length(y)){
      lbn[i] <- log_belln(y[i])
    }
    # n included here because loglik = y*log(theta) - exp(theta) in Stan
    fit$value <- fit$value + sum(lbn - lgamma(y+1)) + n
    AIC <- -2*fit$value + 2*p
    fit <- list(fit=fit, loglik = fit$value, AIC = AIC, V=V)
  }else{
    stan_data$approach <- 1
    fit <- rstan::sampling(stanmodels$bellreg, data = stan_data, verbose = FALSE, ...)
    fit <- list(fit=fit)
    fit$priors <- priors
  }

  fit$mf <- mf
  fit$n <- n
  fit$p <- p

  fit$call <- match.call()
  fit$formula <- stats::formula(mt)
  fit$terms <- mt
  fit$mf <- mf
  fit$labels <- labels
  fit$approach <- approach
  fit$link <- link
  fit$offset <- offset
  class(fit) <- "bellreg"
  return(fit)
}


