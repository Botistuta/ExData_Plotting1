# import data from "household_power_consumption.txt", make sure that the file is in your working directory
hpcData <- read.csv("household_power_consumption.txt", colClasses = c("character", "character", rep("numeric",7)), na.strings=c("?"), sep=";")
useData <- within(hpcData, date_time <- paste(Date, Time, sep=" "))

# convert date and time
useData$date_time = as.POSIXct(strptime(useData$date_time, format = "%d/%m/%Y %H:%M:%S"))

# create subset of the data
useSubSetData = subset(useData, date_time >= as.POSIXct("2007-02-01") & date_time < as.POSIXct("2007-02-03"))

# create "plot1.png"
png(filename="plot1.png", width = 480, height = 480)
hist(as.numeric(useSubSetData$Global_active_power), xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()