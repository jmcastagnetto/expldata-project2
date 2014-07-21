# plot 5
# How have emissions from motor vehicle sources changed from
# 1999–2008 in Baltimore City?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips=="24510")
vehicles <- grepl("[Vv]ehicle",SCC$SCC.Level.Two)
vehicles_scc <- SCC[vehicles,]$SCC
baltimore_vehicles <- baltimore[baltimore$SCC %in% vehicles_scc,]
totals_vehicles <- aggregate(x=baltimore_vehicles$Emissions,
                             by=list(year=baltimore_vehicles$year),
                             FUN=sum)
png("plot5.png", width = 600, height = 600)
plot(x ~ year, data=totals_vehicles, type="b",
     xlim=c(1998,2010), xlab="Year",
     ylim=c(0,410), ylab="Total emisions (tons)",
     main=expression("PM"[2.5]*" Vehicle Emissions Baltimore City, MD"))
dev.off()
