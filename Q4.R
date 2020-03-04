#This code plots emission trends ACROSS the US by Year by coal combustion-realted sources

## Takes time, Do not run these every time
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

#merge or find all SCC with coal in title

#subset NEI by cola only sources
UScoal <- subset(NEI, NEI$SCC == )


#aggregate
agBaltType <- setNames(
  aggregate(balt$Emissions, list(balt$year, balt$type), FUN = sum),
  c("Year", "Type", "sumEmissions"))