#Exploratory_analysis_Project_2_Plot_6_v1

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


# Plot 6 - Compare emissions from motor vehicle sources in Baltimore City with those
#          from Los Angeles County (fips=="06037"). Which city has seen greater
#          changes over time in motor vehicle emissions?

#  I chose to interpret "greater changes over time" as "greater percentage changes" rather
#  than greater absolute tons of pollution, since Baltimore and Los Angeles were so far
#  apart in the actual tonnage. In either case, it is clear that Los Angeles has increased
#  and Baltimore has decreased, but it is a much more dramatic change when viewed as a
#  percentage of the starting measurement. 

# Use Lattice for the cool comparison panels
library(lattice)

# First, limit data to Baltimore and Los Angeles motor vehicle emissions in 1999 and 2008 
tot_emissions <- aggregate(Emissions ~ year+fips, sum
                   , data = subset(NEI,(fips=="24510"|fips=="06037") & grepl("^22010|^22300",NEI$SCC)
                                   & (year=="1999"|year=="2008")))

# Create a new column in the data frame that shows the percentage change. First merge the
# original data with the subset of emissions for the index year of 1999, then add a
# column that divides each actual measurement by the index year measurment.
tot_emissions <- merge(tot_emissions,tot_emissions[tot_emissions$year=="1999",2:3],by.y="fips",by.x="fips")
tot_emissions$pct_chg <- 100*(tot_emissions[,3]/tot_emissions[,4])

# open the device
png(filename = "plot6.png", width=480, height=480, units="px", res=NA)

# Make a line plot from 1999 to 2008, 
xyplot(tot_emissions$pct_chg ~ tot_emissions$year | tot_emissions$fips
       , type = "l"                         # Make a line chart
       # set the strip names
       , strip=strip.custom(factor.levels=c("Los Angeles: increase","Baltimore: decrease"))
       , ylim = c(0,120)                    # Alter the default y limits
       , ylab = "Percent Change from 1999 base"
       , xlab = "Year"
       , abline = list(h=c(20,60,100))      # Add horizontal lines for readability
) 

# close the device
dev.off()
