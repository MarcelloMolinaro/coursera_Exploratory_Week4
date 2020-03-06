#This code plots emission trends ACROSS Baltimore by Year by motor vehicle sources

## Takes time, Do not run these every time
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

##find all SCC with vehicle in SECTOR description.
motorv <- SCC[grepl("Vehicle", SCC$EI.Sector), ]
#0r...
#motorv <- SCC[grepl("On-Road", SCC$EI.Sector), ]

baltMotorv <- NEI %>%
              filter(NEI$fips == 24510 &
                    SCC %in% motorv$SCC)
#or...
#baltMotorV <- subset(NEI, NEI$fips == 24510 & SCC %in% motorv$SCC)

agBaltMV <- setNames(aggregate(baltMotorv$Emissions,
                              by = list(baltMotorv$year), 
                              FUN = sum),
                     c("Year", "sumEmissions")
            )

library(ggplot2)
qplot(data = agBaltMV,
      x = Year, 
      y= sumEmissions, 
      geom = "line",
      main = "Total Emissions from Moror Vehicle sources in Baltimore by Year")
