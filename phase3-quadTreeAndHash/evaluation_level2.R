load('RData/levelTwo_similarSets.RData')
load('RData/test.RData')
load('RData/trTable2.RData')
load('RData/destinations.RData')

library(geosphere)
library(ggplot2)

prediction<-list()
for( i in 1:length(test)){
    
    temp<-levelTwo_similarSets[[i]]
    L<-length(temp)
    
     if(L>0){
         lat_sum<-0
         long_sum<-0
         for(j in 1:L){
             s<-subset(destinations, (destinations[,1]==temp[j]))
             lat_sum<-lat_sum+s[1,2]
             long_sum<-long_sum+s[1,3]
             
         }
         prediction[[i]]<-c(lat_sum/L,long_sum/L)
     }
    else{
        prediction[[i]]<-c(NA,NA) 
    }
    
    
    
}

realDestination<-list()
L<-length(test)
for(i in 1:L){
    realDestination[[i]]<-vector()
    s1<-subset(trTable2, trTable2$obs==test[i])
    L1<-nrow(s1)
    s2<-subset(trTable2, (trTable2$obs==test[i]&trTable2$seg==L1))
    #realDestination[[i]]<-vector()
    realDestination[[i]]<-c(s2$lat,s2$long)
    
}

distance<-list()

for(i in 1:L){
    if(!is.null(prediction[[i]])){
        if(!is.na(prediction[[i]][1])&!(is.na(prediction[[i]][2]))){
            distance[[i]]<-distHaversine(prediction[[i]], realDestination[[i]])
        }
    }
    
}

d<-vector()
for( i in 1:length(distance)){
    
    if(!is.null(distance[[i]])){
        d<-c(d,distance[[i]])
    }
}

meanOferror<-mean(d)/1000
result<-as.data.frame(d)
png("Graphs/error_level2.png")
print(qplot(result, data=result, geom="histogram"))

dev.off()

