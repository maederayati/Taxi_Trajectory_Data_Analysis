load('../RData/trip.RData')
load('../RData/trTable.RData')
load('../RData/df.RData')

length<-trTable[,3][!trip$isTrip]
meanOfLength<-range(length)
meanOfLength<-mean(length)
varOfLength<-var(length)
NumberOfTaxiIDsWithTrip<-nrow(as.data.frame(unique(df[trTable[,2],5])))
as.data.frame(unique(df[trTable[,2],5]))
