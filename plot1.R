# plot 1
# Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? Using the base plotting system, make a plot
# showing the total PM2.5 emission from all sources for each of
# the years 1999, 2002, 2005, and 2008.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
totals <- aggregate(x=NEI$Emissions, by=list(year=NEI$year), FUN=sum)
totals$emissions <- totals$x / 1e6
# alternative
# library(dplyr)
# totals <- NEI %>% group_by(year) %>% summarise(emissions=sum(Emissions)/1e6)
png("plot1.png", width = 600, height = 600)
plot(emissions ~ year, data=totals, type="b",
     xlim=c(1998,2010), xlab="Year",
     ylim=c(0, 8), ylab="Total emisions (millions of tons)",
     main=expression("PM"[2.5]*" Emissions in the United States"))
dev.off()
