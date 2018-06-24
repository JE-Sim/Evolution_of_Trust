#simulation
simul <- function(type, nA, nD, nCc, nAv, nround, nsim = 1e+5, error=0){
  mat <- Pm(type, nA, nD, nCc, nAv, error)
  M <- ncol(mat); score1 <- score[1,floor(as.numeric(colnames(mat)[-1]))]
  point <- unlist(c(0, score1)); 
  x <- rep(0,nsim);
  for (j in 1:nsim) {
    temp <- sample(M, 1, prob=mat[1,])
    x[j] <- floor(point[temp])
    for (i in 2:nround){  
      temp <- sample(M, 1, prob=mat[temp,]) 
      x[j] <- x[j] + floor(point[temp])
    }
  } 
  return(list(table(x)/length(x), mean(x)))
}

stat.simul <- function(type, nA, nD, nCc, nAv, nround, nsim = 1e+5, error=0){
  mat.0 <- Pm(type, nA, nD, nCc, nAv, error)
  mat <- stationary(mat.0)
  M <- ncol(mat); score1 <- score[1,floor(as.numeric(colnames(mat)[-1]))]
  point <- unlist(c(0, score1)); 
  x <- rep(0,nsim);
  for (j in 1:nsim) {
    temp <- sample(1:M, nround, replace=T, prob=mat)
    x[j] <- sum(point[temp])
  } 
  return(list(table(x)/length(x), mean(x)))
}