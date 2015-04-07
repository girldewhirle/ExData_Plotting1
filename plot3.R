## load libraries
library("plyr")
library("dplyr")
library("tidyr")
library("lubridate")

## load data from unzipped text file
house_hold_power<-read.delim("household_power_consumption.txt",header=TRUE,sep=";")
## wrap the data
house_hold_power<-tbl_df(house_hold_power)
## convert date columns into date format
house_hold_power$Date<-dmy(house_hold_power$Date)
## subset 1st and 2nd Feb 2007
date_subset<-filter(house_hold_power,Date>=dmy("01/02/2007")&Date<=dmy("02/02/2007"))
## combine date and time into one field
date_subset<-mutate(date_subset,combo_date=as.POSIXct(paste(date_subset$Date, date_subset$Time), format="%Y-%m-%d %H:%M:%S"))
## convert Global Active Power to numeric via character
date_subset$Global_active_power<-as.character(date_subset$Global_active_power)
date_subset$Global_active_power<-as.numeric(date_subset$Global_active_power)
## convert submetering values
date_subset$Sub_metering_1<-as.character(date_subset$Sub_metering_1)
date_subset$Sub_metering_2<-as.character(date_subset$Sub_metering_2)
date_subset$Sub_metering_3<-as.character(date_subset$Sub_metering_3)
date_subset$Sub_metering_1<-as.numeric(date_subset$Sub_metering_1)
date_subset$Sub_metering_2<-as.numeric(date_subset$Sub_metering_2)
date_subset$Sub_metering_3<-as.numeric(date_subset$Sub_metering_3)

## plot 3 sub metering values

## open png
png("plot3.png")

## create plot

with(date_subset,plot(combo_date,Sub_metering_1,type="l",xlab="", ylab="Energy sub metering"))
with(date_subset,lines(combo_date, Sub_metering_2, type="l",xlab="",ylab="",col="red"))
with(date_subset,lines(combo_date, Sub_metering_3, type="l",xlab="",ylab="",col="blue"))
## add legend
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

## close device
dev.off()