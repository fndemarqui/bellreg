

dzibell <- function(x, prob, theta, log = FALSE){
  p <- prob + (1-prob)*dbell(x, theta)
  if(log==TRUE){
    return(log(p))
  }else{
    return(p)
  }
  return(p)
}


pzibell <- function(q, prob, theta, lower.tail = TRUE, log.p = FALSE){
  P <- c()
  for(i in 1:length(q)){
    #prob[i] <- sum(dbell(0:q[i], theta, log=FALSE))
    P[i] <- ifelse(q[i] < 0, 0, sum(dzibell(0:q[i], prob, theta, log=FALSE)) )
  }
  if(lower.tail==FALSE){
    if(log.p==FALSE){
      return(1-P)
    }else{
      return(log(1-P))
    }
  }else{
    if(log.p==FALSE){
      return(P)
    }else{
      return(log(P))
    }
  }
}

# dbell(0, theta = 1)
# dzibell(0, prob = 0.2, theta = 1)
# dzibell(0, prob = 0.2, theta = 1, log = TRUE)
#
# pzibell(0:10, prob = 0.2, theta = 1)
