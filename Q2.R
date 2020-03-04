#This code plots total emission trend IN BALTIMORE by Year

balt <- subset(NEI, NEI$fips == 24510)

agBaltimore <- setNames(
                  aggregate(balt$Emissions, list(balt$year), FUN = sum),
               c("Year", "sumEmissions"))

barplot(agBaltimore$sumEmissions ~ agBaltimore$Year,
        main = "Total PM2.5 Emission from all sources
            by Year in Baltimore (fps = 24510)",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions",
        col = "purple",
        type = "S")

#or...
plot(agBaltimore$sumEmissions ~ agBaltimore$Year,
              main = "Total PM2.5 Emission from all sources
                   by Year in Baltimore (fps = 24510)",
              xlab = "Year",
              ylab = "Total PM2.5 Emissions",
              col = "purple",
              type = "b", pch = 19)