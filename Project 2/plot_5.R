#Exploratory_analysis_Project_2_Plot_5_v1

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


# Plot 5 - How have emissions from motor vehicle sources changed from 1999 - 2008
#          in Baltimore City?

# I have used the SCC codes from the "2008 National Emissions Inventory, version 3
# Technical Support Document, September 2013 - DRAFT" Section 4.6.1 which identifies 
# SSC codes starting with 22010 for gasoline vehicles and starting with 22300 for 
# diesel vehicles. This analysis could be extended easily to include tire manufacturers,
# etc. as emissions peripheral to motor vehicle sources.

library(ggplot2)

# First, limit data to all the Baltimore (24510") motor vehicle emissions (22010..., 22300...)
tot_emissions <- aggregate(Emissions ~ year, sum
                 , data = subset(NEI,fips=="24510" & grepl("^22010|^22300",NEI$SCC) ))

png(filename = "plot5.png", width=480, height=480, units="px", res=NA) # opens device

# set up ggplot with dataframe
g <- ggplot(tot_emissions, aes(year, Emissions))
# Add layers

(g + geom_point(alpha=1/3)
   + geom_smooth(method="lm", col="steelblue")
   + labs(x = "Year")
   + labs(y = expression("Tons of PF"[25] ~ " Emissions"))
   + labs(title="Baltimore Motor Vehicle Emissions Decreasing") 
)

dev.off()      # closes device
