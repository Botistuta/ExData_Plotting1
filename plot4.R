# import data from "household_power_consumption.txt", make sure that the file is in your working directory
hpcData <- read.csv("household_power_consumption.txt", colClasses = c("character", "character", rep("numeric",7)), na.strings = c("?"), sep = ";")
useData <- within(hpcData, date_time <- paste(Date, Time, sep = " "))
hpcData = NULL

# convert date and time
useData$date_time = as.POSIXct(strptime(useData$date_time, format = "%d/%m/%Y %H:%M:%S"))

# create subset of the data
useSubSetData = subset(useData, date_time >= as.POSIXct("2007-02-01") & date_time < as.POSIXct("2007-02-03"))
useData = NULL

# create "plot4.png"
png(filename="plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
plot(useSubSetData$date_time, useSubSetData$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l", xlab = "")
plot(useSubSetData$date_time, useSubSetData$Voltage, ylab = "Voltage", type = "l",xlab = "datetime")
plot(useSubSetData$date_time, useSubSetData$Sub_metering_1, ylab = "Energy sub metering", type = "l", xlab = "")
plot.xy(xy.coords(useSubSetData$date_time, useSubSetData$Sub_metering_2), type = "l", col = "red")
plot.xy(xy.coords(useSubSetData$date_time, useSubSetData$Sub_metering_3), type = "l", col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"))
plot(useSubSetData$date_time, useSubSetData$Global_reactive_power, ylab = "Global_reactive_power", type = "l", xlab = "datetime")

dev.off()