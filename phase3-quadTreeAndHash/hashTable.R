load("RData/gridConvert.RData")
hashTable<-list()
L<-100*100
for(i in 1:L){
    hashTable[[i]]<-vector()
}

L<-length(gridConvert)

for(i in 1:L){
   hashTable[[gridConvert[[i]][[2]]]]<-c(hashTable[[gridConvert[[i]][[2]]]], gridConvert[[i]][[1]])
    
}

save(hashTable,file="RData/hashTable.RData")