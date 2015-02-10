pmdf <- readRDS("data/Source_Classification_Code.rds")
summary <- readRDS("data/summarySCC_PM25.rds")


summary.baltimore <- transform(subset(summary, summary$fips == "24510"), type = factor(type))

# Set bg color transparent
par(bg = "transparent")

# Start device
png(file = "plot3.png", width=1200, height=800)

# Draw plot 3
g <- qplot(year, Emissions, 
	data = summary.baltimore, 
	geom = c("point","smooth"), 
	method = "lm", 
	facets = .~type)

g + geom_point() + coord_cartesian(ylim = (c(0,100)))

# Close the device
dev.off()

#Answer, They all have but nonpoint and point have shown the greatest decreases according to this graph. 