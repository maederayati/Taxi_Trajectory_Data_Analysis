load('../RData/trTable.RData')
require(ggplot2)
require(ggmap)

df<-trTable[,c(4,5)]
options(digits=10)

png('../Graphs/pointOnMap.png')
myLocation2 <- c(41.13000,-8.64000 , 41.17000,-8.58000)
myLocation <- c(-8.67000, 41.13000, -8.57000, 41.20000)
newLocation<-c(41.1590038,-8.618110948)
proto <- get_map(location='porto', zoom = 14, color = "color", source = "osm")
protoMap <- ggmap(proto, base_layer = ggplot(aes(x = lat, y = long),
                                                 data = df)) +
  stat_density2d(aes(x = lat, y = long, fill = ..level..),
                 bins = 5, geom = "polygon",
                 data = df) +
  scale_fill_gradient(low = "yellow", high = "red")
print(protoMap)
dev.off()