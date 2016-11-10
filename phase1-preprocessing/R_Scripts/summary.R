 
 dataset<-read.csv('../Porto_taxi_data_training.csv')
 
 df<-as.data.frame(dataset)
 trajectory<-df$POLYLINE
 
 
 
 options(digits=10)
 trTable<-data.frame()
 L<-length(trajectory)
 for(i in 1:L){
    oneCell<-trajectory[i]
    
    #,\\s(-)?[0-9]*\\.[0-9]*\\]
     m<- gregexpr("(-)?[0-9]*\\.[0-9]*", oneCell, perl=TRUE)
     t<-regmatches(oneCell, m)
     t<-as.data.frame(t)
     j=1
     print(i)
     while(j<=nrow(t)){
       trTable<-rbind(trTable, c(i,(j+1)/2,
                           as.numeric(as.character(t[j,1])),
                           as.numeric(as.character(t[(j+1),1]))))
       
       j=j+2
    }
    
  }  
  
  trTable<-as.data.frame(trTable)
  names(trTable)=c('obs', 'seg','lat','long')





s<-as.data.frame(seq(1,nrow(trTable),1))
trTable<-cbind(s,trTable)
names(trTable)=c('id','obs', 'seg','lat','long')




newCols<-data.frame()
for(i in 1:nrow(trTable)){
  newCols[i,1]<-df[trTable[i,2],2] #call_type
  newCols[i,2]<-df[trTable[i,2],3] #origin_call
  newCols[i,3]<-df[trTable[i,2],4] #origin_stand
  newCols[i,4]<-df[trTable[i,2],5] #taxi_ID
  newCols[i,5]<-df[trTable[i,2],6] #time_stamp
  newCols[i,6]<-df[trTable[i,2],7] #day_type
  newCols[i,7]<-df[trTable[i,2],8] #missing_Data
  
  
  print(i)
}


names(newCols)<-c('call_type','origin_call','origin_stand',
                  'taxi_id','time_stamp','day_type','missing_data')
new<-cbind(trTable,newCols)
trTable<-new

save(trTable, file='../RData/trTable.RData')
