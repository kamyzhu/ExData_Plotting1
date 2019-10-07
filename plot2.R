epc <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", 
                colClasses = c(rep("character", times=2),rep("numeric", times=7)))
library(dplyr)
epcsub <- epc %>% filter(Date=="1/2/2007" | Date=="2/2/2007") %>%
  mutate(datetime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))
png(filename="plot2.png")
with(epcsub, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()