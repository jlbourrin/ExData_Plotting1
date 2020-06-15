# Upload data from the internet, save it in dedicated folder "Data", and unzip it
if (!file.exists("Data")){
      dir.create("Data")}
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "Data/power_consumption.zip", method = "curl")
unzip("Data/power_consumption.zip", exdir = "Data")

# Read data
data <- read.table("Data/household_power_consumption.txt", sep =";", na.strings = "?", header = TRUE)

# Convert Date into date format and keep only records for 2007-02-01 and 2007-02-02
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# Create new column "Obs" (for observation's Date and Time), converted into date/time format
data$Obs <- paste(data$Date, data$Time, sep = " ")
data$Obs <- strptime(data$Obs, format = "%Y-%m-%d %H:%M:%S")

# Create plot 3
with(data, {
      plot(Obs,Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
      points(Obs,Sub_metering_2, type = "l", col = "red")
      points(Obs,Sub_metering_3, type = "l", col = "blue")
      legend("topright", lty = 1, col = c("black","red","blue"), 
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

dev.copy(png, file = "plot3.png",width= 480, height= 480)
dev.off()
