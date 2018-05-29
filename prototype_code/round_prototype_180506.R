score <- data.frame("C.C"= c(2, 2), "C.B"=c(-1, 3), "B.C"=c(3, -1), "B.B"=c(0, 0))
rownames(score) <- c("Me", "You")
#C=collaborate, B=Betray, Me.You
#Devil choice
D <- function(x, error) return(sample(c("B", "C"), 1, prob = c(1-error, error)))
#Angel choice
A <- function(x, error) return(sample(c("C", "B"), 1, prob = c(1-error, error)))
#Copycat choice _ last is your last choice
Cc <- function(last, error) {
  if(last == "B") return(sample(c("B", "C"), 1, prob = c(1-error, error)))
  else return(sample(c("C", "B"), 1, prob = c(1-error, error)))
}
#Avengerce choice _ memory : your betray
Av <- function(memory, error) {
  if(memory == "B") return(sample(c("B", "C"), 1, prob = c(1-error, error))) 
  else return(sample(c("C", "B"), 1, prob = c(1-error, error)))
}

#have a round (wrong code)
game <- function(n, me.0, you.0, error=0){
  cond1 <- 1; cond2 <- 1; i <- 0
  last.me <- "C"; last.you <- "C"; memory.me <- "C"; memory.you <- "C"
  if(me.0 == "Cc"){
    cond1 <- last.you; me.f <- M
  } else if(me.0 == "Av"){
    cond1 <- memory.me; me.f <- Av
  } else if(me.0 == "D") me.f <- D else if(me.0 == "A") me.f <- A
  else return("Please choose your type between 'A', 'D', 'Av', 'Cc'.")
  
  if(you.0 == "Cc") {
    cond2 <- last.me; you.f <- M
  } else if(you.0 == "Av"){
    cond2 <- memory.you; you.f <- Av
  } else if(you.0 == "D") you.f <- D else if(you.0 == "A") you.f <- A
  else return("Please choose opponent's type between 'A', 'D', 'Av', 'Cc'.")
  
  result <- matrix()
  while(i < n){
    me.1 <- me.f(cond1, error); you.1 <- you.f(cond2, error)
    result <- cbind(result, score[paste(me.1, you.1, sep=".")])
    if(you.1 == "B") memory.me <- "B"; if(me.1 == "B") memory.you <- "B"
    last.me <- me.1; last.you <- you.1
    i <- i+1
  }
  return(list(result[-1], rowSums(result[-1])))
}
game(5, "Cc", "D", error=0)