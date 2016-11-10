


load('../RData/trTable.RData')
load('../RData/trip.RData')
load('../RData/df.RData')

library(ggplot2)

end<-trTable[,1][!trip$isTrip]  

start<-apply(as.data.frame(end),2,function(x){x+1})
startCoor<-trTable[start,c(1,4,5)]
endCoor<-trTable[end,c(1,4,5)]  
  
startCoor<-rbind(trTable[1,c(1,4,5)],startCoor) 
startCoor[-c(nrow(trTable)),]
endCoor<-rbind(endCoor,trTable[nrow(trTable),c(1,4,5)])  

startCoor<-as.data.frame(startCoor)
endCoor<-as.data.frame(endCoor)
n<-nrow(startCoor)
startCoor<-startCoor[1:n-1,]
endCoor<-endCoor[1:n-1,]

startOrEnd<-data.frame()
startOrEnd<-rep('start', nrow(startCoor))
startCoor<-cbind(startCoor,startOrEnd)

startOrEnd<-data.frame()
startOrEnd<-rep('end', nrow(endCoor))
endCoor<-cbind(endCoor,startOrEnd)

combined<-rbind(startCoor,endCoor)

png('../Graphs/startEnd_All.png')

p <- ggplot(combined, aes(combined[,2], combined[,3], colour=factor(combined[,4]))) + geom_point()+
  xlab('Latitude')+
  ylab('Longitude')+
  ggtitle('start point vs end point')
print(p)
dev.off()


sub1_Combined<-subset(combined, ((lat>-8.67000)&(lat< -8.57000)&(long>41.13000)&(long<41.20000)))

png('../Graphs/startEnd_subset.png')

p <- ggplot(sub1_Combined, aes(sub1_Combined[,2], sub1_Combined[,3], colour=factor(sub1_Combined[,4]))) + geom_point()+
  xlab('Latitude')+
  ylab('Longitude')+
  ggtitle('start point vs end point')
print(p)
dev.off()