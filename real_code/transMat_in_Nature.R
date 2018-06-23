Pm.nat <- function(type, pb=0.5, error=0){
  p <- 1-error; q <- error; c <- 1-pb; b <- pb
  mat <- matrix(0, ncol=5, nrow=5)
  rownames(mat) <- colnames(mat) <- c("start", 1:4)
  temp <- c(c, b, c, b); p1 <- c(p, p, q, q); p2 <- c(q, q, p, p)
  if(type=="Av") {
    mat <- matrix(0, ncol=7, nrow=7)
    rownames(mat) <- colnames(mat) <- c("start", 1:2, 1:4+0.1)
    mat[c(2, 3, 6, 7), 1:2] <- temp*p1
    mat[4:7, 3:7] <- temp*p2
  }
  if(type=="A"){
    mat[2:5, ] <- temp*p1
  } else if(type=="D"){
    mat[2:5, 1:5] <- temp*p2
  } else if(type=="Cc"){
    mat[2:5, c(1, 2, 4)] <- temp*p1
    mat[2:5, c(3, 5)] <- temp*p2
  }
  return(t(mat[c(1, which(rowSums(mat)!=0)), c(1, which(rowSums(mat)!=0))]))
}
#Pm.nat("A", 0.5)
#Pm.nat("D", 0.5)
#Pm.nat("Cc", 0.5)
#Pm.nat("Av", 0.5)

#pb : probability of opponent's betray
nat.simul <- function(type, nround, pb=0.5, nsim = 1e+5, error=0){
  mat <- Pm.nat(type, pb, error)
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
  return(list(distribution=table(x)/length(x), mean=mean(x)))
}
#pb=0.3, 0.5, 0.7
#nat.simul("A", 5, pb=0.7)
#nat.simul("D", 5, pb=0.7)
#nat.simul("Av", 5, pb=0.7)
#nat.simul("Cc", 5, pb=0.7)
