## Plot 1

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

# Creating the histogram (Plot 1)
png("plot1.png", width=480, height=480)

hist(PowerDataTable[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()