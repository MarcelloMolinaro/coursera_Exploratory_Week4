##This code plots emission trends BETWEEN Baltimore and Los Angeles County
##by Year by motor vehicle sources

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

##find all SCC with vehicle in SECTOR description.
motorv <- SCC[grepl("Vehicle", SCC$EI.Sector), ]

#filter for data that is Baltimore, LA, and motor vehicle.
#group and total emissions by area and year
compareMotorv <- NEI %>%
  filter((NEI$fips == "24510" | NEI$fips == "06037") &
          SCC %in% motorv$SCC
  ) %>% 
    group_by(year, fips) %>% 
      summarise(sumEmissions = sum(Emissions)) %>% arrange(fips)
groupMV <- as.data.frame(compareMotorv)
#adds column for difference from previous year (first year 1999 set to 0)
agcompChange <- mutate(groupMV, difFrom = ifelse(year == 1999, 0, sumEmissions- lag(sumEmissions)))


library(ggplot2)
library(gridExtra)
#plots total emissions
plot3 <- ggplot(data = groupMV, aes(x = factor(year), y = sumEmissions)) +
  geom_bar(aes(fill = fips), stat = "identity", position = "dodge") +
  scale_fill_discrete(name = "Area", labels = c("Los Angelos County", "Baltimore City"))+
  labs(title = "Total PM2.5 Vehicle Emissions by Year",
       y = "PM 2.5 Emissions (tons)",
       x = "Year")

#plots change in emissions vs previous year
plot4 <- ggplot(data = agcompMV2, aes(x = factor(year), y = difFrom)) +
  geom_bar(aes(fill = fips), stat = "identity", position = "dodge") +
  scale_fill_discrete(name = "Area", labels = c("Los Angelos County", "Baltimore City"))+
  labs(title = "Total Change Vehicle Emissions: Vs. Last Year",
       y = "PM 2.5 Emissions change",
       x = "Year")

png(file = "plotQ6.png", width = 960, height = 480)
grid.arrange(plot3, plot4, ncol =2)
dev.off()
