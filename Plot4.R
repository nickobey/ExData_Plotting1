# Import data and subset days needed
allData <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")
data <- subset(allData, allData$Date=="1/2/2007" | allData$Date=="2/2/2007")

# Change Date and Time variable formats, format Time as datetime
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
data[1:1440, "Time"] <- format(data[1:1440, "Time"], "2007-02-01 %H:%M:%S")
data[1441:2880, "Time"] <- format(data[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

# Set layout to place four plots
par(mfrow = c(2, 2))

# Plot A - based on Plot 2
plot(data$Time, as.numeric(data$Global_active_power), type = "l", xlab = "", 
     ylab = "Global Active Power")
# Plot B - plot voltage over datetime
plot(data$Time, as.numeric(data$Voltage), type = "l", xlab = "datetime", ylab 
     = "Voltage")
# Plot C - based on Plot 3 with minor changes
plot(data$Time, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
      # Add data lines to plot
      with(data, lines(Time, as.numeric(Sub_metering_1)))
      with(data, lines(Time, as.numeric(Sub_metering_2), col = "red"))
      with(data, lines(Time, as.numeric(Sub_metering_3), col = "blue"))
      # Add legend to plot, no line around legend
legend("topright", lty = 1, bty = "n" ,col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Plot D - plot global reactive power over datetime
plot(data$Time, as.numeric(data$Global_reactive_power), type = "l", xlab = 
           "datetime", ylab = "Global_reactive_power")

# Create png file and turn off graphics device
dev.copy(png, "plot4.png", height = 480, width = 480)
dev.off()
