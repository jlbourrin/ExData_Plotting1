
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

hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png",width= 480, height= 480)
dev.off()


