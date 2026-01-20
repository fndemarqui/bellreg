#---------------------------------------------
#' Extract Log-Likelihood from a Fitted Model
#'
#' @aliases logLik.bellreg
#' @description Extracts the log-likelihood function for a fitted parametric model.
#' @importFrom stats logLik
#' @importFrom dplyr desc arrange
#' @importFrom rlang .data
#' @export
#' @param object a fitted model of the class bellreg
#' @param ... further arguments passed to or from other methods.
#' @return  the log-likelihood value when a single model is passed to the function; otherwise, a data.frame with the log-likelihood values and the number of parameters is returned.
#' @examples
#' \donttest{
#' library(bellreg)
#' data(faults)
#' fit1 <- bellreg(nf ~ 0 + lroll, data = faults, approach = "mle")
#' fit2 <- bellreg(nf ~ lroll, data = faults, approach = "mle")
#' logLik(fit1, fit2)
#' }
#'

logLik.bellreg <- function(object, ...){
  objects <- c(as.list(environment()), list(...))
  argnames <- sys.call()
  argnames <- paste0(lapply(argnames[-1], as.character))
  J <- nargs()
  loglik <- c()
  npars <- c()
  for(j in 1:J){
    loglik[j] <- objects[[j]]$loglik
    npars[j] <- length(objects[[j]]$fit$par)
  }
  if(length(argnames)>1){
    loglik <- data.frame(
      fit = argnames,
      loglik = loglik,
      npars = npars
    ) |>
      dplyr::arrange(dplyr::desc(.data$loglik))
  }
  return(loglik)
}


#---------------------------------------------
#' Extract Log-Likelihood from a Fitted Model
#'
#' @aliases logLik.zibellreg
#' @description Extracts the log-likelihood function for a fitted parametric model.
#' @importFrom stats logLik
#' @export
#' @param object a fitted model of the class zibellreg
#' @param ... further arguments passed to or from other methods.
#' @return  the log-likelihood value when a single model is passed to the function; otherwise, a data.frame with the log-likelihood values and the number of parameters is returned.
#' @examples
#' \donttest{
#' library(bellreg)
#' data(cells)
#' fit1 <- zibellreg(cells ~ 1|smoker+gender, data = cells, approach = "mle")
#' fit2 <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
#' logLik(fit1, fit2)
#' }
#'

logLik.zibellreg <- function(object, ...){
  objects <- c(as.list(environment()), list(...))
  argnames <- sys.call()
  argnames <- paste0(lapply(argnames[-1], as.character))
  J <- nargs()
  loglik <- c()
  npars <- c()
  for(j in 1:J){
    loglik[j] <- objects[[j]]$loglik
    npars[j] <- length(objects[[j]]$fit$par)
  }
  if(length(argnames)>1){
    loglik <- data.frame(
      fit = argnames,
      loglik = loglik,
      npars = npars
    ) |>
      dplyr::arrange(dplyr::desc(.data$loglik))
  }
  return(loglik)
}
