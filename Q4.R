#This code plots emission trends ACROSS the US by Year by coal combustion-realted sources

## Takes time, Do not run these every time
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

##find all SCC with coal in SECTOR description. This includes all coal combustion sources 
#but excludes coal related sources that do not come from combustion (like mining)
#(includes lignite [brown coal])
sectorsCoal <- SCC[grepl("Coal", SCC$EI.Sector), ]

#subset NEI by coal only sources
UScoal <- subset(NEI, SCC %in% sectorsCoal$SCC)

##...or using dplyr
#UScoal %>%
#  filter(SCC %in% sectorsCoal$SCC)


#aggregate USCoal
agUScoal <- setNames(aggregate(UScoal$Emissions,
                                list(UScoal$year), 
                                FUN = sum),
                    c("Year", "sumEmissions"))

library(ggplot2)
ggplot(agUScoal, aes(x = Year, Y = sumEmissions)) +
      geom_line(aes(y = agUScoal$sumEmissions), size = 2) +
      labs(title = "Coal Combustion related Sources: All of US by Year",
           y = "Total Emissions")

ggsave("plotQ4.png", width = 5, height = 5)

##or...using qplot
#png(file = "plotQ4.png", width = 480, height = 480)
#qplot(x = Year, y = sumEmissions, data = agUScoal, geom = "line", main = "Qplot Title")
#dev.off()