


extract_formulas <- function(object){
  call <- object$call
  formula <- call[2]
  formula <- as.list(formula)
  return(formula[[1]])
}


#---------------------------------------------
#' anova method for zibellreg models
#'
#' @aliases anova.zibellreg
#' @description Compute analysis of variance (or deviance) tables for one or more fitted model objects.
#' @importFrom stats anova
#' @export
#' @param ... further arguments passed to or from other methods.
#' @return  the ANOVA table.
#' @examples
#' \donttest{
#' library(bellreg)
#' data(cells)
#' fit1 <- zibellreg(cells ~ 1|smoker+gender, data = cells, approach = "mle")
#' fit2 <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
#' anova(fit1, fit2)
#' }
#'
anova.zibellreg <- function(...){
  models <- c(as.list(environment()), list(...))

  J <- nargs()
  labels <- paste0("Model ", 1:J, ":")
  # labels <- c()
  # for(j in 1:J){
  #   labels[j] <- with(models[[j]], paste0(baseline, "(", survreg ,")"))
  # }
  # labels <- paste0(labels, " ",1:J, ":")

  k <- c()
  df <- c()
  k[J] <- length(models[[J]]$fit$par)
  LR <- c()
  p.value <- c()
  loglik <- c()
  loglik[J] <- models[[J]]$loglik
  for(j in 1:(J-1)){
    loglik[j] <- models[[j]]$loglik
    LR[j] <- 2*(models[[J]]$loglik - models[[j]]$loglik)
    k[j] <- length(models[[j]]$fit$par)
    df[j] <- k[J]-k[j]
    p.value[j] <- stats::pchisq(LR[j], df = df[j], lower.tail = FALSE)
  }


  tab <- cbind("loglik" = loglik[-J], LR, df, 'Pr(>Chi)' = p.value)
  aux <- matrix(c(loglik[J], NA, NA, NA), nrow = 1)
  tab <- rbind(tab, aux)
  rownames(tab) <- labels
  formulas <- sapply(models, extract_formulas)

  cat("\n")
  for(j in 1:J){
    #cat("Model", j, ": ", deparse(formulas[[j]]), "\n")
    cat(labels[j], deparse(formulas[[j]]), "\n")
  }
  cat("--- \n")
  stats::printCoefmat(tab, P.values=TRUE, has.Pvalue = TRUE, na.print = "-")

}
