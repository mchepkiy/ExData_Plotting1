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

## plot and format the chart
plot(y = as.numeric(data$Global_active_power)/1000, 
     x = as.POSIXct(paste(data$Date, data$Time), format = "%m/%d/%Y %H:%M:%S"), 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")
dev.copy(png, filename = "plot2.png", width = 480, height = 480)
dev.off()


