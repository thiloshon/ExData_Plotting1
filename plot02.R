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

weekData$Global_active_power<- as.numeric(as.character(weekData$Global_active_power) )

plot(weekData$graphData, weekData$Global_active_power,  type = "l", xaxt="n", ylab="Global Active Power (kilowatts)", xlab = "")

axis(1,at=c(1440,2880,4320), labels = c("Thu", "Fri","Sat"))

dev.copy(png, 'plot02.png')
dev.off()

