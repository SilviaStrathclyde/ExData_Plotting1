## Plot 4

setwd("~/Silvia GitHub/Rrepository/datasciencecoursera/Exploratory Data Analysis")
library(data.table)
# (1) Loading data set
PowerDataTable <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# (2) Preventing histogram from printing in scientific notation
PowerDataTable[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# (3) Changing the format of the date
PowerDataTable[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# (4) Setting the dates (2007-02-01 and 2007-02-02)
PowerDataTable <- PowerDataTable[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Creating the two graphs with (Voltage and Global Reactive Power on the y-axis) (Plot 4)

globalActivePower <- as.numeric(PowerDataTable$Global_active_power)
globalReactivePower <- as.numeric(PowerDataTable$Global_reactive_power)
voltage <- as.numeric(PowerDataTable$Voltage)
subMetering1 <- as.numeric(PowerDataTable$Sub_metering_1)
subMetering2 <- as.numeric(PowerDataTable$Sub_metering_2)
subMetering3 <- as.numeric(PowerDataTable$Sub_metering_3)

plot(PowerDataTable[, dateTime], PowerDataTable[,Voltage], type="l", xlab="datetime", ylab="Voltage")

plot(PowerDataTable[, dateTime], PowerDataTable[,Global_reactive_power], type="l", xlab="datetime", ylab="Global reactive power")


## Combining the plots (Plot 2, 3 and 4) and creating plot4.png

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(PowerDataTable[, dateTime], PowerDataTable[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(PowerDataTable[, dateTime],PowerDataTable[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(PowerDataTable[, dateTime], PowerDataTable[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(PowerDataTable[, dateTime], PowerDataTable[, Sub_metering_2], col="red")
lines(PowerDataTable[, dateTime], PowerDataTable[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(PowerDataTable[, dateTime], powerDT[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()