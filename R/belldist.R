

#' Probability function, distribution function, quantile function and random generation for the Bell distribution with parameter theta.
#' @name Belldist
#' @aliases Bell
#' @aliases dbell
#'
#' @keywords distribution
#' @concept Univariate
#' @concept Discrete
#'
#' @export
#'
#' @param x	vector of (non-negative integer) quantiles.
#' @param q	vector of quantiles.
#' @param p	vector of probabilities.
#' @param n	number of random values to return.
#' @param theta parameter of the Bell distribution (theta > 0).
#' @param log,log.p	 logical; if TRUE, probabilities p are given as log(p).
#' @param lower.tail	logical; if TRUE (default), probabilities are \eqn{P[X \le x]}; otherwise, \eqn{P[X > x]}.
#'
#' @details
#'
#' Probability mass function
#' \deqn{
#' f(x) = \frac{\theta^{x} e^{1-e^{\theta}}B_x}{x!},
#' }
#' where \eqn{B_x} is the Bell number, and x = 0, 1, ....
#' @return dbell gives the (log) probability function, pbell gives the (log) distribution function, qbell gives the quantile function, and rbell generates random deviates.
#'

dbell <- function(x, theta, log = FALSE){
  Bx <- c()
  for(i in 1:length(x)){
    Bx[i] <- numbers::bell(x[i])
  }
  lf <- x*log(theta) - exp(theta)+1 + log(Bx) - lgamma(x+1)
  if(log==TRUE){
    return(lf)
  }else{
    return(exp(lf))
  }
}


#' @rdname Belldist
#' @export
#'
pbell <- function(q, theta, lower.tail = TRUE, log.p = FALSE){
  prob <- c()
  for(i in 1:length(q)){
    #prob[i] <- sum(dbell(0:q[i], theta, log=FALSE))
    prob[i] <- ifelse(q[i] < 0, 0, sum(dbell(0:q[i], theta, log=FALSE)) )
  }
  if(lower.tail==FALSE){
    if(log.p==FALSE){
      return(1-prob)
    }else{
      return(log(1-prob))
    }
  }else{
    if(log.p==FALSE){
      return(prob)
    }else{
      return(log(prob))
    }
  }
}

#' @rdname Belldist
#' @export
#'
qbell <- function(p, theta, log.p = FALSE){
  n <- length(p)
  k <- rep(0, n)
  for(i in 1:n){
    q <- 0
    while(q <= p[i]){
      q <- pbell(k[i], theta)
      k[i] <- k[i] + 1
    }
  }
  if(log.p == TRUE){
    return(log(k-1))
  }else{
    return(k-1)
  }

}

#' @rdname Belldist
#' @export
#'
rbell <- function(n, theta){
  lambda <- exp(theta)-1
  x <- c()
  for(i in 1:n){
    N <- stats::rpois(1, lambda)
    x[i] <- sum(extraDistr::rtpois(n=N, lambda=theta, a=0, b=Inf))
  }
  return(x)
}




