# The data

library("data.table")
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Histogram and scientific notation.

NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalNEI <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

# The plot

png("plot1.png", width=480, height=480)
barplot(totalNEI[, Emissions], names = totalNEI[, year], xlab = "Years", ylab = "Emissions", main = "Emissions over the Years")
dev.off()
