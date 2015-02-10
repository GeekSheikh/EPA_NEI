pmdf <- readRDS("data/Source_Classification_Code.rds")
summary <- readRDS("data/summarySCC_PM25.rds")

summary.baltimore <- subset(summary, summary$fips == "24510")

scc.mobile <- unlist(sqldf('Select "SCC" from pmdf where "SCC.Level.One" = "Mobile Sources" order by "SCC"'))
summary.mobile <- summary.baltimore[summary.baltimore$SCC %in% scc.mobile & summary.baltimore$type=="ON-ROAD", ]

mobile.by.year <- aggregate(summary.mobile$Emissions, 
	by = list(summary.mobile$year), 
	FUN = "sum")

mobile.by.year <- dplyr::rename(mobile.by.year, 
	yr = Group.1, 
	pm25 = x)


# Set bg color transparent
par(bg = "transparent")

# Start device
png(file = "plot5.png", width=1200, height=800)

# Draw plot 5
qplot(yr, pm25, 
	data = mobile.by.year, 
	geom = c("point","smooth"), 
	method = "lm")

# Close the device
dev.off()

#Answer, They have decreased with the largest decrease from 1999 - 2002