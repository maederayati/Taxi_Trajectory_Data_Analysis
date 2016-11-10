library(stats)
load('../RData/coor.Rdata')

load('../RData/sub1.Rdata')
load('../RData/sub2.Rdata')
load('../RData/sub3.Rdata')
load('../RData/sub4.Rdata')


set.seed(10)

trTable[,c(4,5)]
km5c <- kmeans(trTable[,c(4,5)], 5)
km10c <- kmeans(trTable[,c(4,5)], 10)
km15c <- kmeans(trTable[,c(4,5)], 15)

km5s1 <- kmeans(sub1[,c(4,5)], 5)
km10s1 <- kmeans(sub1[,c(4,5)], 10)
km15s1 <- kmeans(sub1[,c(4,5)], 15)


km5s2 <- kmeans(sub2[,c(4,5)], 5)
km10s2 <- kmeans(sub2[,c(4,5)], 10)
km15s2 <- kmeans(sub2[,c(4,5)], 15)


km5s3 <- kmeans(sub3[,c(4,5)], 5)
km10s3 <- kmeans(sub3[,c(4,5)], 10)
km15s3 <- kmeans(sub3[,c(4,5)], 15)


km5s4 <- kmeans(sub4[,c(4,5)], 5)
km10s4 <- kmeans(sub4[,c(4,5)], 10)
km15s4 <- kmeans(sub4[,c(4,5)], 15)

#############Saving################33

save(km5c,file='../RData/km5c.RData')
save(km10c,file='../RData/km10c.RData')
save(km15c,file='../RData/km15c.RData')

save(km5s1,file='../RData/km5s1.RData')
save(km10s1,file='../RData/km10s1.RData')
save(km15s1,file='../RData/km15s1.RData')

save(km5s2,file='../RData/km5s2.RData')
save(km10s2,file='../RData/km10s2.RData')
save(km15s2,file='../RData/km15s2.RData')

save(km5s3,file='../RData/km5s3.RData')
save(km10s3,file='../RData/km10s3.RData')
save(km15s3,file='../RData/km15s3.RData')
