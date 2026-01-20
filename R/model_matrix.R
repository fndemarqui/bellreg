
#' Construct Design Matrices for zibellreg models
#' @param object an object of class 'zibellreg'.
#' @param which character indicating which design matrix to extract: "all" (default), "zero", or "count".
#' @param ... further arguments passed to or from other methods.
#' @return A design matrix.
#' @export
#' @examples
#' library(bellreg)
#' data(cells)
#' fit <- zibellreg(formula = cells ~ smoker + gender | age, data = cells, approach = "mle")
#' head(model.matrix(fit))
#' head(model.matrix(fit, "all"))
#' head(model.matrix(fit, "zero"))
#' head(model.matrix(fit, "count"))
#'
model.matrix.zibellreg <- function(object, which = c("all", "zero", "count"), ...){
  which <- match.arg(which)
  if(which == "all"){
    formula <- object$formula
  }else{
    formula <- Formula::as.Formula(extract_formulas(object))
  }
  mf <- object$mf
  X <- switch (which,
               "all" = stats::model.matrix(formula, data = mf, rhs = 0),
               "zero" = stats::model.matrix(formula, data = mf, rhs = 1),
               "count" = stats::model.matrix(formula, data = mf, rhs = 2)
  )
  return(X)
}
