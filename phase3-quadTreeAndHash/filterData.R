load('RData/trTable.RData')
load('RData/removeList.RData')

f<-which(trTable$obs %in% removeList)

trTable2<-trTable[-f,]

save(trTable2,file='RData/trTable2.RData')