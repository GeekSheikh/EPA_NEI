library(dplyr)

pmdf <- readRDS("data/Source_Classification_Code.rds")
summary <- readRDS("data/summarySCC_PM25.rds")


summary.baltimore <- subset(summary, summary$fips == "24510")


emissions.baltimore.by.year <- aggregate(summary.baltimore$Emissions, 
	by = list(summary.baltimore$year), 
	FUN = "sum")

emissions.baltimore.by.year <- dplyr::rename(emissions.baltimore.by.year, 
	yr = Group.1, 
	pm25 = x)

# Set bg color transparent
par(bg = "transparent")

# Start device
png(file = "plot2.png", width=1200, height=800)

# Draw plot 1
with(summary.baltimore, 
	plot(emissions.by.year$yr, emissions.baltimore.by.year$pm25, 
		type = "l", 
		main = "PM25 Emissions By Year", 
		xlab="Year", 
		ylab="PM25 Emissions")
	)

# Close the device
dev.off()

#Answer, YES, overall they have, but not steadily, there was a spike around 2005