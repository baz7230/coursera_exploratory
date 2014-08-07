# Plot_2_exploratory_analysis_v1

#Uses the Household Power Consumption table

infile <- "./household_power_consumption.txt"

HPC_data <- read.table(infile,header=TRUE,sep=";"
                       ,stringsAsFactors=FALSE
                       ,check.names=TRUE,na.strings="?")

library(chron)
HPC_data[,1] <- as.Date(strptime(HPC_data[,1],"%d/%m/%Y"))
HPC_data[,2] <- chron(times=HPC_data[,2])
HPC_sel <- HPC_data[HPC_data$Date == as.Date("2007-02-01")
                  | HPC_data$Date == as.Date("2007-02-02"),]

# Plot 2 - line graph of global active power (y) by date-time (x)

# Open the device
png(filename = "plot2.png", width=480, height=480, units="px", res=NA)

# Plot the data! First, create a date/time variable for the x-axis

z <- as.POSIXct(paste(HPC_sel$Date,HPC_sel$Time),format="%Y-%m-%d %H:%M:%S")
plot(z,HPC_sel$Global_active_power,pch=26
     ,xlab=""
     ,ylab="Global Active Power (kilowatts)")
lines(z,HPC_sel$Global_active_power)

# Close the device
dev.off()


