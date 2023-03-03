library(lubridate)
#set Data files names
if(!file.exists("./data")){dir.create("./Data")}
zipFile <- "./Data/exdata_data_household_power_consumption.zip"

#check if file is extracted
if (!file.exists("./Data/household_power_consumption.txt")) {
  unzip(zipFile, overwrite = T, exdir = "./Data")
}

##Reading data
data <- read.table("./Data/household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)


##Convert Date column to date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")


##Subset for days 2007-02-01 and 2007-02-02.
dataplot4 <- subset(data,data$Date %in% as.Date(c("2007-02-01", "2007-02-02")))#data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 
datetimeD <-as_datetime(paste0(dataplot4$Date, " " , dataplot4$Time))
dataplot4 <- cbind(datetimeD, dataplot4)

#transform to numeric
dataplot4$Sub_metering_1 <- as.numeric(dataplot4$Sub_metering_1)
dataplot4$Sub_metering_2 <- as.numeric(dataplot4$Sub_metering_2)
dataplot4$Sub_metering_3 <- as.numeric(dataplot4$Sub_metering_3)
dataplot4$Global_active_power <- as.numeric(dataplot4$Global_active_power)
dataplot4$Global_reactive_power <- as.numeric(dataplot4$Global_reactive_power)
dataplot4$Voltage <- as.numeric(dataplot4$Voltage)

par(mfrow = c(2, 2)) 
# First plot
plot(dataplot4$datetimeD, dataplot4$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
# Second plot
plot(dataplot4$datetimeD, dataplot4$Voltage, type="l", xlab="datetime", ylab="Voltage")
# Third plot
plot(dataplot4$datetimeD, dataplot4$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(dataplot4$datetimeD, dataplot4$Sub_metering_2, type="l", col="red")
lines(dataplot4$datetimeD, dataplot4$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
# Fourth plot
plot(dataplot4$datetimeD, dataplot4$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)

##Plot multiple graph to file
png(filename="plot4.png")
# plotting
par(mfrow = c(2, 2)) 
# First plot
plot(dataplot4$datetimeD, dataplot4$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
# Second plot
plot(dataplot4$datetimeD, dataplot4$Voltage, type="l", xlab="datetime", ylab="Voltage")
# Third plot
plot(dataplot4$datetimeD, dataplot4$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(dataplot4$datetimeD, dataplot4$Sub_metering_2, type="l", col="red")
lines(dataplot4$datetimeD, dataplot4$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
# Fourth plot
plot(dataplot4$datetimeD, dataplot4$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)
dev.off()