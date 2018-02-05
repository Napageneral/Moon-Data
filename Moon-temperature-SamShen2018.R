setwd("~/Desktop/MyDocs/teach/SIOC290-ClimateMath2017/R Code/Ch6")
d19=read.table("tbol_snapshot.pbin4d-19.out-180-0.txt",header=FALSE)
dim(d19)
#[1] 259200      3  #259200 grid points at 0.5 lat-lon resolution
#259200=720*360, starting from (-179.75, -89.75) going north
#then back to south pole then going north 
#until the end (179.75, 89.75)
m19=matrix(d19[,3],nrow=360)
dim(m19)
#[1] 360 720

library(maps)
Lat1=seq(-89.75,by=0.5,len=360)
Lon1=seq(-189.75,by=0.5, len=720)
mapmat=t(m19)
#mapmat=pmin(mapmat,10)
#mapmat= mapmat[,seq(length(mapmat[1,]),1)], no flipping
plot.new()
#png(filename=paste("Moon Surface Temperature Observed by NASA Diviner, Snapshot=", 
#                   19,".png"), width=800, height=400)
int=seq(0,400,length.out=40)
rgb.palette=colorRampPalette(c('skyblue',  'green', 'blue', 'yellow', 'orange', 'pink','red', 
                               'maroon', 'purple', 'black'),interpolate='spline')
filled.contour(Lon1, Lat1, mapmat, color.palette=rgb.palette, levels=int,
               plot.title=title("Moon Surface Temperature Observed by NASA Diviner, Snapshot 19",
                                xlab="Longitude", ylab="Latitude"),
               plot.axes={axis(1); axis(2);grid()},
               key.title=title(main="deg K"))
#dev.off()

#Plot the equator temperature for a snapshot 
#plot.new()
#png(filename=paste("Moon's Equatorial Temperature at Snapshot", 19,".png"), 
#    width=600, height=400)
plot(Lon1,m19[180,],type="l", col="red",lwd=2, 
     xlab="Longitude", ylab="Temperature [deg K]",
     main="Moon's Equatorial Temperature at Snapshot 19")
text(-100,250,"Nighttime",cex=2)
text(80,250,"Daytime",cex=2, col="orange")
#dev.off()

#Plot the noon time meridional temperature for a snapshot 
#plot.new()
#png(filename=paste("Moon's Noon Time Meridional Temperature at Snapshot", 19,".png"), 
#    width=600, height=400)
plot(Lat1,m19[,540],type="l", col="red",lwd=2, 
     xlab="Latitude", ylab="Temperature [deg K]",
     main="Moon's Noon Time Meridional Temperature at Snapshot 19")
#dev.off()

#Compute the bright side average temperature
bt=d19[129601:259200,]
aw=cos(bt[,2]*pi/180)
wbt=bt[,3]*aw
bta=sum(wbt)/sum(aw)
bta
#[1] 302.7653  deg K

#Compute the dark side average temperature
dt=d19[0:12960,]
aw=cos(dt[,2]*pi/180)
wdt=dt[,3]*aw
dta=sum(wdt)/sum(aw)
dta
#[1] 124.7387  deg K


