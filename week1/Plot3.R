##getiing the dataset
data_full <- read.csv("dataset.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")
head(data_full$Date)
##subset the dataset
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

##converting the format of the date
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

##plotting and save it
with(data,{
      plot(Sub_metering_1~Datetime, type = "l", xlab = "",
           ylab = "Global Active Power(kilowatts)")
      lines(Sub_metering_2~Datetime, col = "Red")
      lines(Sub_metering_3~Datetime, col = "Blue")
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off

