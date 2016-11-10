load('RData/trTable.RData')
load('RData/trip.RData')


flag=0
lessThan5<-vector()
obsNumForLessThan5<-vector()
for (i in 1:nrow(trip)){
  
  if (trip[i,1]==FALSE & trTable[i,3]<5){
    lessThan5<-c(lessThan5,i)
    obsNumForLessThan5<-c(obsNumForLessThan5,trTable[i,2])
  }
}

sampleLat<-data.frame()
sampleLong<-data.frame()

for (i in 1:nrow(trip)){
  
  if (!(trTable[i,2] %in% obsNumber)){
    
    if (trTable[i,3]==5){
      sampleLat<-
        rbind(sampleLat,cbind(trTable[i-4,4],trTable[i-3,4],
        trTable[i-2,4],trTable[i-1,4],trTable[i,4]))
      
      sampleLong<-
        rbind(sampleLong,cbind(trTable[i-4,5],trTable[i-3,5],
                              trTable[i-2,5],trTable[i-1,5],trTable[i,5]))

    } 
  }
  print(i)
}

sample<-cind(sampleLat,sampleLong)
names(sample)<-c('lat1','lat2','lat3','lat4','lat5','long1','long2','long3','long4','long5')
save(sample, file='Input.RData')
save(obsNumForLessThan5,file='obsNumForLessThan5.RData')