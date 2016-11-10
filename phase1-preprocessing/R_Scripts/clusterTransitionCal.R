load('../RData/trip.RData')

clusterTransitionTable_included<-data.frame()
clusterTransitionTable_excluded<-data.frame()



clusterTransitionTable<-data.frame()

for(i in 1:5){
  for(j in 1:5){
   
    clusterTransitionTable<-
      rbind.data.frame(clusterTransitionTable,c(i,j,nrow(subset(trip,((trip$isTrip==T)&
                                                       (trip$from==i)&
                                                       (trip$to==j)))) )) 
  }
}

names(clusterTransitionTable)<-c('from','to','frequency')

save(clusterTransitionTable, file='../RData/clusterTransitionTable.RData')
#save(clusterTransitionTable_excluded, file='RData/clusterTransitionTable_excluded.RData')