#This code plots total emission trend IN BALTIMORE by Year

## Takes time, Do not run these every time
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

balt <- subset(NEI, NEI$fips == 24510)

agBaltimore <- setNames(
                  aggregate(balt$Emissions, list(balt$year), FUN = sum),
               c("Year", "sumEmissions"))

# plots chart to PNG
png(file = "plotQ2.png", width = 480, height = 480)

barplot(agBaltimore$sumEmissions ~ agBaltimore$Year,
        main = "Total PM2.5 Emissions from all sources by Year in Baltimore",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions (tons)",
        col = "purple")

dev.off()