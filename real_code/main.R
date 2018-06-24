setwd("directional address")
source("scoreBoard_strategy.R", local=TRUE)
source("round_180507.R", local=TRUE)
source("evolution_180508.R", local=TRUE)
source("transition_matrix_180509.R", local=TRUE)
source("monte_carlo_simulation_180529.R", local=TRUE)
source("transMat_in_Nature.R", local=TRUE)
source("UnknownOpponent.R", local=TRUE)

unknownOpp()

# Nature circumstance
## probability of betray : 0.5
nat.simul("A", 10, pb=0.5)
nat.simul("D", 10, pb=0.5)
nat.simul("Cc", 10, pb=0.5)
nat.simul("Av", 10, pb=0.5)
## probability of betray : 0.7
nat.simul("A", 10, pb=0.7)
nat.simul("D", 10, pb=0.7)
nat.simul("Cc", 10, pb=0.7)
nat.simul("Av", 10, pb=0.7)

# 1 vs 1 game
game(10, "A", "D", error=0)
game(10, "A", "Cc", error=0)
game(10, "A", "Av", error=0)
game(10, "D", "Cc", error=0)
game(10, "D", "Av", error=0)
game(10, "Cc", "Av", error=0)

# Evolution of trust
ev.plot(10, 10, 10, 10, round=5, out=5, iter = 20, error = 0)
ev.plot(10, 10, 10, 10, round=5, out=5, iter = 20, error = 0.05)
ev.plot(2, 10, 2, 2, round=5, out=5, iter = 20, error = 0)

# Stationary Distrubution
e = 0 # 0.1, 0.3
Av.p <- Pm("Av", 1, 1, 1, 1, error=e)
A.p <- Pm("A", 1, 1, 1, 1, error=e)
D.p <- Pm("D", 1, 1, 1, 1, error=e)
Cc.p <- Pm("Cc", 1, 1, 1, 1, error=e)

As.p <- stationary(A.p); As.p
Avs.p <- stationary(Av.p); Avs.p
Ds.p <- stationary(D.p); Ds.p
Ccs.p <- stationary(Cc.p); Ccs.p
## Expected score
sum(As.p[-1]*score[1,floor(as.integer(colnames(As.p)[-1]))])
sum(Avs.p[-1]*score[1,floor(as.integer(colnames(Avs.p)[-1]))])
sum(Ccs.p[-1]*score[1,floor(as.integer(colnames(Ccs.p)[-1]))])
sum(Ds.p[-1]*score[1,floor(as.integer(colnames(Ds.p)[-1]))])

# Marcov chain monte carlo simulation
simul("A", 5, 5, 5, 5, 10, nsim=10000)
simul("D", 5, 5, 5, 5, 10, nsim=10000)
simul("Cc", 5, 5, 5, 5, 10, nsim=10000)
simul("Av", 5, 5, 5, 5, 10, nsim=10000)

simul("A", 1, 10, 1, 1, 10, nsim=10000)
simul("D", 1, 10, 1, 1, 10, nsim=10000)
simul("Cc", 1, 10, 1, 1, 10, nsim=10000)
simul("Av", 1, 10, 1, 1, 10, nsim=10000)