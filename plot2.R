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
####Plot 2
par(mfrow = c(1,1), mar = c(4, 4, 2, 2)) 
plot(SerialTime, G_A_power, xlab = "Dias" , ylab = "Global Active Power (kilowatts)", type = "l")
#mtext(side=3, line=1.75,"Grafica 2 de la primera tarea del curso Exploratory Data Analysis")
dev.copy(png, file = "plot2.png") ## Copy my plot to PNG file
dev.off() 
