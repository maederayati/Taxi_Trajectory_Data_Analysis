load("RData/trTable.RData")
load("RData/destinations.RData")
library(geosphere)

# A_calls<-subset(trTable, trTable$call_type=="A")
# start1<-subset(A_calls, A_calls$seg==1)
# #g<-plot(start1$lat,start1$long)
# 
# B_calls<-subset(trTable, trTable$call_type=="B")
# start2<-subset(B_calls, B_calls$seg==1)
# #g2<-plot(start2$lat,start2$long)
# 
# C_calls<-subset(trTable, trTable$call_type=="C")
# start3<-subset(C_calls, C_calls$seg==1)
# g3<-plot(start3$lat,start3$long)


s<-subset(trTable, (trTable$long<40.8 |trTable$lat>-8.4|trTable$long>41.6))
#s<-subset(s, s$lat>-8.4)
#s<-subset(s, s$long>41.6)


#s<-subset(trTable, (trTable$long>40.8 & trTable$lat<8.4 & trTable$long<41.6))
#s<-subset(s, s$lat>-8.4)

plot(s$lat,s$long)

df<-data.frame()

# 
 df[1,1]<-min(s$lat)
 df[1,2]<-min(s$long)
# 
 df[2,1]<-min(s$lat)
 df[2,2]<-max(s$long)
# 
 df[3,1]<-max(s$lat)
 df[3,2]<-min(s$long)
# 
 df[4,1]<-max(s$lat)
 df[4,2]<-max(s$long)
# 
# #plot(df[,1],df[,2])
# 
#     
#     
 d1<-distHaversine(c(df[1,1], df[1,2]), c(df[2,1], df[2,2]))
# 
 d2<-distHaversine(c(df[2,1], df[2,2]), c(df[3,1], df[3,2]))
 d3<-distHaversine(c(df[3,1], df[3,2]), c(df[4,1], df[4,2]))
 d4<-distHaversine(c(df[1,1], df[1,2]), c(df[4,1], df[4,2]))
 d<-c(d1,d2,d3,d4)

removeList<-unique(s$obs)
save(removeList, file='RData/removeList.RData')
f<-which(trTable$obs %in% removeList)

trTable2<-trTable[-f,]

save(trTable2,file='RData/trTable2.RData')<-which(trTable$obs %in% removeList)

