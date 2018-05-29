setwd("direction address")
source("scoreBoard_strategy.R")
unknownOpp <- function(n=NULL, nA=NULL, nD=NULL, nCc=NULL, nAv=NULL, error=NULL){
  if(is.null(n)) n <- as.integer(readline("how many rounds : "))
  while(class(n)!="integer" | n <= 0 | is.na(n)) n <- as.integer(readline("Please write positive number. how many rounds : "))
  if(is.null(nA)) nA <- as.integer(readline("how many Angels : "))
  while(class(nA)!="integer" | nA < 0 | is.na(nA)) nA <- as.integer(readline("Please write non negative number. how many Angels : "))
  if(is.null(nD)) nD <- as.integer(readline("how many Devils : "))
  while(class(nD)!="integer" | nD < 0 | is.na(nD)) nD <- as.integer(readline("Please write non negative number. how many Devils : "))
  if(is.null(nCc)) nCc <- as.integer(readline("how many Copycats : "))
  while(class(nCc)!="integer" | nCc < 0 | is.na(nCc)) nCc <- as.integer(readline("Please write non negative number. how many Copycats : "))
  if(is.null(nAv)) nAv <- as.integer(readline("how many Avengers : "))
  while(class(nAv)!="integer" | nAv < 0 | is.na(nAv)) nAv <- as.integer(readline("Please write non negative number. how many Avengers : "))
  if(is.null(error)) error <- as.numeric(readline("choose the decision error term between 0 to 0.5 : "))
  while(class(error) != "numeric" | error < 0 | error > 0.5 | is.na(error)) error <- as.numeric(readline("Please choose the decision error term between 0 to 0.5 : "))
  
  cond <- "C"; i <- 0; pop <- sum(nA+nD+nCc+nAv)
  you.0 <- sample(c("A", "D", "Cc", "Av"), 1, prob=c(nA, nD, nCc, nAv)/pop)
  last.me <- "C"; last.you <- "C"; memory.you <- "C"
  
  if(you.0 == "Cc"){
    you.f <- Cc; you <- "Copycat"
  } else if(you.0=="Av") {
    you.f <- Av; you <- "Avengers"
  } else if(you.0=="D") {
    you.f <- D; you <- "Devil"
  } else {
    you.f <- A; you <- "Angel"
  }
  
  result <- matrix()
  while(i < n){
    me.1 <- readline("choose your decision 'C'(Contribution) / 'B'(Betray) : ")
    while(!(me.1 %in% c("C", "B"))) me.1 <- readline("Please choose your decision 'C'(Contribution) / 'B'(Betray) : ")
    you.1 <- you.f(cond, error)
    result <- cbind(result, score[paste(me.1, you.1, sep=".")])
    if(you.1 == "B") memory.me <- "B"; if(me.1 == "B") memory.you <- "B"
    last.me <- me.1; last.you <- you.1
    if(you.0 == "Cc") cond <- last.me else if(you.0 == "Av") cond2 <- memory.you
    print(t(score[paste(me.1, you.1, sep=".")]))
    i <- i+1
  }
  total <- rowSums(result[-1])
  result1 <- ifelse(total[1] > total[2], "Win!", "Lose.")
  print(paste(paste("You", result1), paste("Your Opponents was", you)))
  return(cbind(result[-1], total=total))
}

unknownOpp()
