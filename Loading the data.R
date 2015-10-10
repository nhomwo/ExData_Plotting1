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


