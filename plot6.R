# plot 6
# Compare emissions from motor vehicle sources in Baltimore City with
# emissions from motor vehicle sources in Los Angeles County, California
# ( fips == "06037" ). Which City has seen greater changes over time in
# motor vehicle emissions?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

cities <- subset(NEI, fips %in% c("24510", "06037"))
vehicles <- grepl("[Vv]ehicle",SCC$SCC.Level.Two)
vehicles_scc <- SCC[vehicles,]$SCC
cities_vehicles <- cities[cities$SCC %in% vehicles_scc,]
emissions <- aggregate(x=cities_vehicles$Emissions,
                       by=list(fips=cities_vehicles$fips,
                               year=cities_vehicles$year),
                       FUN=sum)

la <- emissions[emissions$fips=="06037",]
la$City <- "Los Angeles, CA"
la_1999 <- la[la$year==1999,]$x
la$diff <- la$x - la_1999
la$pchng <- 100 * la$diff / la_1999

bal <- emissions[emissions$fips=="24510",]
bal$City <- "Baltimore City, MD"
bal_1999 <- bal[bal$year==1999,]$x
bal$diff <- bal$x - bal_1999
bal$pchng <- 100 * bal$diff / bal_1999

dat <- rbind(la, bal)

library(ggplot2)
p1 <- ggplot(dat, aes(y=x, x=year, group=City, color=City))
p1 <- p1 + geom_point(size=3) + geom_line() +
    xlab("Year") + ylab("Total Emissions (tons)") +
    ggtitle("Yearly Emissions") +
    theme_bw() + theme(legend.position="none")
p2 <- ggplot(dat, aes(y=diff, x=year, group=City, color=City))
p2 <- p2 + geom_point(size=3) + geom_line() +
    xlab("Year") + ylab("Difference of\nEmissions (tons)") +
    ggtitle("Difference (ref: 1999)") +
    theme_bw() + theme(legend.position="none")
p3 <- ggplot(dat, aes(y=pchng, x=year, group=City, color=City))
p3 <- p3 + geom_point(size=3) + geom_line() +
    xlab("Year") + ylab("Percent change") +
    ylim(-80, 30) +
    ggtitle("Percent Change (ref: 1999)") +
    theme_bw()

g_legend<-function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    legend
}

legend <- g_legend(p3)

library(gridExtra)
grid.arrange(p1,p2,p3 + theme(legend.position="none"), legend,
             main=textGrob(expression("PM"[2.5]*" Emissions by City")),
             ncol=2)


