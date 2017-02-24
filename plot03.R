#data <- read.table("household_power_consumption.txt", sep = ";",header = TRUE)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";",header = TRUE)
unlink(temp)

data$Date <- as.Date(data$Date, "%d/%m/%Y")

weekData<- data[data$Date>=as.Date("2007-02-01")&data$Date<=as.Date("2007-02-02"),]

weekData$FullTime <- paste(weekData$Date, weekData$Time, sep = "/")

weekData$FullTime <- strptime(weekData$FullTime, "%Y-%m-%d/%H:%M:%S")

weekData$graphData<- as.numeric(format(weekData$FullTime, "%d"))*24*60 + as.numeric(format(weekData$FullTime, "%H"))*60 + as.numeric(format(weekData$FullTime, "%M"))

weekData$Sub_metering_2<- as.numeric(as.character(weekData$Sub_metering_2) )
weekData$Sub_metering_1<- as.numeric(as.character(weekData$Sub_metering_1) )
weekData$Sub_metering_3<- as.numeric(as.character(weekData$Sub_metering_3) )

plot(weekData$graphData, weekData$Sub_metering_1,  type = "l", xaxt="n", ylab="Energy sub metering", xlab = "")
lines(weekData$graphData, weekData$Sub_metering_3, col="blue", type= "l")
lines(weekData$graphData, weekData$Sub_metering_2, col="red", type= "l")
axis(1,at=c(1440,2880,4320), labels = c("Thu", "Fri","Sat"))

legend("topright" , col = c("black", "red", "blue"), lty = c(1, 1, 1), cex=0.9, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, 'plot03.png')
dev.off()
