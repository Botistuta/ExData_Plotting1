# import data from "household_power_consumption.txt", make sure that the file is in your working directory
hpcData <- read.csv("household_power_consumption.txt", colClasses = c("character", "character", rep("numeric",7)), na.strings = c("?"), sep = ";")
useData <- within(hpcData, date_time <- paste(Date, Time, sep = " "))
hpcData = NULL

# convert date and time
useData$date_time = as.POSIXct(strptime(useData$date_time, format = "%d/%m/%Y %H:%M:%S"))

# create subset of the data
useSubSetData = subset(useData, date_time >= as.POSIXct("2007-02-01") & date_time < as.POSIXct("2007-02-03"))
useData = NULL

# create "plot2.png"
png(filename="plot2.png", width = 480, height = 480)
with(useSubSetData, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
