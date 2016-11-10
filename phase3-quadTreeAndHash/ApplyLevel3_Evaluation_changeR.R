


threshold<-0.2
r=0
while(r<1){
    print(r)
    
for(prefixLength in 10:10){

e<-paste0("RData/dsim",as.character(prefixLength))
e<-paste0(e,"_r")
e<-paste0(e,as.character(r/1000))
e<-paste0(e,"KM")
e<-paste0(e,".RData")

d<-paste0("RData/levelTwo_similarSets",as.character(prefixLength))
d<-paste0(d,"_r")
d<-paste0(d,as.character(r/1000))
d<-paste0(d,"KM")
d<-paste0(d,".RData")



load(e) 
load(d)


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
d<-paste0(d,"_threshold10")
d<-paste0(d,"_r")
d<-paste0(d,as.character(r/1000))
d<-paste0(d,"KM")
d<-paste0(d,".RData")
 
 
 save(levelThree_similarSets, file=d)


}
r=r+200 

}