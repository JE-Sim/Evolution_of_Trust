Pm <- function(type, nA, nD, nCc, nAv, error=0){
  pA <- nA/sum(c(nA, nD, nCc, nAv)); pD <- nD/sum(c(nA, nD, nCc, nAv))
  pCc <- nCc/sum(c(nA, nD, nCc, nAv)); pAv <- nAv/sum(c(nA, nD, nCc, nAv))
  pp <- (1-error)^2; pq <- error*(1-error); qq <- error^2
  P <- matrix(0, ncol=7, nrow=7)
  rownames(P) <- colnames(P) <- c("start", 1, 2, 1.1, 2.2, 3.1, 4.1)
  P1 <- matrix(c(pq, pp, qq, pq), nrow=2); P2 <- matrix(c(pp, pq, pq, qq), nrow=2)
  Q1 <- matrix(c(1-pD, pD, pD, 1-pD), nrow=2); Q2 <- matrix(c(pA+pCc, pD+pAv, pD+pAv, pA+pCc), nrow=2)
  Q3 <- matrix(c(pA, 1-pA, 1-pA, pA), nrow=2)
  if(type == "D"){
    p1 <- p2 <- p3 <- p4 <- p5 <- p6 <- p7 <- P1
  } else if(type == "A"){
    p1 <- p2 <- p3 <- p4 <- p5 <- p6 <- p7 <- P2
  } else if(type == "Cc"){
    p1 <- p2 <- p4 <- p6 <- P2; p3 <- p5 <- p7 <- P1
  } else if(type == "Av"){
    p1 <- p2 <- P2; p3 <- p4 <- p5 <- p6 <- p7 <- P1
  } else return("Please choose your strategy type between 'A', 'D', 'Cc', 'Av'.")
  
  P[1,c(2, 3, 6, 7)] <- as.vector(t(p1%*%Q1))
  P[2,c(2, 3, 6, 7)] <- as.vector(t(p2%*%Q1))
  P[3,c(2, 3, 6, 7)] <- as.vector(t(p3%*%Q1))
  P[4,4:7] <- as.vector(t(p4%*%Q2))
  P[5,4:7] <- as.vector(t(p5%*%Q2))
  P[6,4:7] <- as.vector(t(p6%*%Q3))
  P[7,4:7] <- as.vector(t(p7%*%Q3))
  return(P)
}

Pm("D", 5, 5, 5, 5)