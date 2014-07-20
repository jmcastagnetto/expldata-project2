# plot 3
# Of the four types of sources indicated by the type (point, nonpoint,
# onroad, nonroad) variable, which of these four sources have seen
# decreases in emissions from 1999–2008 for Baltimore City? Which have
# seen increases in emissions from 1999–2008? Use the ggplot2 plotting
# system to make a plot answer this question.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips=="24510")
totals_per_type <- aggregate(x=baltimore$Emissions,
                               by=list(type=baltimore$type,
                                       year=baltimore$year),
                               FUN=sum)
# alternative
# library(dplyr)
# totals <- NEI %>% filter(fips=="24510") %>% group_by(type,year)
#             %>% summarise(x=sum(Emissions))

library(ggplot2)
png("plot3.png", width = 600, height = 600)
p <- ggplot(data = totals_per_type, aes(x = year, y=x , color=type, group=type))
p + ylab("Total Emissions (tons)") + xlab("Year") +
    ggtitle(expression("PM"[2.5]*" Emissions by Type in Baltimore City, MD")) +
    scale_color_discrete(name="Type of source") +
    geom_point(size=3) + geom_line() + theme_bw()
dev.off()
