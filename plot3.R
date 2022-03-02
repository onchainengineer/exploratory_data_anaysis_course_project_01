##Loading Data
req_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format Date to Type Date
req_data$Date <- as.Date(req_data$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
req_data <- subset(req_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove Unnecessary Observation(s)
req_data <- req_data[complete.cases(req_data),]

## Combine Date and Time Column
dateTime <- paste(req_data$Date, req_data$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
req_data <- req_data[ ,!(names(req_data) %in% c("Date","Time"))]

## Add DateTime Column
req_data <- cbind(dateTime, req_data)

## Format DateTime Column
req_data$dateTime <- as.POSIXct(dateTime)

## Creating Plot 3
with(req_data, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Saving File 
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()