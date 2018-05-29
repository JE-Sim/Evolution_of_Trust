#league match / not monte carlo
evolution <- function(n.A=5, n.D=5, n.Cc=5, n.Av=5, iter = 20, error = 0){
  match <- rep(c('A', 'D', 'Cc', 'Av'), c(n.A, n.D, n.Cc, n.Av))
  league <- combn(1:length(match), 2)
  for(j in 1:iter){
    b <- rep(0, length(match)); names(b) <- match
    for(i in 1:ncol(league)){
      first <- match[league[1,i]]; second <- match[league[2,i]]
      result.1 <- game2(5, first, second, error)
      b[league[,i][1]] <- b[league[,i][1]]+result.1[[2]][1]
      b[league[,i][2]] <- b[league[,i][2]]+result.1[[2]][2]
    }
    match[sample(which(b == min(b)), 1)] <- match[sample(which(b == max(b)), 1)]
    print(sort(match))
    if(length(table(match))==1) break
  }
}

evolution(n.A=5, n.D=5, n.Av=0, n.Cc=5, iter=200)