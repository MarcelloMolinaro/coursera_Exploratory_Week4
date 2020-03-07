#This code plots emission trends ACROSS the US by Year by coal combustion-realted sources

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

##find all SCC with coal in SECTOR description. This includes all coal combustion sources 
#but excludes coal related sources that do not come from combustion (like mining)
#(includes lignite [brown coal])
sectorsCoal <- SCC[grepl("Coal", SCC$EI.Sector), ]

#subset NEI by coal only sources
UScoal <- subset(NEI, SCC %in% sectorsCoal$SCC)

#aggregate USCoal
agUScoal <- setNames(aggregate(UScoal$Emissions,
                                list(UScoal$year), 
                                FUN = sum),
                    c("Year", "sumEmissions"))

library(ggplot2)
#creates plot 
ggplot(agUScoal, aes(x = factor(Year), Y = sumEmissions, group = 1)) +
      geom_line(aes(y = agUScoal$sumEmissions), size = 2) +
      labs(title = "Total PM 2.5 Coal Combustion related Source Emissions: All of US by Year",
           y = "Total PM 2.5 Emissions (tons)",
           x= "Year")
#saves plot
ggsave("plotQ4.png", width = 8, height = 5)