#Exploratory_analysis_Project_2_Plot_2_v1

#Uses the PM25 Emissions Data

# fips: A five-digit number (represented as a string) indicating the U.S. county
# SCC: The name of the source as indicated by a digit string (see source code classification table)
# Pollutant: A string indicating the pollutant
# Emissions: Amount of PM2.5 emitted, in tons
# type: The type of source (point, non-point, on-road, or non-road)
# year: The year of emissions recorded

getwd()

infile1 <- "./summarySCC_PM25.rds"
infile2 <- "./Source_Classification_Code.rds"

NEI <- readRDS(infile1)   # data frame with all PM25 emissions from '99,'02,'05,'08
SCC <- readRDS(infile2)   # maps SCC digit strings to actual name of PM25 source

# Plot 2 - Total Emissions from Baltimore sources for each year

# Sums the total emissions by year, limiting the data to Baltimore ("24510")
tot_emissions <- aggregate(Emissions ~ year, sum, data = subset(NEI,fips=="24510") )

# Changes the year columns into factors
tot_emissions$year <- as.factor(tot_emissions$year)

png(filename = "plot2.png", width=480, height=480, units="px", res=NA) # opens device

# Simple Horizontal Bar Plot with Added Labels
em_plot <- with(tot_emissions,barplot(Emissions, main="Baltimore Emissions Decrease from 1999 to 2008"
              , cex.main=.9              
              , horiz=F
              , names.arg=year,yaxt='n'
              , xlab="Year"
              , ylab=bquote("Tons of PF"[25] ~ " Emissions" )))

# Adds y axis tick marks with human-friendly points
y_ticks <- as.integer(seq(0,3000,length=4))
axis(2,pos=0, at = y_ticks)

# Puts the actual summation numbers a little bit above the bars on the chart
text(x= em_plot, y= tot_emissions$Emissions+(3/70)*max(tot_emissions$Emissions)
     , labels=formatC(tot_emissions$Emissions,digits=0,big.mark=",",format="d"), xpd=TRUE)

# Draws horizontal lines at the tick marks
abline(h=y_ticks)

dev.off()      # closes device
