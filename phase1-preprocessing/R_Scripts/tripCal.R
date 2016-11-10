load('../RData/km5c.RData')
load('../RData/trTable.RData')

clusterData<-as.data.frame(km5c$cluster)
 names(clusterData)<-c("cluster")


trip<-data.frame()


L<-nrow(trTable)-1

for (i in 1:L) {
  if(trTable[i,2]==trTable[i+1,2]){
    trip[i,1]<-T
    trip[i,2]<-clusterData[i,1]
    trip[i,3]<-clusterData[i+1,1]
  }
  else{
    trip[i,1]<-F
    trip[i,2]<-0
    trip[i,3]<-0
    print(i)
  }

}

L<-L+1
trip[L,1]<-F
trip[L,2]<-0
trip[L,3]<-0
names(trip)<-c('isTrip','from','to')
save(trip, file='../RData/trip.RData')
