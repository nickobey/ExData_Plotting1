# Import data and subset days needed
allData <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")
data <- subset(allData, allData$Date=="1/2/2007" | allData$Date=="2/2/2007")

# Change Date and Time variable formats, format Time as datetime
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
data[1:1440, "Time"] <- format(data[1:1440, "Time"], "2007-02-01 %H:%M:%S")
data[1441:2880, "Time"] <- format(data[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

# Plot Time as line graph, remove x-axis label, correct y-axis label
plot(data$Time, as.numeric(data$Global_active_power), type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

# Create png file and turn off graphics device
dev.copy(png, "plot2.png")
dev.off()