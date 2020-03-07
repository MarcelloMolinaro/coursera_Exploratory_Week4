#This code plots emission trends ACROSS Baltimore by Year by motor vehicle sources

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

##find all SCC with vehicle in SECTOR description.
motorv <- SCC[grepl("Vehicle", SCC$EI.Sector), ]

#filters for BAltimore AND motor vehicle data
baltMotorv <- NEI %>%
              filter(NEI$fips == 24510 &
                    SCC %in% motorv$SCC)

#sum of PM2.5 emissions by year
agBaltMV <- setNames(aggregate(baltMotorv$Emissions,
                              by = list(baltMotorv$year), 
                              FUN = sum),
                     c("Year", "sumEmissions"))

library(ggplot2)

qplot(data = agBaltMV,
      x = factor(Year), 
      y= sumEmissions,
      group = 1,
      geom = "line",
      main = "Total PM 2.5 Emissions from Motor Vehicle sources in Baltimore by Year",
      ylab = "Total PM2.5 Emissions (tons)",
      xlab= "Year")

ggsave("plotQ5.png", width = 8, height = 5)
