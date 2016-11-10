

library(ggplot2)

load('../RData/trTable.RData')




png('../Graphs/trajectoryGraph.png')
p <- ggplot(trTable, aes(x=lat, y=long, group=obs,colour=obs))+
  #facet_wrap(~obs) +
  geom_line()+
  geom_point()+
  scale_fill_continuous(guide = guide_legend())
  
  print(p)
dev.off()







#p<-plot(trTable$lat,trTable$long,type="l",col=trTable$obs)
# 
# png('test.png')
# f<-qplot(
#   x = trTable$lat,
#   y = trTable$long,
#   data = trTable,
#   color = trTable$obs 
# )
# print(f)
# 
# dev.off()