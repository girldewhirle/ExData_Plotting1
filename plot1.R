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


## open device - default height and width
png("Plot1.png")
## plot histogram of Global Active Power with labels
hist(date_subset$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)",col="red")
## close device
dev.off()