# Reading Data
#data <- read.table("household_power_consumption.txt", sep = ";",header = TRUE)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";",header = TRUE)
unlink(temp)

# Subsetting required data
data$Date <- as.Date(data$Date, "%d/%m/%Y")
weekData<- data[data$Date>=as.Date("2007-02-01")&data$Date<=as.Date("2007-02-02"),]

# Data Type Formatting to remove factors
weekData$Global_active_power<- as.numeric(as.character(weekData$Global_active_power) )
weekData$Global_reactive_power<- as.numeric(as.character(weekData$Global_reactive_power) )
weekData$Voltage<- as.numeric(as.character(weekData$Voltage) )
weekData$Sub_metering_2<- as.numeric(as.character(weekData$Sub_metering_2) )
weekData$Sub_metering_1<- as.numeric(as.character(weekData$Sub_metering_1) )
weekData$Sub_metering_3<- as.numeric(as.character(weekData$Sub_metering_3) )

# Utilizing data to get correct axis ticks
weekData$FullTime <- paste(weekData$Date, weekData$Time, sep = "/")
weekData$FullTime <- strptime(weekData$FullTime, "%Y-%m-%d/%H:%M:%S")
weekData$graphData<- as.numeric(format(weekData$FullTime, "%d"))*24*60 + 
    as.numeric(format(weekData$FullTime, "%H"))*60 + 
    as.numeric(format(weekData$FullTime, "%M"))

# Plotting Data
par(mfrow=c(2,2))

# Plot 01
plot(weekData$graphData, weekData$Global_active_power,  type = "l", xaxt="n", 
     ylab="Global Active Power", xlab = "")
axis(1,at=c(1440,2880,4320), labels = c("Thu", "Fri","Sat"))

# Plot 02
plot(weekData$graphData, weekData$Voltage,  type = "l", xaxt="n", ylab="Voltage", xlab = "datetime")
axis(1,at=c(1440,2880,4320), labels = c("Thu", "Fri","Sat"))

# Plot 03
plot(weekData$graphData, weekData$Sub_metering_1,  type = "l", xaxt="n", 
     ylab="Energy sub metering", xlab = "")
lines(weekData$graphData, weekData$Sub_metering_3, col="blue", type= "l")
lines(weekData$graphData, weekData$Sub_metering_2, col="red", type= "l")
axis(1,at=c(1440,2880,4320), labels = c("Thu", "Fri","Sat"))
legend("topright" , col = c("black", "red", "blue"), bty = "n", cex= 0.6, 
       lty = c(1, 1, 1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 04
plot(weekData$graphData, weekData$Global_reactive_power,  type = "l", xaxt="n",
     ylab = "global_reactive_power", xlab = "datetime")
axis(1,at=c(1440,2880,4320), labels = c("Thu", "Fri","Sat"))

dev.copy(png, 'plot04.png')
dev.off()
