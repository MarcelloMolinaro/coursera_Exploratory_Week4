#This code plots emission trends IN BALTIMORE by Year by source TYPE

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

balt <- subset(NEI, NEI$fips == 24510)

agBaltType <- setNames(
            aggregate(balt$Emissions, list(balt$year, balt$type), FUN = sum),
            c("Year", "Type", "sumEmissions"))

ggplot(data = agBaltType, aes(x= factor(Year), y = sumEmissions, group = Type)) +
    geom_line(aes(color = agBaltType$Type),
              linetype = 2, 
              size = 2 ) +
    labs(title = "PM2.5 Emissions in Balitmore by Source Type and Year",
         y = "Total PM2.5 Emissions (tons)",
         x = "Year",
         color = "Source Type")

  
ggsave("plotQ3.png", width = 8, height = 5)