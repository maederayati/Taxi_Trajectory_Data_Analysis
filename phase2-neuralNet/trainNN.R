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
                 train, hidden = 20,
                 rep=1, err.fct="sse",
                 linear.output=TRUE, act.fct = "logistic")
png("NN-noHidden-logistic.png")
plot(net)

dev.off()
m<-as.matrix(test[,1:10])
net.results<-compute(net, covariate=m)
print(net.results$net.result)

save(net.results, file='result_noHidden.RData')