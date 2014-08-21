# Plot_3_exploratory_analysis_v1

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

# Plot 3 - three line graph of sub_metering (y) by date-time (x)

# Open the device
png(filename = "plot3.png", width=480, height=480, units="px", res=NA)

# Plot the data! First, create a date/time variable for the x-axis

z <- as.POSIXct(paste(HPC_sel$Date,HPC_sel$Time),format="%Y-%m-%d %H:%M:%S")
plot(z,HPC_sel$Sub_metering_1,pch=26,col="black",xlab="",ylab="Energy sub metering")
lines(z,HPC_sel$Sub_metering_1,col="black")
lines(z,HPC_sel$Sub_metering_2,col="red")
lines(z,HPC_sel$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=(c("black","red","blue"))
       ,lty=c(1,1,1),lwd=c(1,1,1))

# Close the device
dev.off()


