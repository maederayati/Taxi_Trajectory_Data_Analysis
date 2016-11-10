require(neuralnet)
load('obsNumForLessThan5.RData')
load('input.RData')
load('sampleOutput.RData')

names(sampleOutput)<-c('dLat','dLong')
sampleAll<-cbind(sample,sampleOutput)




SampleSize <- floor(0.70 * nrow(sampleAll))

## set the seed to make your partition reproductible
set.seed(123)
train_ind <- sample(seq_len(nrow(sampleAll)), size = SampleSize)

train <- sampleAll[train_ind, ]
test <- sampleAll[-train_ind, ]



#testSample<-sampleAll[1:0,]
#testSample<-sample(sampleAll, 5283, replace = FALSE, prob = NULL)

net <- neuralnet(dLat+dLong~lat1+lat2+lat3+
                   lat4+lat5+long1+long2+long3+
                   long4+long5
                 , 
                 train,hidden=10,
                 rep=3, err.fct="sse",
                 linear.output=TRUE, act.fct = "logistic")

#png("NN-noHidden-logistic.png")
#print(plot(net))
#dev.off()

m<-as.matrix(test[,1:10])
net.results<-compute(net, covariate=m)
#print(net.results$net.result)

#save(net.results, file='result_noHidden.RData')

r<-net.results$net.result
sum<-0
L<-nrow(test)
for(i in 1:L){
  
  sum<-sum+ 6371*sqrt(  (((r[i,2]-test[i,12])*cos((r[i,1]-test[i,11]) /2))^2)+ 
                  ((r[i,1]-test[i,11])^2))
   

  #sum<-sum+((r[i,2]-test[i,12])^2)+((r[i,1]-test[i,11])^2)
  
}

error<-sum/L