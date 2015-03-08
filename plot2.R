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
png(filename = "plot2.png")
plot(x = data$DateTime, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
