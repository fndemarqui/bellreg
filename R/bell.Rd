

#' Probability function, distribution function, quantile function and random
#' generation for the Bell distribution with parameter theta.
#' 
#' Probability function, distribution function, quantile function and random
#' generation for the Bell distribution with parameter theta.
#' 
#' Probability mass function \deqn{ f(x) = \frac{\theta^{x}
#' e^{1-e^{\theta}}B_x}{x!}, } where \eqn{B_x} is the Bell number, and x = 0,
#' 1, ....
#' 
#' @aliases Bell dbell pbell qbell rbell
#' @param x vector of (non-negative integer) quantiles.
#' @param theta parameter of the Bell distribution (theta > 0).
#' @param log,log.p logical; if TRUE, probabilities p are given as log(p).
#' @param q vector of quantiles.
#' @param lower.tail logical; if TRUE (default), probabilities are \eqn{P[X \le
#' x]}; otherwise, \eqn{P[X > x]}.
#' @param p vector of probabilities.
#' @param n number of random values to return.
#' @return dbell gives the (log) probability function, pbell gives the (log)
#' distribution function, qbell gives the quantile function, and rbell
#' generates random deviates.
#' @keywords distribution
NULL





#' The 'bellreg' package.
#' 
#' Bell Regression models for count data with overdispersion. The implemented
#' models account for ordinary and zero-inflated regression models under both
#' frequentist and Bayesian approaches. Theorical details regarding the models
#' implemented in the package can be found in
#' \insertCite2018_Castellaresbellreg and \insertCite2020_Lemontebellreg
#' 
#' _PACKAGE
#' 
#' 
#' @aliases bellreg-package BellReg
#' @references Stan Development Team (2020). RStan: the R interface to Stan. R
#' package version 2.19.3. https://mc-stan.org
#' 
#' \insertRef2018_Castellaresbellreg
#' 
#' \insertRef2020_Lemontebellreg
NULL





#' Cells data set
#' 
#' Data set taken from \insertCite2012_Crawleybellreg and posteriorly analyzed
#' by \insertCite2020_Lemontebellreg. The data includes the count of infected
#' blood cells per square millimetre on microscope slides prepared from n = 511
#' randomly selected individuals.
#' 
#' 
#' @name cells
#' @docType data
#' @format A data frame with 511 rows and 5 variables: \itemize{ \item cells:
#' count of infected blood cells per square millimetre on microscope slides
#' \item smoker: smoking status of the subject (0: smoker; 1: non smoker) \item
#' gender: subject's gender (1: male; 0: female). \item age: subject's age
#' categorized into three levels: young (\eqn{ \le 20}), mid (21 to 59), and
#' old (\eqn{\ge 60}). \item weight: body mass score categorized into three
#' levels: normal, overweight, obese. }
#' @references \insertRef2012_Crawleybellreg
#' 
#' \insertRef2020_Lemontebellreg
#' @keywords datasets
NULL





#' Faults data set
#' 
#' Data set taken from \insertCite1982_Hindebellreg and posteriorly analyzed by
#' \insertCite2018_Castellaresbellreg. The data contains the number of faults
#' in rolls of fabric of different lengths.
#' 
#' 
#' @name faults
#' @docType data
#' @format A data frame with 32 rows and 2 variables: \itemize{ \item nf:
#' number of faults in rolls of fabric of different lengths. \item lroll:
#' length of the roll. }
#' @references \insertAllCited
#' @keywords datasets
NULL



