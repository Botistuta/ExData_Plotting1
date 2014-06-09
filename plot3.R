# import data from "household_power_consumption.txt", make sure that the file is in your working directory
hpcData <- read.csv("household_power_consumption.txt", colClasses = c("character", "character", rep("numeric",7)), na.strings = c("?"), sep = ";")
useData <- within(hpcData, date_time <- paste(Date, Time, sep = " "))
hpcData = NULL

# convert date and time
useData$date_time = as.POSIXct(strptime(useData$date_time, format = "%d/%m/%Y %H:%M:%S"))

# create subset of the data
useSubSetData = subset(useData, date_time >= as.POSIXct("2007-02-01") & date_time < as.POSIXct("2007-02-03"))
useData = NULL

# create "plot3.png"
png(filename="plot3.png", width = 480, height = 480)

with(useSubSetData, plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", ylim = range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))))
with(useSubSetData, lines(date_time, Sub_metering_2, col = "red", ylim = range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))))
with(useSubSetData, lines(date_time, Sub_metering_3, col = "blue", ylim = range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))))

legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black","red","blue"))

dev.off()