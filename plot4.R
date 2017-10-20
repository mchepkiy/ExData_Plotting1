filepath <- "./household_power_consumption.txt"
## determine field classes
initial <- read.table(filepath, sep = ";", nrows = 100, skip = 1)
classes <- sapply(initial, class)

## read field names to append for Date = clause
initial <- read.table(filepath, sep = ";", nrows = 1, header = TRUE)
names(classes) <- names(initial)

## read and filter the data
data <- read.table(file = filepath, 
                   col.names = names(initial),
                   sep = ";",
                   header = TRUE,
                   dec = "."
                   )
data <- data[data$Date == '2/1/2007' | data$Date == '2/2/2007',]

## place 2*2 plot grid
par(mfrow=c(2,2))

## plot and format the charts
## 1 - same as plot 2
plot(y = as.numeric(data$Global_active_power)/1000, 
     x = as.POSIXct(paste(data$Date, data$Time), format = "%m/%d/%Y %H:%M:%S"), 
     type = "l", 
     ylab = "Global Active Power", 
     xlab = "")

## 2 
plot(y = as.numeric(data$Voltage), 
     x = as.POSIXct(paste(data$Date, data$Time), format = "%m/%d/%Y %H:%M:%S"), 
     type = "l", 
     ylab = "Voltage", 
     xlab = "datetime")

## 3 same as plot 3
plot(y = as.numeric(data$Sub_metering_1),
     x = as.POSIXct(paste(data$Date, data$Time), format = "%m/%d/%Y %H:%M:%S"), 
     type = "l", 
     ylab = "Energy sub metering", 
     xlab = "",
     yaxt = "n",
     ylim = c(0,30))

axis(side = 2, xaxp=c(10, 20, 30))

lines(y = as.numeric(data$Sub_metering_2), 
      x = as.POSIXct(paste(data$Date, data$Time), format = "%m/%d/%Y %H:%M:%S"), 
      col = "red")

lines(y = as.numeric(data$Sub_metering_3), 
      x = as.POSIXct(paste(data$Date, data$Time), format = "%m/%d/%Y %H:%M:%S"), 
      col = "blue")

legend("topleft", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty = 1, 
       col = c("black",  "red", "blue"),
       cex = 0.5)

## 4
plot(y = as.numeric(data$Global_reactive_power)/1000, 
     x = as.POSIXct(paste(data$Date, data$Time), format = "%m/%d/%Y %H:%M:%S"), 
     type = "l", 
     ylab = "Global_rective_power", 
     xlab = "datetime")

dev.copy(png, filename = "plot4.png", width = 480, height = 480)
dev.off()


