load('RData/train.RData')
load('RData/trTable2.RData')

set.seed(123)
f<-100*100
perm<-sample(1:f,size=f,replace=FALSE)

minLat<-min(trTable2$lat)
maxLat<-max(trTable2$lat)
minLong<-min(trTable2$long)
maxLong<-max(trTable2$long)

k=1
gridConvert<-list()

L<-length(train)
temp2<-vector()




for(j in 1:L){
    gridConvert[[j]]<-list()
    
}

for( i in 1:L){
    gridConvert[[i]][[1]]<-train[i]
    
    s<-subset(trTable2, trTable2$obs==train[i])
    temp<-vector()
    for(j in 1:nrow(s)){
        
        x<-floor((s$lat[j]-minLat)*100/(maxLat-minLat))
        y<-floor((s$long[j]-minLong)*100/(maxLong-minLong))
        index<-(y-1)*100+x
        temp<-c(temp,perm[index])
        
       
    }
    
    gridConvert[[i]][[2]]<-min(temp)
    
    
    
}

save(gridConvert, file="RData/gridConvert.RData")

