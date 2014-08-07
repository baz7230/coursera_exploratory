# Plot_1_exploratory_analysis_v1

#Uses the Household Power Consumption table

infile <- "./household_power_consumption.txt"

HPC_data <- read.table(infile,header=TRUE,sep=";"
                       ,stringsAsFactors=FALSE
                       ,check.names=TRUE,na.strings="?")

library(chron)
HPC_data[,1] <- as.Date(strptime(HPC_data[,1],"%d/%m/%Y"))
HPC_data[,2] <- chron(times=HPC_data[,2])
HPC_sel <- HPC_data[ HPC_data$Date == as.Date("2007-02-01")
                     | HPC_data$Date == as.Date("2007-02-02"),]
rm(HPC_data)

# Open the device
png(filename = "plot1.png", width=480, height=480, units="px", res=NA)

# Plot the data!
with(HPC_sel,hist(Global_active_power,main="Global Active Power"
                  ,xlab="Global Active Power (kilowatts)"
                  ,col="red"))

# Close the device
dev.off()
