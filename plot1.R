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
dataplot1 <- subset(data,data$Date %in% as.Date(c("2007-02-01", "2007-02-02")))#data[which(data$Date %in% as.Date(c("2007-02-01", "2007-02-02"))),] 

dataplot1$Global_active_power <- as.numeric(dataplot1$Global_active_power)

#draw histogram
hist(dataplot1$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)",ylab = "Frequency")
##Plot histogram to file
png(filename="plot1.png")
# plotting
hist(dataplot1$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", main = "Global Active Power", col = "red")
dev.off()