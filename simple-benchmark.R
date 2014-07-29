# simple benchmark
# reading all columns
timing <- replicate(5, system.time({
    NEI <- readRDS("summarySCC_PM25.rds")
}))
timing
# mean of elapsed time
mean(timing["elapsed",])
# size in bytes
NEI <- readRDS("summarySCC_PM25.rds")
object.size(NEI)

# reading only the "Emmisions" and "year" columns
timing <- replicate(5, system.time({
    NEI2 <- readRDS("summarySCC_PM25.rds")[,c("Emissions", "year")]
}))
timing
# mean of elapsed time
mean(timing["elapsed",])
# size in bytes
NEI2 <- readRDS("summarySCC_PM25.rds")[,c("Emissions", "year")]
object.size(NEI2)

sessionInfo()
