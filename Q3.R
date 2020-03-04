#This code plots emission trends IN BALTIMORE by Year by source TYPE

## Takes time, Do not run these every time
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

balt <- subset(NEI, NEI$fips == 24510)

agBaltType <- setNames(
            aggregate(balt$Emissions, list(balt$year, balt$type), FUN = sum),
            c("Year", "Type", "sumEmissions"))

ggplot(data = agBaltType, aes(x = Year, y = sumEmissions)) +
    geom_line(aes(color = agBaltType$Type), 
              linetype = 2, 
              size = 2 ) +
    labs(title = "PM2.5 Emissions in Balitmore by Source Type and Year", 
         color = "Source Type")

  
ggsave("plotQ3.png", width = 5, height = 5)