# File written by Matt Frei on 12/9/2015. 
# Coursera Exploratory Data Analysis class
# Project 1 - Plot 4

setwd('C:/Users/matt/Dropbox/Documents/Coursera/exploratory data analysis/Project 1/ExData_Plotting1')

######################################## Load Data ########################################

sc <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(sc,'data.zip')
unzip('data.zip')
cols <- c('date','time','global_active_power','global_reactive_power','voltage','global_intensity','sub_metering_1','sub_metering_2','sub_metering_3')
pd <- read.table('household_power_consumption.txt',
                 header=FALSE,
                 sep=';',
                 na.strings='?',
                 skip=66637,
                 nrows=2880,
                 col.names = cols,
                 stringsAsFactors=FALSE)
# I got the skip and nrows parameters using Bash commands:
# grep  -n '1/2/2007' household_power_consumption.txt | head -n 1
# grep  -n '^2/2/2007' household_power_consumption.txt | tail -n 1

pd$dt <- strptime(paste(pd$date,' ',pd$time),format=' %d/%m/%Y%H:%M:%S')

######################################## Begin plot 4 ########################################

png('plot4.png',width=480,height=480)

oldpar <- par
par(mfrow = c(2,2))

#Top-left
plot(pd$dt,pd$global_active_power,
     ylab = 'Global Active Power (kilowatts)',
     xlab='', type='l')

#Top-right
plot(pd$dt,pd$voltage,
     ylab = 'Voltage',
     xlab='datetime', type='l')

#Bottom-left
plot(pd$dt,pd$sub_metering_1,
     ylab = 'Energy sub metering',
     xlab='', type='l')
lines(pd$dt,pd$sub_metering_2,
      col='red')
lines(pd$dt,pd$sub_metering_3,
      col='blue')
legend('topright',
       legend=c('sub_metering_1','sub_metering_2','sub_metering_3'),
       col=c('black','red','blue'),
       lty=c(1,1,1),
       lwd=c(2,2,2))

#Bottom-right
plot(pd$dt,pd$global_reactive_power,
     ylab = 'Global_reactive_power',
     xlab='datetime', type='l')
dev.off()
