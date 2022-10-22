# The data

library("data.table")
library("ggplot2")
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# Gather the subset of the NEI data which corresponds to vehicles

vehiclesSCC <- SCC[grepl("vehicle", SCC.Level.Two, ignore.case=TRUE), SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Subset the vehicles in NEI data to Baltimore's fip

baltimoreVehiclesNEI <- vehiclesNEI[fips=="24510",]

# The plot

png("plot5.png", width=480, height=480)
ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
    geom_bar(stat="identity", fill ="#D95F02" ,width=0.75) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
dev.off()
