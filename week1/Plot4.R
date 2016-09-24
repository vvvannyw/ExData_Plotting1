##getting the dataset
data_full <- read.csv("dataset.txt", header = T, sep = ";",quote = "\"", na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="")
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

##subseting the data_full dataset
date <- subset(data_full, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

##converting the format of time
datetime <-  paste(as.Date(date$Date), date$Time)
date$Datetime <- as.POSIXct(datetime)

##plotting and save them
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(date,{
      plot(Global_active_power ~ Datetime, type = "l",
           ylab = "Global Active Power (kilowatts)", xlab = "")
      plot(Voltage ~ Datetime, type = "l",
           ylab = "Voltage (volt)", xlab = "")
      plot(Sub_metering_1 ~ Datetime, type = "l",
           ylab = "Global Active Power (kilowatts)", xlab = "")
      lines(Sub_metering_2 ~ Datetime, col = "Red")
      lines(Sub_metering_3 ~ Datetime, col = "Blue")
      legend("topright", col = c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Global_reactive_power ~ Datetime, type = "l",
           ylab = "Global Reactive Power (kilowatts)", xlab = "")
      })
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()

