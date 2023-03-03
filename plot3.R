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
dataplot3 <- subset(data,data$Date %in% as.Date(c("2007-02-01", "2007-02-02")))#data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 
datetimeD <-as_datetime(paste0(dataplot3$Date, " " , dataplot3$Time))
dataplot3 <- cbind(datetimeD, dataplot3)
#transform to numeric
dataplot3$Sub_metering_1 <- as.numeric(dataplot3$Sub_metering_1)
dataplot3$Sub_metering_2 <- as.numeric(dataplot3$Sub_metering_2)
dataplot3$Sub_metering_3 <- as.numeric(dataplot3$Sub_metering_3)
#plot metering
plot(dataplot3$datetimeD, dataplot3$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(dataplot3$datetimeD, dataplot3$Sub_metering_2, type="l", col="red")
lines(dataplot3$datetimeD, dataplot3$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

##Plot metering to file
png(filename="plot3.png")
# plotting
plot(dataplot3$datetimeD, dataplot3$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(dataplot3$datetimeD, dataplot3$Sub_metering_2, type="l", col="red")
lines(dataplot3$datetimeD, dataplot3$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()