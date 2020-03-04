## This first line will likely take a few seconds. Be patient!
#Do not run this every time you need the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

ag <- aggregate(NEI$Emissions, NEI$year, FUN = sum)
barplot(ag$x ~ ag$Group.1)