#Exploratory_analysis_Project_2_Plot_3_v1

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

# Plot 3 - Which types of sources (point,nonpoint,onroad,nonroad) have seen decreases
# in emissions from 1999 to 2008. Which have seen increases?

library(ggplot2)

# Limit the data to the specifics of the question: Baltimore ("24510"), 1999 and 2008
tot_emissions <- aggregate(Emissions ~ year * type, sum
                , data = subset(NEI,fips=="24510" & (year == 1999 | year == 2008) ))

png(filename = "plot3.png", width=480, height=480, units="px", res=NA) # opens device

# Displays a panel for each of the 4 types of pollution sources: point,
# non-point, onroad, nonroad.
qp <- qplot(year, Emissions, data = tot_emissions, geom=("line")
           , facets = . ~ type) # gives 4 plots

# Flips the x tick marks 90 degrees for readablity
qp + theme(axis.text.x = element_text(angle = 90, hjust = 1))

# The 4 panels show non-road trend is DOWN, nonpoint trend is DOWN, on-road trend is
# DOWN, and point trend is UP

dev.off()      # closes device

