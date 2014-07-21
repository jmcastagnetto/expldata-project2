# plot 2
# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland ( fips == "24510" ) from 1999 to 2008? Use the base plotting
# system to make a plot answering this question.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips=="24510")
totals <- aggregate(x=baltimore$Emissions, by=list(year=baltimore$year), FUN=sum)
# alternative
# library(dplyr)
# totals <- NEI %>% filter(fips=="24510") %>% group_by(year)
#            %>% summarise(x=sum(Emissions))
png("plot2.png", width = 600, height = 600)
plot(x ~ year, data=totals, type="b",
     xlim=c(1998,2010), xlab="Year",
     ylim=c(0,3400), ylab="Total emissions (tons)",
     main=expression("PM"[2.5]*" emissions in Baltimore City, MD"))
dev.off()
