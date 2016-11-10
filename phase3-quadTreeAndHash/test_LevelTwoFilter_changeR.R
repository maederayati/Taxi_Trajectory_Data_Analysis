#load('RData/levelOne_similarSets.RData')
load('RData/test.RData')
load('RData/train.RData')
load('RData/tree.RData')
load('RData/trTable2.RData')
library(geosphere)

maxLat<-max(trTable2$lat)
minLat<-min(trTable2$lat)
maxLong <-max(trTable2$long)
minLong <-min(trTable2$long)

computeBoundries <-function(d){
    L<-nchar(d)
    newMaxLat<-maxLat
    newMinLat<-minLat
    newMaxLong<-maxLong
    newMinLong<-minLong
    i=1
    while(i<=L){
        c<-substring(d,i,i)
        c<-as.numeric(c)
        if(c==1){
            newMinLong<-(newMinLong+newMaxLong)/2
            newMaxLat<-(newMinLat+newMaxLat)/2
        }
        if(c==2){
            newMinLong<-(newMinLong+newMaxLong)/2
            newMinLat<-(newMinLat+newMaxLat)/2
        }
        if(c==3){
            newMaxLong<-(newMinLong+newMaxLong)/2
            newMinLat<-(newMinLat+newMaxLat)/2
        }
        if(c==4){
            newMaxLong<-(newMinLong+newMaxLong)/2
            newMaxLat<-(newMinLat+newMaxLat)/2
        }
        
        

        
        i=i+1
        
    }
    
    r<-c(newMinLat,newMaxLat,newMinLong,newMaxLong)
     r
}




computeIndex<-function(prefix,lat,long){
    b<-computeBoundries(prefix)
    if(lat>=((b[1]+b[2])/2) & long>((b[3]+b[4])/2)){
        index<-c("2")} else if(lat>((b[1]+b[2])/2) & long<=((b[3]+b[4])/2)){
        index<-c("3")} else if(lat<=((b[1]+b[2])/2) & long<((b[3]+b[4])/2)){
        index<-c("4")}else{index<-c("1")}
    
    index<-paste0(prefix,index)
    index
}




distance<-function(d1,d2){
    b1<-computeBoundries(as.character(d1))
    b2<-computeBoundries(as.character(d2))
    b1Lat<-(b1[1]+b1[2])/2
    b1Long<-(b1[3]+b1[4])/2
    b2Lat<-(b2[1]+b2[2])/2
    b2Long<-(b2[3]+b2[4])/2
    distHaversine(c(b1Lat,b1Long), c(b2Lat,b2Long))
    
}


quadTreeIndex<-function(d){
    s<-subset(trTable2, (trTable2$seg==1 &trTable2$obs==d))
    a<-""
    for(h in 1:10){
         a<- computeIndex(a,s$lat,s$long)
    }
    
    a<-as.numeric(a)
    for(j in 1:10){
        if(a %in% tree$cell){
            r<-a
            break
            
        }
        else{
            a<-a%/%10
         
        }
    }
    r
}

qi<-vector()
for(i in 1:7733){
    if(i %in% test | i %in% train)
        qi<-c(qi,quadTreeIndex(i))
    else
        qi<-c(qi,NA)
    print(i)
}

# 
# dist<-matrix(ncol=7733,nrow=7733)
# 
# for(i in 1:7732){
#     for(j in (i+1):7733){
#         if((i %in% test | i %in% train)&(j %in% test | j %in% train))
#             dist[i,j]<-distance(qi[i],qi[j])
#         else 
#             dist[i,j]<-NA
#         
#     }
# print(i)
# }
# 
# for(j in 1:7732){
#     for(i in (j+1):7733){
#         dist[i,j]<-dist[j,i]
#     }
#}
r=0
while(r<1){

for(prefixLength in 10:10){

c<-paste0("RData/levelOne_similarSets",as.character(prefixLength))
c<-paste0(c,".RData")

e<-paste0("RData/levelOne_similarSets",as.character(prefixLength-1))
e<-paste0(e,".RData")


if(prefixLength>1){
    rm(levelTwo_similarSets)
    rm(levelOne_similarSets)
    
}
load(c)


L<-length(test)




levelTwo_similarSets<-list()
for(i in 1:L){
    levelTwo_similarSets[[i]]<-vector()    
    L2<-length(levelOne_similarSets[[i]])
    if(L2>0){
        for( j in 1:L2){
            if(distance(qi[levelOne_similarSets[[i]][j]],qi[test[i]])<=r){
                levelTwo_similarSets[[i]]<-c(levelTwo_similarSets[[i]], levelOne_similarSets[[i]][j])            
            }
           
            
        }
    }
  
    
}

d<-paste0("RData/levelTwo_similarSets",as.character(prefixLength))
d<-paste0(d,".RData")

d<-paste0("RData/levelTwo_similarSets",as.character(prefixLength))
d<-paste0(d,"_r")
d<-paste0(d,as.character(r/1000))
d<-paste0(d,"KM")
d<-paste0(d,".RData")




save(levelTwo_similarSets,file=d)
 print(r) 

}
    r=r+200
}