load('../RData/trTable.RData')
lat<-trTable[,4]
long<-trTable[,5]
df<-cbind(lat,long)

write.csv(df, file = "TaxiLocation.csv",row.names=FALSE)