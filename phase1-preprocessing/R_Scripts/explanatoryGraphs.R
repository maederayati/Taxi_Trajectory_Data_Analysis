library(ggplot2)
library(hexbin)
library(RColorBrewer)


load('../RData/trTable.Rdata')
load('../RData/sub1.Rdata')
load('../RData/sub2.Rdata')
load('../RData/sub3.Rdata')
load('../RData/sub4.Rdata')


png("../Graphs/coordinates_All.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=trTable,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=1)
print(p)
dev.off()

png("../Graphs/coordinates_sub1-1.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub1,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=1)
print(p)
dev.off()


png("../Graphs/coordinates_sub1-2.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub1,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=500)
print(p)
dev.off()

png("../Graphs/coordinates_sub1-3.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub1,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=1000)
print(p)
dev.off()

png("../Graphs/coordinates_sub1-4.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub1,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=5000)
print(p)
dev.off()

png("../Graphs/coordinates_sub2-1.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub2,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=1)
print(p)
dev.off()

png("../Graphs/coordinates_sub2-2.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub2,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=500)
print(p)
dev.off()

png("../Graphs/coordinates_sub2-3.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub2,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=1000)
print(p)
dev.off()

png("../Graphs/coordinates_sub3-1.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub3,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=1)
print(p)
dev.off()

png("../Graphs/coordinates_sub3-2.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub3,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=120)
print(p)
dev.off()

png("../Graphs/coordinates_sub3-3.png")
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
p<-hexbinplot(long~lat, data=sub3,xlab='Latitude',ylab='Longitude' ,colramp=rf, mincnt=500)
print(p)
dev.off()
