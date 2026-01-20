

#---------------------------------------------
#' ZiBell regression model
#' @aliases zibellreg
#' @export
#' @description Fits the Bell regression model to overdispersed count data.
#' @param formula an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted.
#' @param data an optional data frame, list or environment (or object coercible by as.data.frame to a data frame) containing the variables in the model. If not found in data, the variables are taken from environment(formula), typically the environment from which ypbp is called.
#' @param approach approach to be used to fit the model (mle: maximum likelihood; bayes: Bayesian approach).
#' @param link1 assumed link function for degenerate distribution (logit, probit, cloglog, cauchy); default is logit.
#' @param link2 assumed link function for count distribution (log, sqrt or identiy); default is log.
#' @param hessian hessian logical; If TRUE (default), the hessian matrix is returned when approach="mle".
#' @param priors a list containing the prior specification for the parameters; if NULL, default prior are used.
#' @param ... further arguments passed to either `rstan::optimizing` or `rstan::sampling`.
#' @return zibellreg returns an object of class "zibellreg" containing the fitted model.
#'
#' @examples
#' \donttest{
#' # ML approach:
#' data(cells)
#' mle <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
#' summary(mle)
#'
#' # Bayesian approach:
#' bayes <- zibellreg(cells ~ 1|smoker+gender, data = cells, approach = "bayes", refresh = FALSE)
#' summary(bayes)
#' }
#'
zibellreg<- function(formula, data, approach = c("mle", "bayes"), hessian = TRUE,
                     link1 = c("logit", "probit", "cloglog", "cauchy"), link2 = c("log", "sqrt", "identity"),
                     priors = prior_spec(list(intercept ~ normal(0, 10), beta ~ normal(0, 2.5)), autoscale = TRUE), ...){
  approach <- match.arg(approach)
  link1 <- match.arg(link1)
  link2 <- match.arg(link2)
  formula <- Formula::Formula(formula)
  mf <- stats::model.frame(formula=formula, data=data)
  Terms <- stats::terms(mf)
  Z <- stats::model.matrix(formula, data = mf, rhs = 1)
  X <- stats::model.matrix(formula, data = mf, rhs = 2)
  Xlabels <- colnames(X)
  Zlabels <- colnames(Z)
  y <- stats::model.response(mf)


  has_int_z <- "(Intercept)" %in% Zlabels
  if(has_int_z){
    Z <- Z[,-1, drop = FALSE]
  }

  has_int_x <- "(Intercept)" %in% Xlabels
  if(has_int_x){
    X <- X[,-1, drop = FALSE]
  }


  n <- nrow(X)
  p <- ncol(X)
  q <- ncol(Z)

  offset1 <- stats::model.offset(Formula::model.part(formula, data = mf, rhs = 1, terms = TRUE))
  offset2 <- stats::model.offset(Formula::model.part(formula, data = mf, rhs = 2, terms = TRUE))

  if(is.null(offset1)){
    offset1 <- rep(0, n)
  }

  if(is.null(offset2)){
    offset2 <- rep(0, n)
  }

  priors <- check_priors(priors, model = "zibellreg")

  mu_int <- priors$intercept$mu
  sigma_int <- priors$intercept$sigma
  mu_psi <- priors$psi$mu
  sigma_psi <- priors$psi$sigma
  mu_beta <- priors$beta$mu
  sigma_beta <- priors$beta$sigma
  autoscale <- priors$autoscale

  if(isTRUE(autoscale)){
    Z <- scale(Z)
    att <- attributes(Z)
    zbar <- array(att$`scaled:center`, dim = q)
    Sz <- array(att$`scaled:scale`, dim = q)

    X <- scale(X)
    att <- attributes(X)
    xbar <- array(att$`scaled:center`, dim = p)
    Sx <- array(att$`scaled:scale`, dim = p)
  }else{
    zbar <- array(0, dim = q)
    Sz <-  array(1, dim = q)
    xbar <- array(0, dim = p)
    Sx <-  array(1, dim = p)
  }

  Link1 <- switch(link1,
                  "logit" = 1,
                  "probit" = 2,
                  "cloglog" = 3,
                  "cauchy" = 4
  )

  Link2 <- switch(link2,
                  "log" = 1,
                  "sqrt" = 2,
                  "identity" = 3
  )



  stan_data <- list(y=y, X=X, Z=Z, n=n, p=p, q=q, xbar=xbar, Sx=Sx, zbar=zbar, Sz=Sz,
                    mu_psi = mu_psi, sigma_psi = array(sigma_psi*rep(1, q)),
                    mu_beta = mu_beta, sigma_beta = array(sigma_beta*rep(1, p)),
                    mu_int = mu_int, sigma_int = sigma_int, has_int_z = has_int_z, has_int_x = has_int_x,
                    approach=0, link1 = Link1, link2 = Link2, offset1 = offset1, offset2 = offset2)


  p <- p + has_int_x
  q <- q + has_int_z

  if(approach=="mle"){
    fit <- rstan::optimizing(stanmodels$zibellreg, hessian=TRUE,
                             data=stan_data, verbose=FALSE, init = 0, ...)
    o <- grep("coef_", names(fit$par))
    fit$par <- fit$par[-o]
    V <- MASS::ginv(-fit$hessian)
    V <- update_vcov_zibellreg(V, zbar, Sz, xbar, Sx, has_int_z, has_int_x)
    AIC <- -2*fit$value + 2*(p+q)
    fit <- list(fit=fit, loglik = fit$value, AIC = AIC, V = V)
  }else{
    stan_data$approach <- 1
    fit <- rstan::sampling(stanmodels$zibellreg, data=stan_data, verbose=FALSE, ...)
    fit <- list(fit=fit)
    fit$priors <- priors
  }


  fit$n <- n
  fit$p <- p
  fit$q <- q


  fit$call <- match.call()
  fit$formula <- stats::formula(Terms)
  fit$terms <- stats::terms.formula(formula)
  fit$mf <- mf
  fit$labels1 <- Zlabels
  fit$labels2 <- Xlabels
  fit$approach <- approach
  fit$link1 <- link1
  fit$link2 <- link2
  fit$offset1 <- offset1
  fit$offset2 <- offset2
  class(fit) <- "zibellreg"
  return(fit)
}


