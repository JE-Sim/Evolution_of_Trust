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