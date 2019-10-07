fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "power_consumption.zip"

if(!file.exists(filename)) {
  download.file(fileUrl, filename)
}
unzip(filename)

epc <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", 
                colClasses = c(rep("character", times=2),rep("numeric", times=7)))
library(dplyr)
epcsub <- epc %>% filter(Date=="1/2/2007" | Date=="2/2/2007") %>%
  mutate(datetime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))
png(filename="plot4.png")
par(mfrow=c(2,2))
with(epcsub, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(epcsub, plot(datetime, Voltage, type="l"))
with(epcsub, plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(epcsub, lines(datetime, Sub_metering_2, col="red"))
with(epcsub, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red","blue"), lwd=1)
with(epcsub, plot(datetime, Global_reactive_power, type="l"))
dev.off()