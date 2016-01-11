# reset the loaded data
init <- function (){
  powerData <<- NULL
  dataSubset <<- NULL
}

# load the data for 1/2/2007 and 2/2/2007
# if data is not in the data directory, download from internet and then unzip
readData <- function() {
  if(!exists("powerData")){
    init()
  }
  
  if (is.null(powerData)){
    
    if (!file.exists("./data/household_power_consumption.txt")) {
      download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data/power_data.zip", method = "curl")
      unzip("./data/power_data.zip", overwrite = T, exdir = "./data")
    }
    
    powerData <<- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
    powerData$dateTime <<- strptime(paste(powerData$Date, powerData$Time), "%d/%m/%Y %H:%M:%S")
    dataSubset <<- powerData[powerData$Date ==  "1/2/2007" | powerData$Date == "2/2/2007", ]
    
  }
  dataSubset
}


# Draw plot 4 to the screen
plot4Draw <- function () {
  data <- readData()
  
  par(mfrow = c(2, 2))

  plot(data$dateTime, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "" )
  
  plot(data$dateTime, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime" )
  
  plot(data$dateTime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "" )
  lines(data$dateTime, data$Sub_metering_2, col="RED")
  lines(data$dateTime, data$Sub_metering_3, col="BLUE")
  legend("topright", lty = 1,  bty = "n", col = c( "black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(data$dateTime, data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime" )
  
}

# Save plot 4 to a file
plot4Save <- function () {
  png(file = "plot4.png", width = 480, height = 480)  
  plot4Draw()
  dev.off() 
}