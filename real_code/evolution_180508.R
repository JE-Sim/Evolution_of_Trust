#league match / not monte carlo
evolution <- function(A=8, D=8, Cc=8, Av=6, iter = 20, error = 0){
  match <- rep(c('A', 'D', 'Cc', 'Av'), c(A, D, Cc, Av))
  league <- combn(1:length(match), 2); Vis <- list(); s <- list()
  for(j in 1:iter){
    b <- rep(0, length(match)); names(b) <- match
    for(i in 1:ncol(league)){
      first <- match[league[1,i]]; second <- match[league[2,i]]
      result.1 <- game2(5, first, second, error)
      b[league[,i][1]] <- b[league[,i][1]]+result.1[[2]][1]
      b[league[,i][2]] <- b[league[,i][2]]+result.1[[2]][2]
    }
    s[[j]] <- b
    if(length(unique(s[[j]]))==1) break
    c <- sample(b); d <- sort(c)
    match <- c(rev(d)[1:5], d[-c(1:5)])
    match <- names(match)
    Vis[[j]] <- sort(match)
  }
  return(Vis)
  #  return(s)
}