###############################################################################
###############################################################################
rm(list=ls())
#download this file and unzip it into your R working directory
if(!file.exists("power_consumption.zip")){
	dir.create("Data")
   url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
   download.file(url, destfile="./Data/power_consumption.zip",
              method="curl")
   dateDownloaded <-data()
   unzip("./Data/power_consumption.zip", exdir ="Data")
   list.files("Data")
}


## Getting full dataset
data <- read.table("./Data/household_power_consumption.txt", header = T,
                        sep = ';', na.strings = "?", check.names = F,
                      stringsAsFactors = F, comment.char = "", quote = '\"')
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Subsetting the data
dat <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
#remove full data from memmory
rm(data)

## Converting dates
datetime <- paste(as.Date(dat$Date), dat$Time)
dat$Datetime <- as.POSIXct(datetime)
head(dat)


## Generating Plot 4
plot4 <- function() {
   windows(record=TRUE, width=12, height=7)
   par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
   with(dat, {
     plot(Global_active_power ~ Datetime, type = "l",
     ylab = "Global Active Power", xlab = "")
     plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
     plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
          xlab = "")
     lines(Sub_metering_2 ~ Datetime, col = 'Red')
     lines(Sub_metering_3 ~ Datetime, col = 'Blue')
     legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
             bty = "n",
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power ~ Datetime, type = "l",
          ylab = "Global_rective_power", xlab = "datetime")
   })
   #generate png
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        cat("plot4.png has been saved in", getwd())
}
plot4()

