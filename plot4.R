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
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))
plot(dataset$date2, dataset$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(dataset$date2, dataset$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(dataset$date2, dataset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(dataset$date2, dataset$Sub_metering_2, type = "l", col = "red", xlab = "", ylab = "Energy sub metering")
points(dataset$date2, dataset$Sub_metering_3, type = "l", col = "blue", xlab = "", ylab = "Energy sub metering")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1:1)

plot(dataset$date2, dataset$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
