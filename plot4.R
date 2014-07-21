# plot 4
# Across the United States, how have emissions from coal
# combustion-related sources changed from 1999–2008?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# straight merge is slow
# dat <- merge(NEI, SCC, by="SCC")
coal_scc <- grepl(pattern = "[cC]oal", SCC$Short.Name)
coal_ids <- SCC[coal_scc,]$SCC
from_coal <- NEI[NEI$SCC %in% coal_ids,]
totals_coal <- aggregate(x=from_coal$Emissions,
                         by=list(year=from_coal$year), FUN=sum)
totals_coal$emissions <- totals_coal$x / 1e5
png("plot4.png", width = 600, height = 600)
plot(emissions ~ year, data=totals_coal, type="b",
     xlim=c(1998,2010), xlab="Year",
     ylim=c(0, 8), ylab=expression("Total Emisions (10"^5*" tons)"),
     main=expression("PM"[2.5]*" emissions from coal in the United States"))
dev.off()
