evolution <- function(A=10, D=10, Cc=10, Av=10, round=5, out=5, iter = 20, error = 0){
  match <- rep(c('A', 'D', 'Cc', 'Av'), c(A, D, Cc, Av))
  x <- y <- 1:length(match)
  d1 <- expand.grid(x=x, y=y); league <- d1[d1[,1]<d1[,2],]
  k <- 1; Vis <- list(); s <- list()
  for(j in 1:iter){
    b <- rep(0, length(match)); names(b) <- match
    for(i in 1:nrow(league)){
      first <- match[league$x[i]]; second <- match[league$y[i]]
      result.1 <- game(round, first, second, error)
      b[league$x[i]] <- b[league$x[i]]+result.1[[2]][1]
      b[league$y[i]] <- b[league$y[i]]+result.1[[2]][2]
    }
    s[[j]] <- b
    if(length(unique(s[[j]]))==1 | length(unique(match))==1) break
    c <- sample(b); d <- sort(c)
    match <- c(rev(d)[1:out], d[-c(1:out)])
    match <- names(match)
    Vis[[j]] <- sort(match)
  }
  return(Vis)
  # return(s)
}
ev.plot <- function(A, D, Cc, Av, round=5, out=5, iter = 30, error = 0){
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
  par(las=2); par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=T)
  print(barplot(t(apply(tab, 2, rev)), horiz=TRUE, space=rep(0, length(k)), main="Who will win in the long run?", xlim = c(0, length(k[[1]])),
                xlab="# of each character", ylab="", col=c("tomato", "gold", "mediumaquamarine", "mediumpurple1")))
  print(legend("topright", inset = c(-0.35, 0.1), box.lty = 0, bty != "n", title = "Strategy",
               legend=c("Angel", "Devil", "Copycat", "Avengers"), fill=c("tomato", "gold", "mediumaquamarine", "mediumpurple1"), bg=c("gray87")))
  print(legend("top", inset = c(0, -0.12), legend=paste("mistake probability = ", error), bty ="n", pch=NA))
}
