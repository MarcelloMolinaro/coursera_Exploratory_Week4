#This code plots total emission trend by year for the whole US

## This first line will likely take a few seconds. Be patient!
#Do not run this every time you need the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#aggregates emmissions by year, names the columns
agAll <- setNames(aggregate(NEI$Emissions, list(NEI$year), FUN = sum), c("Year", "sumEmissions"))


# plots chart to PNG
png(file = "plotQ1.png", width = 480, height = 480)

barplot(agAll$sumEmissions ~ agAll$Year,
        main = "Total PM2.5 Emission from all sources by Year",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions",
        col = "white")

dev.off()