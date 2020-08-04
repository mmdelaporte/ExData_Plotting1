library(lubridate)

## Read, subset and clean the data
unzip("exdata_data_household_power_consumption.zip")
dataset_raw <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

dataset_raw$Date <- as.Date(dataset_raw$Date, "%d/%m/%Y")

dataset <- subset(dataset_raw, dataset_raw[, 1] == mdy("02/01/2007") | dataset_raw[, 1] == mdy("02/02/2007"))

dataset$date2 <- paste(dataset$Date, dataset$Time)
dataset$date2 <- as.POSIXct(dataset$date2)

dataset$Global_active_power <- as.numeric(dataset$Global_active_power)
dataset$Sub_metering_1 <- as.numeric(dataset$Sub_metering_1)
dataset$Sub_metering_2 <- as.numeric(dataset$Sub_metering_2)
dataset$Sub_metering_3 <- as.numeric(dataset$Sub_metering_3)
dataset$Voltage <- as.numeric(dataset$Voltage)
dataset$Global_reactive_power <- as.numeric(dataset$Global_reactive_power)

## Plots
png("plot1.png", width = 480, height = 480)
hist(dataset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()