#Set working directory
setwd("/Users/ryanmccaffrey/Documents/Exploratory Data Analysis/")
#Read in data
data <- read.table("household_power_consumption.txt", header=TRUE, sep= ";", colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?")
#Format date style
data$Date<-as.Date(data$Date, "%d/%m/%Y")
#Filter dates
data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]
#Create plot and print to png file
png(filename = "plot1.png")
with(data, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red"))
dev.off()

