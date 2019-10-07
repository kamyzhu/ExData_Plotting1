epc <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", 
                colClasses = c(rep("character", times=2),rep("numeric", times=7)))
library(dplyr)
epcsub <- epc %>% filter(Date=="1/2/2007" | Date=="2/2/2007") %>%
  mutate(datetime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))
png(filename="plot1.png")
hist(epcsub$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()