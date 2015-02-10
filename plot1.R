library(dplyr)

pmdf <- readRDS("data/Source_Classification_Code.rds")
summary <- readRDS("data/summarySCC_PM25.rds")


emissions.by.year <- aggregate(summary$Emissions, 
	by = list(summary$year), 
	FUN = "sum")

emissions.by.year <- dplyr::rename(emissions.by.year, 
	yr = Group.1, 
	pm25 = x)

# Set bg color transparent
par(bg = "transparent")

# Start device
png(file = "plot1.png", width=1200, height=800)

# Draw plot 1
with(emissions.by.year, 
	plot(emissions.by.year$yr, emissions.by.year$pm25, 
		type = "l", 
		main = "PM25 Emissions By Year", 
		xlab="Year", 
		ylab="PM25 Emissions")
	)

# Close the device
dev.off()

#Answer, YES, emissions have decreased