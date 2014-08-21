#Exploratory_analysis_Project_2_Plot_4_v1

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

# Plot 4 - Across the US, how have emissions from coal combustion-related sources
#          changed from 1999 - 2008?

# I have chosen to use all aspects of coal combustion-related, including the mining
# of coal, since there is no other reason than combustion to expel coal mining
# pollutants. The analysis could easily be modified to exclude venting of coal bed
# methane, for example, if a more precise specification was required.

library(ggplot2)

png(filename = "plot4.png", width=480, height=480, units="px", res=NA) # opens device

# First, find all the coal-related SCC codes
coal_scc <- SCC[grep("Coal",SCC$Short.Name),c(1,3)]

# Then limit the data to just those SCC codes
#NEIcleaned <- NEI[NEI$SCC %in% coal_scc, ]

NEI_Coal <- merge(NEI,coal_scc)

# Calculate the total emissions by year
tot_emissions <- aggregate(Emissions ~ year, sum, data = NEI_Coal)

# set up ggplot with dataframe
g <- ggplot(tot_emissions, aes(year, Emissions))
# Add layers
(g + geom_point(alpha=1/3)
   + geom_smooth(method="lm", col="steelblue")
   + labs(x = "year")
   + labs(y = expression("Tons of PF"[25] ~ " Emissions"))
   + labs(title="Emissions from Coal Combustion sources")
)
dev.off()      # closes device
