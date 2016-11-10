load('RData/trTable.RData')
load('RData/trip.RData')
load('obsNumForLessThan5.RData')


sampleOutput<-data.frame()
for(i in 1:nrow(trTable)){
  if (!(trTable[i,2] %in% obsNumber)){
        if(trip[i,1]==FALSE){
          sampleOutput<-rbind(sampleOutput,cbind(trTable[i,4],trTable[i,5]))
          
        }
  }

}

