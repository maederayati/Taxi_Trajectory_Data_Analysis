
load("RData/destinations.RData")
load("RData/trTable.RData")

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



 maxLat<-max(trTable$lat)
 minLat<-min(trTable$lat)
 maxLong <-max(trTable$long)
 minLong <-min(trTable$long)

i=1


list<-data.frame()

L<-nrow(destinations)
 for(i in 1:L){
     list[i,1]<-computeIndex("",destinations[i,1],destinations[i,2])
 }


flag=1
while(flag==1){
    

    maxes<-vector()
    maxes2<-vector()

    for(t in unique(list[,1])){
      
    
            temp1<-which(list[,1] %in% t)
            temp2<-length(which(list[,1] %in% t))
        
            maxes<-c(maxes,temp2)
            maxes2<-c(maxes2,nchar(t))
      
            if(temp2>1 & nchar(t)<10){
                for(j in temp1){
                    list[j,1]<-computeIndex(list[j,1],destinations[j,1],destinations[j,2])       
                }
            }
    }        
 
    sum<-0
    for(e in 1:length(maxes)){
        if(maxes[e]<2 | maxes2[e]>9){
            sum<-sum+1 
        }
    }
    
    if(sum==length(maxes)){
        flag=0
    }
 
}

tempTree<-cbind.data.frame(list[,1],destinations[,1],destinations[,2])
names(tempTree)<-c("cell","lat","long")

tree<-data.frame()
tree<-cbind.data.frame(tempTree, rep(1,nrow(tempTree)))
names(tree)<-c("cell","lat","long","flag")


 df<-data.frame()
 for(i in 1:10){
     for(j in 1:nrow(tree)){
         if(nchar(substring(tree[j,1],1,i))==i){
             df[j,i]<-substring(tree[j,1],1,i)
         }
     }
     print(i)
 }



 a<-list()
 for(i in 1:10){
     a[[i]]<-unique(df[,i])
 }

 all<-vector()
 for(i in 2:10){
     a[[i]]<-na.omit(a[[i]])
     for(j in 1:length(a[[i]])){
         temp<-substring(a[[i]][j],1,(i-1))
             for(k in 1:4){
                 p<-paste0(temp,as.character(k))
                 if ((!(p %in% a[[i]]))){
                     all<-c(all,p)
                 }
             }
     }

 }

  all<-unique(all)
  L<-nrow(tree)
 tree$cell<-as.numeric(as.character(tree$cell))

  for( i in 1:length(all)){

      tree[L+i,1]<-as.numeric((all[i]))
       tree[L+i,2]<-NA
        tree[L+i,3]<-NA
         tree[L+i,4]<-0
  }

  tree[L+length(all)+1,1]<-3
  tree[L+length(all)+1,2]<-NA
  tree[L+length(all)+1,3]<-NA
  tree[L+length(all)+1,4]<-0

 names(tree)<-c("cell","lat","long","flag")

 save(tree,file="RData/tree.RData")