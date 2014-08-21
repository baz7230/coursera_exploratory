# Plot_4_exploratory_analysis_v1

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

# Plots four graphs on a single device

# Open the device
png(filename = "plot4.png", width=480, height=480, units="px", res=NA)

# Plot the data! First, create a date/time variable for the x-axis
#                Next, plot it by column; 2 colums and 2 rows
z <- as.POSIXct(paste(HPC_sel$Date,HPC_sel$Time),format="%Y-%m-%d %H:%M:%S")
par(mfcol=c(2,2))

# 1: plot global active power (y) by date-time (x)
plot(z,HPC_sel$Global_active_power,pch=26
     ,xlab=""
     ,ylab="Global Active Power")
lines(z,HPC_sel$Global_active_power)

# 2: plot Energy sub metering (y) by date/time (x)
plot(z,HPC_sel$Sub_metering_1,pch=26,col="black",xlab="",ylab="Energy sub metering")
lines(z,HPC_sel$Sub_metering_1,col="black")
lines(z,HPC_sel$Sub_metering_2,col="red")
lines(z,HPC_sel$Sub_metering_3,col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col=(c("black","red","blue"))
       ,lty=c(1,1,1),lwd=c(1,1,1)
       ,bty="n",cex=.9)

# 3: plot Voltage(y) vs. datetime(z)
plot(z,HPC_sel$Voltage,pch=26
     ,xlab="datetime"
     ,ylab="Voltage")
lines(z,HPC_sel$Voltage)

# 4: plot Global_reactive_power(y) vs. datetime
plot(z,HPC_sel$Global_reactive_power,pch=26
     ,xlab="datetime"
     ,ylab="Global_reactive_power")
lines(z,HPC_sel$Global_reactive_power)

# Close the device
dev.off()


