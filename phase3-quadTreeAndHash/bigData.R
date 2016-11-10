library(ff)

trainData<- read.csv.ffdf(file="train.csv", header=TRUE, 
                  VERBOSE=TRUE, 
                  first.rows=10000, next.rows=50000,colClasses=NA)


# data_all<-read.csv('train.csv')
# 
#  
#  
#  
#  df<-as.data.frame(data_all)
# 
#  


 options(digits=10)
 trTable<-data.frame()
 L<-nrow(trainData)
 for(i in 1:L){

    oneCell<-trainData[i,9]
     m<- gregexpr("(-)?[0-9]*\\.[0-9]*", oneCell)
     t<-regmatches(oneCell, m)
     j=1
     while(j<=length(t[[1]])){
         L<-nrow(trTable)+1
        trTable[L,1]<- i
        trTable[L,2]<- (j+1)/2
        trTable[L,3]<- t[[1]][j]
        trTable[L,4]<- t[[1]][j+1]

       j=j+2
     }
     print(i)

  }

  #trTable<-as.data.frame(trTable)
  names(trTable)=c('obs', 'seg','lat','long')








save(trTable, file='RData/trTable_bigData2.RData')

