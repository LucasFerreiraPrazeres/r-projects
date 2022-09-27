# histograma de taxas de perda para cada experimento de A para C e D

library(ggplot2)


# Quantidade de amostras
SAMPLE_QTD <- 50

# taxas de perda de pacotes
per_c <- read.table("../hosts/A/data/per-C.txt")
per_d <- read.table("../hosts/A/data/per-D.txt")

# gerando histograma
hist_per <- data.frame(
  exp = rep(seq(1, SAMPLE_QTD), times=2),
  host = c(rep("C", times=SAMPLE_QTD), rep("D", times=SAMPLE_QTD)),
  per = c(per_c[, 1], per_d[, 1])
)

ggplot(hist_per, aes(x=exp, y=per, color=host))+
  geom_bar(stat="identity", position=position_dodge(0.9))+
  facet_grid(. ~ exp, switch="x", scales="free_x", space="free_x")+
  scale_y_continuous(breaks=seq(0, max(hist_per["per"]), 1))+
  theme(
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank()
  )+
  labs( 
    title="Host A: Taxas de perda de pacotes por experimento",
    x="Experimento",
    y="Perda de pacotes (%)",
    color="Host testado"
  )
