# série temporal dos atrasos dos pings do experimento exp-001-A-D

# buscando atrasos
times <- read.csv("../hosts/A/data/times-D.txt", header=FALSE)
times <- times[, 1]

# criando estrutura da série temporal
ts_times <- ts(times)

# plotando série temporal
plot(
  ts_times,
  main="Atrasos do experimento exp-001-A-D",
  xlab="Ping",
  ylab="Atraso (ms)",
  col="blue"
)
