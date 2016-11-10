


threshold<-0.01

while(threshold<0.51){
    
for(prefixLength in 10:10){

c<-paste0("RData/dsim",as.character(prefixLength))
c<-paste0(c,".RData")

z<-paste0("RData/levelTwo_similarSets",as.character(prefixLength))
z<-paste0(z,".RData")


if(prefixLength>1){
    rm(dsim)
    rm(levelTwo_similarSets)
    
}
load(c) 
load(z)


levelThree_similarSets<-list()
for(i in 1:length(dsim)){
    temp<-dsim[[i]]
    if(!is.null(temp)){
        temp2<-vector()
        
        for(j in 1:length(temp)){
            if(temp[j]<threshold){
                temp2<-c(temp2,levelTwo_similarSets[[i]][j])
            }
            
            
        }
        if(length(temp2)==0){
            levelThree_similarSets[[i]]<-NULL
        }
        else{
            levelThree_similarSets[[i]]<-temp2
        }
        
        
        
    }
    else{
        levelThree_similarSets[[i]]<-NULL
    }
    
}
d<-paste0("RData/levelThree_similarSets",as.character(prefixLength))
d<-paste0(d,"_t")
d<-paste0(d,as.character(threshold*100))
d<-paste0(d,"By100")
d<-paste0(d,".RData")
 
 
 save(levelThree_similarSets, file=d)


}
      print(threshold)
threshold=threshold+0.01    

}