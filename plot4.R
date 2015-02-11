source("./udf.R")

plot4 <- function(dframes=NULL){
	packages <- c("dplyr","ggplot2","sqldf")
	packagechecks <- checkPackages(packages)

	if(is.null(dframes)){
		dframes <- loaddata()
	}

	pmdf <- data.frame(dframes[1])
	summary <- data.frame(dframes[2])

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
	print({
		qplot(yr, pm25, 
			data = coal.by.year, 
			geom = c("point", "smooth"), 
			method = "lm")
		})
	# Close the device
	dev.off()

	#Answer, steadily falling with a minor spike around 2005
}
plot4()