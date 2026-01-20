

normal_prior <- function(mu = 0, sigma = 2.5){
  if(sigma<0){
    warning("sigma must be a positive quantity... value supplied replaced by 2.5")
    sigma <- 2.5
  }
  list(mu = mu, sigma = sigma)
}


set_prior <- function(formula, ...){
  # Deconstruct the formula into a list
  call_list <- as.list(formula)

  # The third element is the function call
  func_call <- call_list[[3]]

  # The first element of the function call is the function name (as a symbol)
  func_name_symbol <- func_call[[1]]

  # Get the function by its name
  pdist <- base::get(paste0(as.character(func_name_symbol), "_prior"), mode = "function")

  # The arguments can be accessed from the function call
  func_args <- as.list(func_call)[-1]

  priors <- do.call(pdist, func_args)

  attributes(formula) <- NULL
  priors["param"] <- as.character(call_list[[2]])
  priors$formula <- formula
  return(priors)
}

#' Prior specification
#' @export
#' @aliases prior_spec
#' @param dists a list containing the prior specification for the parameters.
#' @param autoscale logical argument indicating if the covariates should be centered and scaled (default is TRUE)
#'
prior_spec <- function(dists = list(intercept ~ normal(0, 10), beta ~ normal(0, 2.5)), autoscale = TRUE) {
  out <- lapply(dists, set_prior)
  J <- length(out)
  labels <- vector(length = J)
  for(j in 1:J){
    labels[j] <- c(out[[j]]$param)
  }
  names(out) <- labels


  # if(!("intercept" %in% labels)){
  #   out$intercept <- set_prior(intercept ~ normal(mu = 0, sigma = 10))
  # }
  #
  # if(!("beta" %in% labels)){
  #   out$beta <- set_prior(beta ~ normal(mu = 0, sigma = 2.5))
  # }

  out$autoscale = autoscale
  class(out) <- "prior_spec"
  return(out)
}


#' @export
print.prior_spec <- function(x, ...){
  labels <- names(x)
  cat("\n")
  cat("Prior specifications:", "\n")
  print(x$intercept$formula)
  if("psi" %in% labels){
    print(x$psi$formula)
  }
  print(x$beta$formula)
}


check_priors <- function(object, model = c("bellreg", "zibellreg")){
  model = match.arg(model)
  labels <- names(object)

  if(!("intercept" %in% labels)){
    object$intercept <- set_prior(intercept ~ normal(mu = 0, sigma = 10))
  }

  if(!("beta" %in% labels)){
    object$beta <- set_prior(beta ~ normal(mu = 0, sigma = 2.5))
  }

  if(model == "bellreg"){
    object <- object[c("intercept", "beta", "autoscale")]
  }else{
    if(!("psi" %in% labels)){
      object$psi <- set_prior(psi ~ normal(mu = 0, sigma = 2.5))
    }

    object <- object[c("intercept", "psi", "beta", "autoscale")]
  }
  class(object) <- "prior_spec"
  return(object)
}
