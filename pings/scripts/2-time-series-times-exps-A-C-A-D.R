# série temporal das médias dos atrasos de cada experimento A-C e A-D

library(ggplot2)


# Quantidade de amostras
SAMPLE_QTD <- 50
# Tamanho das amostras
SAMPLE_LEN <- 30
# nível de confiança
TRUST_LEVEL <- 0.95

# atrasos dos hosts
times_c <- read.csv("../hosts/A/data/times-C.txt", header=FALSE)
times_d <- read.csv("../hosts/A/data/times-D.txt", header=FALSE)

# médias dos atrasos
means_c <- c()
means_d <- c()

# intervalo de confiança das médias
cimin_c <- c()
cimax_c <- c()
cimin_d <- c()
cimax_d <- c()

for (exp in 1:SAMPLE_QTD) {
  means_c <- append(means_c, mean(times_c[, exp], na.rm=TRUE))
  means_d <- append(means_d, mean(times_d[, exp], na.rm=TRUE))
  
  # desvio padrão do experimento atual
  sd_c <- sd(times_c[, exp], na.rm=TRUE)
  sd_d <- sd(times_d[, exp], na.rm=TRUE)
  
  # margem de erro do experimento atual
  margin_c <- (qt(TRUST_LEVEL, df=(SAMPLE_LEN - 1)) * sd_c) / sqrt(SAMPLE_LEN)
  margin_d <- (qt(TRUST_LEVEL, df=(SAMPLE_LEN - 1)) * sd_d) / sqrt(SAMPLE_LEN)
  
  # intervalo de confiança das médias
  cimin_c <- append(cimin_c, (means_c[exp] - margin_c))
  cimax_c <- append(cimax_c, (means_c[exp] + margin_c))
  cimin_d <- append(cimin_d, (means_d[exp] - margin_d))
  cimax_d <- append(cimax_d, (means_d[exp] + margin_d))
}

# gerando série temporal dos hosts
ts_means <- data.frame(
  xrange = 1:SAMPLE_QTD,
  host = rep(c("D", "C"), each=SAMPLE_QTD),
  means = c(means_d, means_c),
  cimin = c(cimin_d, cimin_c),
  cimax = c(cimax_d, cimax_c)
)
ggplot(ts_means, aes(x=xrange, y=means, color=host))+
  labs( 
    title="Host A: Média de atrasos",
    x="Experimento",
    y="Média de atraso (ms)",
    color="Host testado"
  )+
  geom_line(aes(color=host))+
  geom_point(aes(color=host))+
  geom_errorbar(aes(ymin=cimin, ymax=cimax, color=host))+
  scale_x_continuous(breaks=seq(0, max(ts_means["xrange"]), 5))+
  scale_y_continuous(breaks=seq(0, max(ts_means["cimax"]), 30))
