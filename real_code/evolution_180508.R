source("round_180507.R")
evolution <- function(A=10, D=10, Cc=10, Av=10, round=5, out=5, iter = 20, error = 0, rep=500){
  match <- rep(c('A', 'D', 'Cc', 'Av'), c(A, D, Cc, Av))
  x <- y<- 1: length(match)
  d1 <- expand.grid(x=x, y=y); league <- d1[d1[,1]<d1[,2],]
  k <- 1; Vis <- list(); s <- list()
  
  for(j in 1:iter){
    b <- rep(0, length(match)); names(b) <- match
    for(i in 1:ncol(league)){
      first <- match[league[1,i]]; second <- match[league[2,i]]
      result.1 <- game(round, first, second, error)
      b[league[1,i]] <- b[league[1,i]]+result.1[[2]][1]
      b[league[2,i]] <- b[league[2,i]]+result.1[[2]][2]
    }
    s[[j]] <- b
    if(length(unique(s[[j]]))==1) break
    c <- sample(b); d <- sort(c)
    match <- c(rev(d)[1:out], d[-c(1:out)])
    match <- names(match)
    Vis[[j]] <- sort(match)
  }
  return(Vis)
  #  return(s)
}

ev.plot <- function(A=8, D=8, Cc=8, Av=8, round=5, out=5, iter = 20, error = 0){
  k <- evolution(A, D, Cc, Av, round, out, iter, error)
  tab <- matrix(0, length(k), 4)
  colnames(tab) <- c("A", "D", "Cc", "Av")
  for (i in 1:length(k)){
    tab[i,1] <- length(which(k[[i]]=="A"))
    tab[i,2] <- length(which(k[[i]]=="D"))
    tab[i,3] <- length(which(k[[i]]=="Cc"))
    tab[i,4] <- length(which(k[[i]]=="Av"))
  }
  rownames(tab) <- paste("trial", 1:length(k))
  print(barplot(t(apply(tab, 2, rev)), horiz=TRUE, space=rep(0, length(k)), main="Who will win in the long run?", xlab="# of each character", ylab="trial", col=c("red", "yellow", "green", "blue")))
  print(legend("topright", legend=c("Angel", "Devil", "Copycat", "Avengers"), fill=c("red", "yellow", "green", "blue"), bg="gray"))
}
ev.plot()
