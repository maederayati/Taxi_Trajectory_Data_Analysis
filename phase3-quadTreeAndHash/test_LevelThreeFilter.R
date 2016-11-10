
load("RData/test.RData")
load("RData/train.RData")
load('RData/trTable2.RData')

minLat<-min(trTable2$lat)
maxLat<-max(trTable2$lat)
minLong<-min(trTable2$long)
maxLong<-max(trTable2$long)

gridSet <-function(d){
    s<-subset(trTable2, trTable2$obs==d)
    temp<-vector()
    for(j in 1:nrow(s)){

        x<-floor((s$lat[j]-minLat)*100/(maxLat-minLat))
        y<-floor((s$long[j]-minLong)*100/(maxLong-minLong))
        index<-(y-1)*100+x
        temp<-c(temp,index)
    }
    temp

}


##########

LenLongStr <- function(A, B) {
    
   if(length(A)==0||length(B)==0){
       0
   }
    else{
    
    num <- matrix(0,length(A),length(B) )		
    maxlen <- 0
    #if(!length(A)&!length(B)){
    for (i in 1:length(A)){
        
        for (j in 1:length(B)){
            
            if (A[i] == B[j]) {
                if ((i==1) || (j==1)) { 
                    num[i,j] <- 1
                } 
                else {
                    num[i,j] <- 1+num[i-1,j-1]
                }
                if (num[i,j] > maxlen) {
                    maxlen <- num[i,j]
                }
            }
        }
    }
    #}
    
    maxlen	
    }
}




###########


MaxM<-function(A,B){
    if(length(A)==0 |length(B)==0|is.na(B)){
        0
    }
    else if(A[1]==B[1]){
        1+MaxM(A[-1],B[-1])
    }
    else{
        temp1<-MaxM(A[-1],B)
        print('after temp1')
        temp2<-MaxM(A,B[-1])
        print('after temp2')
        max(temp1,temp2)
    }

}


qi<-list()
for(i in 1:7733){
    if(i %in% test | i %in% train)
        qi[[i]]<-gridSet(i)
    else
        qi[[i]]<-vector()
    print(i)
}



for(prefixLength in 1:50){

c<-paste0("RData/levelTwo_similarSets",as.character(prefixLength))
c<-paste0(c,".RData")


if(prefixLength>1){
    rm(levelTwo_similarSets)
    
}
load(c)    
    
    
 dsim<-list()

for(i in 1:length(test)){

    dsim[[i]]<-vector()
    L<-length(levelTwo_similarSets[[i]])
    A<-qi[[test[i]]]
    if(length(A)> prefixLength){
        A<-A[1:prefixLength]
    }
    if(L>0){
    

        for(j in 1:L){
            B<-qi[[levelTwo_similarSets[[i]][j]]]
            u<-LenLongStr(A,B)
            v<-(1-u/length(A))
            dsim[[i]]<-c(dsim[[i]],v)
            
            
        }
    }
    else{
        dsim[[i]]<-NULL
    }
    

}
 
d<-paste0("RData/dsim",as.character(prefixLength))
d<-paste0(d,".RData")
 
 
 save(dsim, file=d)
  print(prefixLength)

}