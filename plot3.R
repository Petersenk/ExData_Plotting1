#Author: Karl Petersen
#Date:02/16/2021
#Assignment: Exploratory Data Analysis - Course Project One


##Set up the enironment
setwd("~/Coursera - Data Science/Session 4 - Exploratory Data Analsysis/data")                  #set the working directory

#Download and read the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"  #set the URL
download.file(url, destfile = "powerConsumption.zip")                                           #download the zip file  
unzip("powerConsumption.zip")                                                                   #unzip the file
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", #Read the text file
                    stringsAsFactors = FALSE)

#Tidy up the data and add a date time field:
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")   
power$dateTime <- as.POSIXct(paste(power$Date, power$Time), #create a datetime column
                             format= "%Y-%m-%d %H:%M:%S")
power$dow <- weekdays(as.Date(power$Date), abbreviate = TRUE) #create a day of week column
power <- power[power$Date >= "2007-02-01" & power$Date <= "2007-02-02",]  #filter dates per the assignment
str(power); head(power); tail(power)  #ensure we have the right dates  

png("plot3.png", width = 480, height = 480)
#plot3
plot(x=power$dateTime, y=power$Sub_metering_1 ,
     type = "l", col = "black",
     lty = 1,
     ylab="Energy sub metering",
     xlab = NA)
lines(x=power$dateTime, y=power$Sub_metering_2, type = "l", lty = 1,
      col = "red")    
lines(x=power$dateTime, y=power$Sub_metering_3, type = "l", lty = 1,
      col = "blue")    
# legend("topright", pch = 1, col = c("black","red", "ulue"), 
# legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))    
legend("topright", pch = 95, col = c("black", "red", "blue" ), legend = c("Sub_metering_1", 
                                                                          "Sub_metering_2",
                                                                          "Sub_metering_3"))
dev.off()
