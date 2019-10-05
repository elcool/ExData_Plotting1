#We will only be using data from the dates 2007-02-01 and 2007-02-02. 
#One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
## date format is dd/mm/yyyy

# file starts with date 16/12/2006 , time 17:24:00
# we want  00:00:00 of 01/02/2007  (maybe 1 minute before to make sure)

# just to grab the headers
consumptionHeader <- read.table(file = "household_power_consumption.txt", nrows = 1, header = TRUE, sep = ";")   # it knows header is sep by .
#consumption$Date <- as.Date(consumption$Date, format = "%d/%m/%Y")
#consumption$Time <- strptime(consumption$Time, format = "%H:%M:%S")


# if each row is one minute, how many rows do we skip?
# assuming we have all minutes
consumptionRow1Time <- strptime("16/12/2006 17:24:00", format = "%d/%m/%Y %H:%M:%S")
difftimeMins <- difftime(strptime("01/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S") , consumptionRow1Time , units = "mins")
diffMins <- as.numeric(difftimeMins)

## need data from 01/02/2007 to 02/02/2007 , all 48 hours
rowsWanted <- 48 * 60   #  48 hours in minutes

# read and prepare
consumption <- read.table(file = "household_power_consumption.txt", skip = diffMins, nrows = rowsWanted, header = TRUE, sep = ";")   # it knows header is sep by .
colnames(consumption) <- colnames(consumptionHeader)
consumption$DateTime <- paste(consumption$Date,consumption$Time)
consumption$DateTime <- as.POSIXct(strptime(consumption$DateTime, format = "%d/%m/%Y %H:%M:%S"))


### start plot 2
plot(consumption$Global_active_power ~ consumption$DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png")
dev.off()



