
#' @importFrom stats nobs
#' @export
nobs.bellreg <- function(object, ...){
  object$n
}

#' @export
nobs.zibellreg <- function(object, ...){
  object$n
}


#' @export
extractAIC.bellreg <- function(fit, scale, k=2, ...){
  edf <- length(fit$fit$par)
  loglik <- fit$loglik
  c(edf, -2*loglik + k*edf)
}

#' @export
extractAIC.zibellreg <- function(fit, scale, k=2, ...){
  edf <- length(fit$fit$par)
  loglik <- fit$loglik
  c(edf, -2*loglik + k*edf)
}




## VERIFICAR ESSA FUNÇÃO, ALGUMA COISA PARECE NÃO ESTAR FUNCIONANDO QDO A FUNÇÃO STEP É CHAMADA...
#' @importFrom stats formula update
#' @export
update.zibellreg <- function (object, formula., ..., evaluate = TRUE){
  call <- object$call
  if(is.null(call)) stop("need an object with call component")
  extras <- match.call(expand.dots = FALSE)$...
  #if(!missing(formula.)) call$formula <- formula(update(Formula::Formula(extract_formulas(object)), Formula::Formula(formula.)))
  if(!missing(formula.)) call$formula <- formula(update(Formula::Formula(extract_formulas(object)), formula.))
  if(length(extras)) {
    existing <- !is.na(match(names(extras), names(call)))
    for (a in names(extras)[existing]) call[[a]] <- extras[[a]]
    if(any(!existing)) {
      call <- c(as.list(call), extras[!existing])
      call <- as.call(call)
    }
  }
  if(evaluate) eval(call, parent.frame())
  else call
}


