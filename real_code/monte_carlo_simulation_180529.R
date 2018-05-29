#simulation
simul <- function(type, nA, nD, nCc, nAv, nround, nsim = 1e+5, error=0){
  mat <- Pm(type, nA, nD, nCc, nAv, error)
  M <- nrow(mat); score1 <- score[1,floor(as.numeric(rownames(mat)[-1]))]
  point <- unlist(c(0, score1)); 
  x <- rep(0,nsim);
  for (j in 1:nsim) {
    temp <- sample(M, 1, prob=mat[1,])
    x[j] <- floor(point[temp])
    for (i in 1:nround){  
      temp <- sample(M, 1, prob=mat[temp,]) 
      x[j] <- x[j] + floor(point[temp])
    }
  } 
  return(list(table(x)/length(x), mean(x)))
}
simul("Av", 5, 5, 5, 5, 5)
simul("A", 5, 5, 5, 5, 5)
simul("D", 5, 5, 5, 5, 5)
simul("Cc", 5, 5, 5, 5, 5)