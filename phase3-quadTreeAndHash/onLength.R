load("RData/test.RData")
load("RData/trTable2.RData")

l<-vector()
for(i in 1:length(test)){
    s<-subset(trTable2,trTable2$obs==test[i])
    m<-max(s$seg)
    l<-c(l,m)
    print(i)
    
}