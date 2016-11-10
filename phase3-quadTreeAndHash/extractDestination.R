load("RData/trTable2.RData")



#extract the trips which have length less than 2
options(digits=10)
t<-vector()
for( i in 1:(nrow(trTable2)-1)){
   if((trTable2$seg[i]==1) &(trTable2$seg[i+1]==1)){
       t<-c(t,trTable2$obs[i])   
   }
print(i)

}

destinations<-data.frame()
trTable3<-subset(trTable2, !(trTable2$obs %in% t))

for(i in unique(trTable3$obs)){
    temp<-subset(trTable3, trTable3$obs==i)
    L<-nrow(temp)
    temp2<-subset(trTable3, (trTable3$obs==i &trTable3$seg==L))
    temp3<-c(temp2$lat,temp2$long,i)
    destinations<-rbind(destinations, temp3)
    print(i)
}




save(destinations, file="RData/destinations.RData")