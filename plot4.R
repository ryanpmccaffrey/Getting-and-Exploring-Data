#Set working directory
setwd("/Users/ryanmccaffrey/Documents/Exploratory Data Analysis/")
#Read in data
data <- read.table("household_power_consumption.txt", header=TRUE, sep= ";", colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?")
#Format date style
data$Date<-as.Date(data$Date, "%d/%m/%Y")
#Filter dates
data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]
#Add column for DateTime
data$DateTime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
#Create plot and print to png file
png(filename = "plot4.png")
#Partition plots into quadrants
par(mfcol = c(2,2))
#Plot 1
plot(x = data$DateTime, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
#Plot 2
plot(x = data$DateTime, y = data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
#Add lines and legend to Plot 2
lines(x = data$DateTime, y = data$Sub_metering_1)
lines(x = data$DateTime, y = data$Sub_metering_2, col = "red")
lines(x = data$DateTime, y = data$Sub_metering_3, col = "blue")
legend("topright", bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
#Plot 3
plot(x = data$DateTime, y = data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#Plot 4
plot(x = data$DateTime, y = data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
