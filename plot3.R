#Clean up workspace
rm(list=ls())
setwd("~/data")

if (!require("plyr")) {
install.packages("plyr")
}
library(plyr)
if (!require("reshape")) {
install.packages(reshape)
}
library(reshape)


#Preparing the data set
see<-read.table("household_power_consumption.txt", header = TRUE, sep=";", quote = "\"", skip= 66636,nrows=2880)
 
a<-as.Date(see$X31.1.2007,"%d/%m/%Y")
b<-as.character(see$X23.59.00)
c<-paste(a,b)
d<-as.POSIXct(strptime(c, "%Y-%m-%d %H:%M:%S"))
SEEmut<-mutate(see,SerialTime = d)
 
newnames<- c("X31.1.2007", "X23.59.00", "G_A_power", "G_R_power", "Voltage", "Global_intensity", "Kitchen", "Laundry_room", "WNA_conditioner","SerialTime")
colnames(SEEmut)<-newnames

SerialTime<-SEEmut$SerialTime
G_A_power<-SEEmut$G_A_power
G_R_power<-SEEmut$G_R_power
Voltage<-SEEmut$Voltage
Global_intensity<-SEEmut$Global_intensity
Kitchen<-SEEmut$Kitchen
Laundry_room<-SEEmut$Laundry_room
WNA_conditioner<-SEEmut$WNA_conditioner



 ########################
####Plot 3
par(mfrow = c(1,1), mar = c(2, 4, 2, 2)) 
SubSetSee<-subset(SEEmut,select=c(SerialTime,Kitchen,Laundry_room,WNA_conditioner))
my_data <- SubSetSee
my_data_long <- melt(my_data, id = "SerialTime")
g <- gl(3,2880)
g <- gl(3,2880,labels= c("sub_metering_1","sub_metering_2","sub_metering_3"))
str(g)
x <- my_data_long[,1]
y <- my_data_long[,3]
plot(x,y,type="n",ylab="Energy sub metering")
points(x[g=="sub_metering_1"],y[g=="sub_metering_1"],col="blue",type="l")
points(x[g=="sub_metering_2"],y[g=="sub_metering_2"],col="red",type="l")
points(x[g=="sub_metering_3"],y[g=="sub_metering_3"],col="black",type="l")
legend("topright", lty =1, col = c("blue", "red","black"), legend = c("sub_metering_1", "sub_metering_2","sub_metering_3"))
dev.copy(png, file = "plot3.png") ## Copy my plot to PNG file
dev.off() 

