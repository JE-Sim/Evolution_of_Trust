Pm <- function(type, nA, nD, nCc, nAv, error=0){
  pA <- nA/sum(c(nA, nD, nCc, nAv)); pD <- nD/sum(c(nA, nD, nCc, nAv))
  pCc <- nCc/sum(c(nA, nD, nCc, nAv)); pAv <- nAv/sum(c(nA, nD, nCc, nAv))
  pp <- (1-error)^2; pq <- error*(1-error); qq <- error^2
  if(type == "Av"){
    P <- matrix(0, ncol=11, nrow=11)
    rownames(P) <- colnames(P) <- c("start", 1, 2, 1.01, 2.01, 1.02, 3.02, 1.1, 2.1, 3.1, 4.1)
  } else{
    P <- matrix(0, ncol=7, nrow=7)
    rownames(P) <- colnames(P) <- c("start", 1, 2, 1.1, 2.1, 3.1, 4.1)
  }
  P1 <- matrix(c(pq, pp, qq, pq), nrow=2); P2 <- matrix(c(pp, pq, pq, qq), nrow=2)
  Q1 <- matrix(c(1-pD, pD, pD, 1-pD), nrow=2); Q2 <- matrix(c(pA+pCc, pD+pAv, pD+pAv, pA+pCc), nrow=2)
  Q3 <- matrix(c(pA, 1-pA, 1-pA, pA), nrow=2);
  if(type == "D"){
    p1 <- p2 <- p3 <- p4 <- p5 <- p6 <- p7 <- P1
  } else if(type == "A"){
    p1 <- p2 <- p3 <- p4 <- p5 <- p6 <- p7 <- P2
  } else if(type == "Cc"){
    p1 <- p2 <- p4 <- p6 <- P2; p3 <- p5 <- p7 <- P1
  } else if(type == "Av"){
    p3 <- p4 <- p5 <- p8 <- p9 <- p10 <- p11 <- P1
    p1 <- p2 <- p6 <- p7 <- P2
  } else return("Please choose your strategy type between 'A', 'D', 'Cc', 'Av'.")
  
  if(type=="Av"){
    P[1,c(2, 3, 7, 11)] <- as.vector(t(p1%*%Q1))
    P[2,c(2, 3, 7, 11)] <- as.vector(t(p2%*%Q1))
    P[3,c(4, 5, 10, 11)] <- as.vector(t(p3%*%Q1))
    P[4,c(4, 5, 10, 11)] <- as.vector(t(p4%*%Q1))
    P[5,c(4, 5, 10, 11)] <- as.vector(t(p5%*%Q1))
    P[6,c(6, 9, 7, 11)] <- as.vector(t(p6%*%Q2))
    P[7,c(6, 9, 7, 11)] <- as.vector(t(p7%*%Q2))
    P[8,8:11] <- as.vector(t(p8%*%Q2))
    P[9,8:11] <- as.vector(t(p9%*%Q2))
    P[10,8:11] <- as.vector(t(p10%*%Q3))
    P[11,8:11] <- as.vector(t(p11%*%Q3))
  } else {
    P[1,c(2, 3, 6, 7)] <- as.vector(t(p1%*%Q1))
    P[2,c(2, 3, 6, 7)] <- as.vector(t(p2%*%Q1))
    P[3,c(2, 3, 6, 7)] <- as.vector(t(p3%*%Q1))
    P[4,4:7] <- as.vector(t(p4%*%Q2))
    P[5,4:7] <- as.vector(t(p5%*%Q2))
    P[6,4:7] <- as.vector(t(p6%*%Q3))
    P[7,4:7] <- as.vector(t(p7%*%Q3))
  }
  if(type=="A" & error==0) return(P[1:3, 1:3]) # to solve Angel's error
  if(type=="Av" & error==0) return(P[c(1:3, 10, 11), c(1:3, 10, 11)])
  return(P[c(1, which(colSums(P) != 0)), c(1, which(colSums(P) != 0))])
}
# [c(1, which(colSums(P) != 0)), c(1, which(colSums(P) != 0))]

#stationary matrix
stationary <- function(P){
  p.i <- P-diag(nrow(P))
  p.i[,nrow(P)] <- 1
  v <- c(rep(0, nrow(P)-1), 1)
  pi <- v%*%solve(p.i)
  return(pi)
}


# library(expm)
# Av.p <- Pm("Av", 5, 5, 5, 5)
# A.p <- Pm("A", 5, 5, 5, 5)
# D.p <- Pm("D", 5, 5, 5, 5)
# Cc.p <- Pm("Cc", 5, 5, 5, 5)
# 
# A.s <- A.p %^% 100
# Av.s <- Av.p %^% 100
# D.s <- D.p %^% 100
# Cc.s <- Cc.p %^% 100
# 
 
# stationary(A.p)
# Av.s
# stationary(Av.p)
# Av.s
# stationary(D.p)
# D.s
# stationary(Cc.p)
# C.s
