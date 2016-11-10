
load("RData/trTable2.RData")

set.seed(123)
trTable3<-subset(trTable2, trTable2$seg==1)
L<-nrow(trTable3)
s<-sample(1:L,size=0.75*L)

train<-trTable3[s,2]

test<-trTable3[-s,2]


save(train,file="RData/train.RData")
save(test,file="RData/test.RData")


