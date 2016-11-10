load('RData/hashTable.RData')
load('RData/test.RData')
load('RData/trTable2.RData')

set.seed(123)
f<-100*100
perm<-sample(1:f,size=f,replace=FALSE)

minLat<-min(trTable2$lat)
maxLat<-max(trTable2$lat)
minLong<-min(trTable2$long)
maxLong<-max(trTable2$long)



testData<-subset(trTable2, trTable2$obs %in% test)
f<-vector()
# for(i in test){
#     
#     temp<-subset(testData, testData$obs==i)
#     m<-max(temp$seg)
#     f<-c(f,m)    
# }

for( prefixLength in 1:50){
print( prefixLength)
    
L<-length(test)


gridConvert<-list()

for(j in 1:L){
    gridConvert[[j]]<-list()
    
}




for( i in 1:L){
    gridConvert[[i]][[1]]<-test[i]
    
    s<-subset(trTable2, (trTable2$obs==test[i]&trTable2$seg<(prefixLength+1)))
    temp<-vector()
    for(j in 1:nrow(s)){
        
        x<-floor((s$lat[j]-minLat)*100/(maxLat-minLat))
        y<-floor((s$long[j]-minLong)*100/(maxLong-minLong))
        index<-(y-1)*100+x
        temp<-c(temp,perm[index])
        
       
    }
    
    gridConvert[[i]][[2]]<-min(temp)
    
    
    
}

levelOne_similarSets<-list()
for(i in 1:L){
    levelOne_similarSets[[i]]<-hashTable[[gridConvert[[i]][[2]]]]
    
    
}

c<-paste0("RData/levelOne_similarSets",as.character(prefixLength))
c<-paste0(c,".RData")

save(levelOne_similarSets, file=c)

}