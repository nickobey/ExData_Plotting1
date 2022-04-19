# Import data and subset days needed
allData <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")
data <- subset(allData, allData$Date=="1/2/2007" | allData$Date=="2/2/2007")

# Create histogram, change color to red, add title and axis labels
hist(as.numeric(data$Global_active_power), col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# Create png file and turn off graphics device
dev.copy(png, "plot1.png", height = 480, width = 480)
dev.off()