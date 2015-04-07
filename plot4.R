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
date_subset<-mutate(date_subset,datetime=as.POSIXct(paste(date_subset$Date, date_subset$Time), format="%Y-%m-%d %H:%M:%S"))
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

## convert Voltage
date_subset$Voltage<-as.character(date_subset$Voltage)
date_subset$Voltage<-as.numeric(date_subset$Voltage)

## convert Global Reactive Power

date_subset$Global_reactive_power<-as.character(date_subset$Global_reactive_power)
date_subset$Global_reactive_power<-as.numeric(date_subset$Global_reactive_power)

## open png
png("plot4.png")

par(mfrow=c(2,2))

## create plot

with(date_subset, {
  ## plot which is same as plot 2
  plot(date_subset$datetime,date_subset$Global_active_power,type="l",xlab="", ylab="Global Active Power (kilowatts)")
  ## plot based on Voltage (new)
  plot(datetime, Voltage, type="l")
  ## plot which is same as plot 3
  plot(datetime, Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
  lines(datetime, Sub_metering_2, type="l", xlab="", ylab="", col="red")
  lines(datetime, Sub_metering_3, type="l", xlab="", ylab="", col="blue")
  legend("topright", pch="-", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
  ## plot based on reactive power
  plot(datetime,Global_reactive_power, type="l")
})

## close device
dev.off()

