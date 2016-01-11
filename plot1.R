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


# Draw plot 1 to the screen
plot1Draw <- function () {
  data <- readData()
  hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "RED")
}


# Save plot 1 to a file
plot1Save <- function () {
  png(file = "plot1.png", width = 480, height = 480) 
  plot1Draw()
  dev.off() 
}
