# Import data and subset days needed
allData <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")
data <- subset(allData, allData$Date=="1/2/2007" | allData$Date=="2/2/2007")

# Change Date and Time variable formats, format Time as datetime
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
data[1:1440, "Time"] <- format(data[1:1440, "Time"], "2007-02-01 %H:%M:%S")
data[1441:2880, "Time"] <- format(data[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

# Create plot and labels without data
plot(data$Time, data$Sub_metering_1, type = "n", xlab = "", ylab = 
           "Energy sub metering")
# Add data lines to plot
with(data, lines(Time, as.numeric(Sub_metering_1)))
with(data, lines(Time, as.numeric(Sub_metering_2), col = "red"))
with(data, lines(Time, as.numeric(Sub_metering_3), col = "blue"))
# Add ledend to plot
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create png file and turn off graphics device
dev.copy(png, "plot3.png")
dev.off()
