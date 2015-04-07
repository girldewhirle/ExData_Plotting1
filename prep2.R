## load libraries
library("plyr")
library("dplyr")
library("tidyr")
library("lubridate")

## load data from unzipped text file
house_hold_power<-read.delim("household_power_consumption.txt",header=TRUE,sep=";")
## wrap the data
house_hold_power<-tbl_df(house_hold_power)
## convert date and time columns into character
house_hold_power$Date<-as.character(house_hold_power$Date)
house_hold_power$Time<-as.character(house_hold_power$Time)

## subset 1st and 2nd Feb 2007


