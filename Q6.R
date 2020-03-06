##This code plots emission trends BETWEEN Baltimore and Los Angeles County
##by Year by motor vehicle sources

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)

##find all SCC with vehicle in SECTOR description.
motorv <- SCC[grepl("Vehicle", SCC$EI.Sector), ]
#0r...
#motorv <- SCC[grepl("On-Road", SCC$EI.Sector), ]

compareMotorv <- NEI %>%
  filter((NEI$fips == "24510" | NEI$fips == "06037") &
          SCC %in% motorv$SCC
  ) %>% 
    group_by(year, fips) %>% 
      summarise(sumEmissions = sum(Emissions)) %>% arrange(fips)
agcompMV <- as.data.frame(compareMotorv)
agcompMV2 <- mutate(agcompMV, difFrom = ifelse(year == 1999, 0, sumEmissions- lag(sumEmissions)))

#old code
#agcompMV <- setNames(aggregate(compareMotorv$Emissions,
#                               by = list(compareMotorv$year, compareMotorv$fips), 
#                               FUN = sum),
#                     c("Year", "fips", "sumEmissions"))


library(ggplot)
library(gridExtra)

plot1 <- ggplot(data = agcompMV, aes(x = year, y = sumEmissions, color = fips)) +
  geom_line(size = 2, linetype = 1) +
  scale_color_discrete(name = "Area", labels = c("Los Angelos County", "Baltimore City"))+
  labs(title = "Total PM2.5 Vehicle Emissions by Year", y = "PM 2.5 Emissions (tons)")

plot2 <- ggplot(data = agcompMV2, aes(x = year, y = difFrom, color = fips)) +
  geom_line(size = 2, linetype = 1) +
  scale_color_discrete(name = "Area", labels = c("Los Angelos County", "Baltimore City"))+
  labs(title = "Total Change Vehicle Emissions: Year over Year", y = "PM 2.5 Emissions change")
grid.arrange(plot1, plot2, ncol =2)


plot3 <- ggplot(data = agcompMV, aes(x = year, y = sumEmissions)) +
  geom_bar(aes(fill = fips), stat = "identity", position = "dodge") +
  scale_fill_discrete(name = "Area", labels = c("Los Angelos County", "Baltimore City"))+
  labs(title = "Total PM2.5 Vehicle Emissions by Year", y = "PM 2.5 Emissions (tons)")

plot4 <- ggplot(data = agcompMV2, aes(x = year, y = difFrom)) +
  geom_bar(aes(fill = fips), stat = "identity", position = "dodge") +
  scale_fill_discrete(name = "Area", labels = c("Los Angelos County", "Baltimore City"))+
  labs(title = "Total Change Vehicle Emissions: Vs. Last Year", y = "PM 2.5 Emissions change")
grid.arrange(plot3, plot4, ncol =2)
