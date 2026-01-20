#' Print the summary.zibellreg output
#'
#' @export
#' @param x an object of the class summary.zibellreg.
#' @param ... further arguments passed to or from other methods.
#' @return a summary of the fitted model.
print.summary.zibellreg <- function(x, ...){
  if(x$approach=="mle"){
    cat("Call:\n")
    print(x$call)
    cat("\n")
    cat("Zero-inflated regression coefficients:\n")
    stats::printCoefmat(x$coefficients1, P.value=TRUE, has.Pvalue=TRUE)
    cat("\n")
    # cat("----------------------- \n")
    cat("\n")
    cat("Count regression coefficients:\n")
    stats::printCoefmat(x$coefficients2, P.value=TRUE, has.Pvalue=TRUE)
    cat("\n")
    cat("--- \n")
    cat("logLik =", x$logLik, " ", "AIC =", x$AIC,"\n")

  }else{
    cat("Call:\n")
    print(x$call)
    print(x$priors)
    cat("\n")
    cat("Zero-inflated regression coefficients:\n")
    print(x$coefficients1)
    cat("\n")
    cat("Count regression coefficients:\n")
    print(x$coefficients2)
    cat("--- \n")
    cat("Inference for Stan model: ", x$model_name, '.\n', sep = '')
    cat(x$chains, " chains, each with iter=", x$iter,
        "; warmup=", x$warmup, "; thin=", x$thin, "; \n",
        "post-warmup draws per chain=", x$n_kept[1], ", ",
        "total post-warmup draws=", sum(x$n_kept), ".\n\n", sep = '')

  }

}


#---------------------------------------------

#' Summary for the zibellreg model
#'
#' @aliases summary.zibellreg
#' @export
#' @param object an objecto of the class 'zibellreg'.
#' @param ... further arguments passed to or from other methods.
#'
summary.zibellreg <- function(object, ...){
  p <- object$p
  q <- object$q
  if(object$approach=="mle"){
    coefficients <- coef(object)
    V <- vcov(object)
    se <- sqrt(diag(V))
    zval <- coefficients / se
    TAB <- cbind(Estimate = coefficients,
                 StdErr = se,
                 z.value = zval,
                 p.value = 2*stats::pnorm(-abs(zval)))


    TAB1 <- TAB[1:q, , drop = FALSE]
    TAB2 <- TAB[-(1:q), , drop = FALSE]
    rownames(TAB1) <- object$labels1
    rownames(TAB2) <- object$labels2
    res <- list(call=object$call,
                coefficients = TAB,
                coefficients1=TAB1, coefficients2=TAB2,
                logLik=object$fit$value, AIC=object$AIC, approach=object$approach)

  }
  # Bayesiam output:
  else{
    labels1 <- object$labels1
    labels2 <- object$labels2
    s <- rstan::summary(object$fit)
    TAB <- round(s$summary, digits = 4)
    rn <- row.names(TAB)
    o <- c(grep("log_lik", rn), grep("coef_", rn), grep("lp__", rn))
    TAB <- TAB[-o, , drop = FALSE]
    TAB1 <- TAB[1:q, , drop = FALSE]
    TAB2 <- TAB[-(1:q), , drop = FALSE]
    rownames(TAB1) <- labels1
    rownames(TAB2) <- labels2


    n_kept <- object$fit@sim$n_save - object$fit@sim$warmup2
    res <- list(call=object$call,
                coefficients1=TAB1[, -c(2, 5, 7)], coefficients2=TAB2[, -c(2, 5, 7)],
                n_kept=n_kept, model_name=object$fit@model_name, priors = object$priors,
                chains=object$fit@sim$chains, warmup=object$fit@sim$warmup,
                thin=object$fit@sim$thin, iter=object$fit@sim$iter, approach=object$approach)
  }

  class(res) <- "summary.zibellreg"

  return(res)
}


