#' @importFrom generics tidy
#' @export
generics::tidy

#' Tidy a bellreg object
#' @aliases tidy.bellreg
#' @importFrom broom tidy
#' @importFrom tibble as_tibble
#' @export
#' @param x a fitted model object.
#' @param conf.int Logical indicating whether or not to include a confidence interval in the tidied output. Defaults to FALSE.
#' @param conf.level the confidence level required.
#' @details Convert a fitted model into a tibble.
#' @param ... further arguments passed to or from other methods.
#' @return a tibble with a summary of the fit.
#' @examples
#' \donttest{
#' library(bellreg)
#' data(faults)
#' fit <- bellreg(nf ~ lroll, data = faults, approach = "mle")
#' tidy(fit)
#' }
#'
tidy.bellreg <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {

  result <- summary(x)$coefficients %>%
    tibble::as_tibble(rownames = "term")
  colnames(result) <- c("term", "estimate", "std.error", "statistic", "p.value")
  if(conf.int){
    ci <- confint(x, level = conf.level)
    names(ci) <- c("conf.low", "conf.high")
    ci <- ci %>%
      tibble::as_tibble(rownames = "term")
    result <- dplyr::left_join(result, ci, by = "term")
  }
  return(result)
}



#' Tidy a zibellreg object
#' @aliases tidy.zibellreg
#' @importFrom broom tidy
#' @export
#' @param x a fitted model object.
#' @param conf.int Logical indicating whether or not to include a confidence interval in the tidied output. Defaults to FALSE.
#' @param conf.level the confidence level required.
#' @details Convert a fitted model into a tibble.
#' @param ... further arguments passed to or from other methods.
#' @return a tibble with a summary of the fit.
#' @examples
#' \donttest{
#' library(bellreg)
#' data(cells)
#' fit <- zibellreg(cells ~ smoker+gender|smoker+gender, data = cells, approach = "mle")
#' tidy(fit)
#' }
#'
tidy.zibellreg <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {

  result <- summary(x)$coefficients %>%
    tibble::as_tibble(rownames = "term")
  colnames(result) <- c("term", "estimate", "std.error", "statistic", "p.value")
  if(conf.int){
    ci <- confint(x, level = conf.level)
    names(ci) <- c("conf.low", "conf.high")
    ci <- ci %>%
      tibble::as_tibble(rownames = "term")
    result <- dplyr::left_join(result, ci, by = "term")
  }
  return(result)
}

