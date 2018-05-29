#right round code.
source("scoreBoard_strategy.R")
game <- function(n, me.0, you.0, error=0){
  cond1 <- "C"; cond2 <- "C"; i <- 0
  last.me <- "C"; last.you <- "C"; memory.me <- "C"; memory.you <- "C"
  
  if(me.0 == "Cc") {
    me.f <- Cc
  } else if(me.0=="Av") {
    me.f <- Av
  } else if(me.0=="D") {
    me.f <- D 
  } else if(me.0 =="A") {
    me.f <- A
  } else return("Please choose your strategy between 'A', 'D', 'Av', 'Cc'.")
  if(you.0 == "Cc"){
    you.f <- Cc
  } else if(you.0=="Av") {
    you.f <- Av 
  } else if(you.0=="D") {
    you.f <- D
  } else if(you.0 =="A") {
    you.f <- A
  } else return("Please choose your opponent's strategy between 'A', 'D', 'Av', 'Cc'.")
  
  result <- matrix()
  while(i < n){
    me.1 <- me.f(cond1, error); you.1 <- you.f(cond2, error)
    result <- cbind(result, score[paste(me.1, you.1, sep=".")])
    if(you.1 == "B") memory.me <- "B"; if(me.1 == "B") memory.you <- "B"
    last.me <- me.1; last.you <- you.1
    if(me.0 == "Cc") cond1 <- last.you else if(me.0 == "Av") cond1 <- memory.me
    if(you.0 == "Cc") cond2 <- last.me else if(you.0 == "Av") cond2 <- memory.you
    i <- i+1
  }
  return(list(result[-1], rowSums(result[-1])))
}
