library(network)
library(sna)
library(ggplot2)
library(ggnet)
library(GGally)
library(reshape2)

load('../RData/clusterTransitionTable.RData')




png("../Graphs/travelAmongClusters_included.png")
p<-ggplot(clusterTransitionTable, aes(x = clusterTransitionTable$from, y = clusterTransitionTable$to)) + 
  geom_tile(aes(fill = frequency)) + 
  scale_fill_gradient(name = 'Travel Among Clusters', low = 'white', high = 'red')+ 
  xlab("From Cluster Number")+
  ylab("To Cluster Number")


  
print(p)
dev.off()

png("../Graphs/travelAmongClusters_excluded.png")

subset<-subset(clusterTransitionTable, (clusterTransitionTable$to!=clusterTransitionTable$from))
p<-ggplot(subset, aes(x = subset$from, y = subset$to)) + 
  geom_tile(aes(fill = frequency)) + 
  scale_fill_gradient(name = 'Travel Among Clusters', low = 'white', high = 'red')+ 
  xlab("From Cluster Number")+
  ylab("To Cluster Number")
  



print(p)
dev.off()

# 
#  png('netgraph.png')
#  clusterTransitionTable<-as.matrix(clusterTransitionTable)
#  net<- network(clusterTransitionTable, directed = T)
#  #net %e% "weight" <- sample(1:3, network.edgecount(n), replace = TRUE)
#  n<-ggnet(net, label = TRUE, arrow.size = 10, size=5)
# 
#  print(n)
#  dev.off()