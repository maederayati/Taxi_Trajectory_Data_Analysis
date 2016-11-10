
load('../RData/coor.Rdata')


sub1<-subset(trTable, ((lat>-8.67000)&(lat< -8.57000)&(long>41.13000)&(long<41.20000)))
sub2<-subset(trTable, ((lat>-8.64000)&(lat< -8.60000)&(long>41.14000)&(long<41.18000)))
sub3<-subset(trTable, ((lat>-8.64000)&(lat< -8.60300)&(long>41.14000)&(long<41.16700)))
sub4<-subset(trTable, ((lat>-8.67000)&(lat< -8.57000)&(long>41.13000)&(long<41.20000)))

 save(sub1,file='../RData/sub1.RData')
 save(sub2,file='../RData/sub2.RData')
 save(sub3,file='../RData/sub3.RData')
 save(sub4,file='../RData/sub4.RData')