
load('RData/test.RData')
load('RData/trTable2.RData')
load('RData/destinations.RData')

library(geosphere)
library(ggplot2)



realDestination<-list()
L<-1921
for(i in 1:L){
    realDestination[[i]]<-vector()
    s1<-subset(trTable2, trTable2$obs==test[i])
    L1<-nrow(s1)
    s2<-subset(trTable2, (trTable2$obs==test[i]&trTable2$seg==L1))
    realDestination[[i]]<-c(s2$lat,s2$long)
    
}
result_rawDest<-vector()

for(prefixLength in 1:50){



z<-paste0("RData/levelThree_similarSets",as.character(prefixLength))
z<-paste0(z,".RData")



 
load(z)

prediction<-list()
for( i in 1:length(levelThree_similarSets)){
    
    temp<-levelThree_similarSets[[i]]
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
         s<-subset(trTable2, (trTable2$obs==test[i]))
         if(nrow(s)<=prefixLength){
                s2<-tail(s,1)
                prediction[[i]]<-c(s2$lat,s2$long)
         }
         else{
              s2<-s[prefixLength,]
            prediction[[i]]<-c(s2$lat,s2$long)
             
         }
 
    }
    
    
    
}



distance<-list()

for(i in 1:length(levelThree_similarSets)){
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

result_rawDest<-c(result_rawDest,meanOferror)
print(prefixLength)

}
a<-1:50
result_rawDest_4plot<-cbind(a,result_rawDest)
save(result_rawDest_4plot, file="RData/result_rawDest_4plot_changePrefixLength.RData")
# 
# 
# result<-as.data.frame(d)
# png("Graphs/error_level3.png")
# print(qplot(result, data=result, geom="histogram"))
# 
# dev.off()
# 
result_rawDest_4plot<-as.data.frame(result_rawDest_4plot)
names(result_rawDest_4plot)<-c("prefixLength", "errorInKm")

png("Graphs/Error_Vs_PrefixLength.png")

p<-ggplot(data=result_rawDest_4plot, aes(x=prefixLength, y=errorInKm)) +
  geom_line()+
  geom_point()+labs(title="dissimilarity threshold=0.15   r=1km  Average of predictions  no metadata",x="prefix length", y = "Error in KM")
print(p)
dev.off()