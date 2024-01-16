# internal function used to compute AIC (several models)
get_arg_names <- function(...) {
  argnames <- sys.call()
  paste0(lapply(argnames[-1], as.character))
}

#' Akaike information criterion
#' @aliases AIC.bellreg
#' @export
#' @param object an object of the class bellreg.
#' @param ... further arguments passed to or from other methods.
#' @param k numeric, the penalty per parameter to be used; the default k = 2 is the classical AIC.
#' @return  the Akaike information criterion value when a single model is passed to the function; otherwise, a data.frame with the Akaike information criterion values and the number of parameters is returned.
#' @examples
#' \donttest{
#' library(bellreg)
#' data(faults)
#' fit1 <- bellreg(nf ~ 1, data = faults, approach = "mle")
#' fit2 <- bellreg(nf ~ lroll, data = faults, approach = "mle")
#' AIC(fit1, fit2)
#' }
#'
AIC.bellreg <- function(object, ..., k = 2){
  objects <- c(as.list(environment()), list(...))
  argnames <- sys.call()
  argnames <- paste0(lapply(argnames[-1], as.character))
  k <- objects[[2]]
  objects <- objects[-2]
  J <- nargs()
  aic <- c()
  npars <- c()
  for(j in 1:J){
    loglik <- objects[[j]]$logLik
    npars[j] <- objects[[j]]$p
    aic[j] <- -2*loglik + k*npars[j]
  }
  if(length(argnames)>1){
    aic <- data.frame(
      fit = argnames,
      aic = aic,
      npars = npars
    ) %>%
      dplyr::arrange(aic)
  }
  return(aic)
}

#' Akaike information criterion for zibellreg objects
#' @aliases AIC.zibellreg
#' @export
#' @param object an object of the class zibellreg.
#' @param ... further arguments passed to or from other methods.
#' @param k numeric, the penalty per parameter to be used; the default k = 2 is the classical AIC.
#' @return  the Akaike information criterion value when a single model is passed to the function; otherwise, a data.frame with the Akaike information criterion values and the number of parameters is returned.
#' @examples
#' \donttest{
#' library(bellreg)
#' data(cells)
#' fit1 <- zibellreg(cells ~ 1|1, data = cells, approach = "mle")
#' fit2 <- zibellreg(cells ~ 1|smoker+gender, data = cells, approach = "mle")
#' fit3 <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
#' AIC(fit1, fit2, fit3)
#' }
#'
AIC.zibellreg <- function(object, ..., k = 2){
  objects <- c(as.list(environment()), list(...))
  argnames <- sys.call()
  argnames <- paste0(lapply(argnames[-1], as.character))
  k <- objects[[2]]
  objects <- objects[-2]
  J <- nargs()
  aic <- c()
  npars <- c()
  for(j in 1:J){
    loglik <- objects[[j]]$logLik
    npars[j] <- objects[[j]]$p + objects[[j]]$q
    aic[j] <- -2*loglik + k*npars[j]
  }
  if(length(argnames)>1){
    aic <- data.frame(
      fit = argnames,
      aic = aic,
      npars = npars
    ) %>%
      dplyr::arrange(aic)
  }
  return(aic)
}
