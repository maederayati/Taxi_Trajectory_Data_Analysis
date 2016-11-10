library(ggplot2)



load('../RData/sub1.RData')
load('../RData/sub2.Rdata')
load('../RData/sub3.Rdata')
load('../RData/sub4.Rdata')

load('../RData/km5c.Rdata')
load('../RData/km10c.Rdata')
load('../RData/km15c.Rdata')

load('../RData/km5s1.Rdata')
load('../RData/km10s1.Rdata')
load('../RData/km15s1.Rdata')

load('../RData/km5s2.Rdata')
load('../RData/km10s2.Rdata')
load('../RData/km15s2.Rdata')

load('../RData/km5s3.Rdata')
load('../RData/km10s3.Rdata')
load('../RData/km15s3.Rdata')

load('../RData/km5s4.Rdata')
load('../RData/km10s4.Rdata')
load('../RData/km15s4.Rdata')




png("../Graphs/Cluster5c.png")
p <- ggplot(trTable, aes(trTable[,4], trTable[,5], colour = factor(km5c$cluster))) + geom_point()+
  xlab('Latitude')+
  ylab('Longitude')
print(p)
dev.off()

png("../Graphs/Cluster5s1.png")
p <- ggplot(sub1, aes(sub1[,4], sub1[,5], colour = factor(km5s1$cluster))) + geom_point()+
  xlab('Latitude')+
  ylab('Longitude')
print(p)
dev.off()


png("../Graphs/Cluster5s2.png")
p <- ggplot(sub2, aes(sub2[,4], sub2[,5], colour = factor(km5s2$cluster))) + geom_point()+
  xlab('Latitude')+
  ylab('Longitude')
print(p)
dev.off()

png("../Graphs/Cluster5s3.png")
p <- ggplot(sub3, aes(sub3[,4], sub3[,5], colour = factor(km5s3$cluster))) + geom_point()+
  xlab('Latitude')+
  ylab('Longitude')
print(p)
dev.off()

png("../Graphs/Cluster5s4.png")
p <- ggplot(sub4, aes(sub4[,4], sub4[,5], colour = factor(km5s4$cluster))) + geom_point()+
  xlab('Latitude')+
  ylab('Longitude')
print(p)
dev.off()