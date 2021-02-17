#Author: Karl Petersen
#Date:02/16/2021
#Assignment: Exploratory Data Analysis - Course Project One


##Set up the enironment
setwd("~/Coursera - Data Science Course/CourseraDataScience/Section 4 Week 1/BaseGraphs and Assignment")  

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


png("plot1.png", width = 480, height = 480)
#plot1
hist(power$Global_active_power, col = "red", main = "Global Active Power", 
          xlab = "Global Active Power (Kilowatts)")
dev.off()         

