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
dataplot2 <- subset(data,data$Date %in% as.Date(c("2007-02-01", "2007-02-02")))#data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 
datetimeD <-as_datetime(paste0(dataplot2$Date, " " , dataplot2$Time))
dataplot2 <- cbind(datetimeD, dataplot2)
dataplot2$Global_active_power <- as.numeric(dataplot2$Global_active_power)

#plotting
plot(dataplot2$datetimeD, dataplot2$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
##Plot time series to file
png(filename="plot2.png")
# plotting
plot(dataplot2$datetimeD, dataplot2$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()