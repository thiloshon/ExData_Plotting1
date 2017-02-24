#data <- read.table("household_power_consumption.txt", sep = ";",header = TRUE)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";",header = TRUE)
unlink(temp)

data$Global_active_power <- as.numeric(as.character( data$Global_active_power ))
data$Date = as.Date(data$Date, "%d/%m/%Y")
strpData <- data[data$Date>=as.Date("2007-02-01")&data$Date<=as.Date("2007-02-02"),]
hist(strpData[,3], col = "red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

dev.copy(png, 'plot01.png')
dev.off()

