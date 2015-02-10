pmdf <- readRDS("data/Source_Classification_Code.rds")
summary <- readRDS("data/summarySCC_PM25.rds")


scc.coal <- sqldf('Select "SCC" 
	from pmdf 
	where "Short.Name" like "%Coal%" 
	and "Short.Name" not like "%Charcoal%" 
	order by "SCC"')

scc.coal <- unlist(scc.coal)
summary.coal <- summary[summary$SCC %in% scc.coal, ]

coal.by.year <- aggregate(summary.coal$Emissions, 
	by = list(summary.coal$year), 
	FUN = "sum")

coal.by.year <- dplyr::rename(coal.by.year, 
	yr = Group.1, 
	pm25 = x)

# Set bg color transparent
par(bg = "transparent")

# Start device
png(file = "plot4.png", width=1200, height=800)

# Draw plot 4
qplot(yr, pm25, 
	data = coal.by.year, 
	geom = c("point", "smooth"), 
	method = "lm")
# Close the device
dev.off()

#Answer, steadily falling with a minor spike around 2005