#' The Truncated Poisson Distribution
#'
#' Density, distribution function, quantile function, and random generation
#' for the truncated Poisson distribution with parameter \code{lambda},
#' truncated to the interval \code{(lower, upper]}.
#'
#' @param x vector of (non-negative integer) quantiles.
#' @param lambda vector of (non-negative) Poisson means.
#' @param lower vector of lower truncation bounds (exclusive).
#' @param upper vector of upper truncation bounds (inclusive).
#' @param log logical; if \code{TRUE}, probabilities \code{p} are given as \code{log(p)}.
#'
#' @details
#' The truncated Poisson distribution has density
#' \deqn{f(x) = \frac{P(X = x)}{P(a < X \le b)}}{f(x) = P(X = x) / P(a < X <= b)}
#' for \eqn{x \in \{a+1, a+2, \ldots, b\}}{x in {a+1, a+2, ..., b}}, where \eqn{X \sim \text{Poisson}(\lambda)}{X ~ Poisson(lambda)},
#' \eqn{a} is the \code{lower} bound and \eqn{b} is the \code{upper} bound.
#'
#' @return
#' \code{dtpois} gives the density.
#'
#' @seealso \code{\link{ptpois}}, \code{\link{qtpois}}, \code{\link{rtpois}}
#'
#' @examples
#' # Density of truncated Poisson (lambda=5, truncated to (0, 10])
#' dtpois(1:10, lambda = 5, lower = 0, upper = 10)
#'
#' @export
dtpois <- function(x, lambda, lower, upper, log = FALSE) {
  # Standardize lengths (vectorization)
  n <- max(length(x), length(lambda), length(lower), length(upper))
  x <- rep_len(x, n)
  lambda <- rep_len(lambda, n)
  lower <- rep_len(lower, n)
  upper <- rep_len(upper, n)

  # Calculate normalization constant: P(a < X <= b)
  pa <- stats::ppois(lower, lambda)
  pb <- stats::ppois(upper, lambda)

  # Log-density of standard Poisson
  log_num <- stats::dpois(x, lambda, log = TRUE)

  # Log-density of truncated Poisson
  # result = log( dpois / (pb - pa) )
  log_dens <- log_num - log(pb - pa)

  # Set values outside truncation bounds to -Inf (or 0 if not log)
  out_of_bounds <- x <= lower | x > upper | x != floor(x)
  log_dens[out_of_bounds] <- -Inf

  # Handle invalid parameters
  invalid <- lambda < 0 | upper < lower
  log_dens[invalid] <- NaN

  if (any(invalid)) warning("NaNs produced")

  if (log) return(log_dens) else return(exp(log_dens))
}

#' @rdname dtpois
#' @param q vector of quantiles.
#' @param lower.tail logical; if \code{TRUE} (default), probabilities are \eqn{P[X \le x]}{P[X <= x]},
#'   otherwise, \eqn{P[X > x]}.
#' @param log.p logical; if \code{TRUE}, probabilities \code{p} are given as \code{log(p)}.
#'
#' @return
#' \code{ptpois} gives the distribution function.
#'
#' @examples
#' # CDF of truncated Poisson
#' ptpois(3, lambda = 5, lower = 0, upper = 10)
#'
#' @export
ptpois <- function(q, lambda, lower, upper, lower.tail = TRUE, log.p = FALSE) {
  n <- max(length(q), length(lambda), length(lower), length(upper))
  q <- rep_len(q, n)
  lambda <- rep_len(lambda, n)
  lower <- rep_len(lower, n)
  upper <- rep_len(upper, n)
  
  pa <- stats::ppois(lower, lambda)
  pb <- stats::ppois(upper, lambda)
  pq <- stats::ppois(q, lambda)
  
  # CDF formula: (P(X <= q) - P(X <= a)) / (P(X <= b) - P(X <= a))
  p <- (pq - pa) / (pb - pa)
  
  # Constraints
  p[q <= lower] <- 0
  p[q > upper] <- 1
  
  if (!lower.tail) p <- 1 - p
  
  invalid <- lambda <= 0 | upper < lower
  p[invalid] <- NaN
  if (any(invalid)) warning("NaNs produced")
  
  if (log.p) return(log(p)) else return(p)
}

#' @rdname dtpois
#' @param p vector of probabilities.
#'
#' @return
#' \code{qtpois} gives the quantile function.
#'
#' @examples
#' # Quantile function of truncated Poisson
#' qtpois(0.5, lambda = 5, lower = 0, upper = 10)
#'
#' @export
qtpois <- function(p, lambda, lower, upper, lower.tail = TRUE, log.p = FALSE) {
  if (log.p) p <- exp(p)
  if (!lower.tail) p <- 1 - p

  n <- max(length(p), length(lambda), length(lower), length(upper))
  p <- rep_len(p, n)
  lambda <- rep_len(lambda, n)
  lower <- rep_len(lower, n)
  upper <- rep_len(upper, n)

  pa <- stats::ppois(lower, lambda)
  pb <- stats::ppois(upper, lambda)

  # Inverse CDF using the probability transform
  # Target p_raw = pa + p * (pb - pa)
  res <- stats::qpois(pa + p * (pb - pa), lambda)

  invalid <- lambda < 0 | upper < lower | p < 0 | p > 1
  res[invalid] <- NaN
  if (any(invalid)) warning("NaNs produced")

  return(res)
}

#' @rdname dtpois
#' @param n number of observations. If \code{length(n) > 1}, the length is taken to be the number required.
#'
#' @return
#' \code{rtpois} generates random deviates.
#'
#' @examples
#' # Random generation from truncated Poisson
#' rtpois(10, lambda = 5, lower = 0, upper = 10)
#'
#' @export
rtpois <- function(n, lambda, lower, upper) {
  lambda <- rep_len(lambda, n)
  lower <- rep_len(lower, n)
  upper <- rep_len(upper, n)

  # Sample via Inverse Transform Sampling
  u <- runif(n)
  res <- qtpois(u, lambda, lower, upper)

  if (any(is.na(res))) warning("NAs produced")
  return(res)
}