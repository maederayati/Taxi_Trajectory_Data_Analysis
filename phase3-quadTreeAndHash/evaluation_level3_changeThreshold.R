
load('RData/test.RData')
load('RData/trTable2.RData')
load('RData/destinations.RData')

library(geosphere)
library(ggplot2)


# 
# realDestination<-list()
# L<-1921
# for(i in 1:L){
#     realDestination[[i]]<-vector()
#     s1<-subset(trTable2, trTable2$obs==test[i])
#     L1<-nrow(s1)
#     s2<-subset(trTable2, (trTable2$obs==test[i]&trTable2$seg==L1))
#     realDestination[[i]]<-c(s2$lat,s2$long)
#     
# }
# save(realDestination,file="RData/realDestination.RData")
load("RData/realDestination.RData")

result_rawDest<-vector()

threshold=0.01

while(threshold<0.51){
    print(threshold)

for(prefixLength in 10:10){

d<-paste0("RData/levelThree_similarSets",as.character(prefixLength))
d<-paste0(d,"_t")
d<-paste0(d,as.character(threshold*100))
d<-paste0(d,"By100")
d<-paste0(d,".RData")





 
load(d)

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
    threshold=threshold+0.01
}
#a<-1:50
a<-seq(0.01,0.5, by=0.01)
result_rawDest_4plot<-cbind(a,result_rawDest)
save(result_rawDest_4plot, file="result_rawDest_4plot.RData")
# 
# 
# result<-as.data.frame(d)
# png("Graphs/error_level3.png")
# print(qplot(result, data=result, geom="histogram"))
# 
# dev.off()
# 
result_rawDest_4plot<-as.data.frame(result_rawDest_4plot)
names(result_rawDest_4plot)<-c("threshold", "errorInKm")

png("Graphs/Error_Vs_threshold.png")

p<-ggplot(data=result_rawDest_4plot, aes(x=prefixLength, y=errorInKm)) +
  geom_line()+
  geom_point()+labs(title="Prefix Length=10   r=1km  Average of predictions  no metadata",x="threshold", y = "Error in KM")
print(p)
dev.off()