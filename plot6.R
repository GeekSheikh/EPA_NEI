#Reference UDFs
source("./udf.R")

#Define function for building the plot png file
plot6 <- function(dframes=NULL){
	packages <- c("dplyr","ggplot2","sqldf")
	packagechecks <- checkPackages(packages)

	if(is.null(dframes)){
		dframes <- loaddata()
	}

	pmdf <- data.frame(dframes[1])
	summary <- data.frame(dframes[2])

#Begin Analysis
	summary.baltimore.la <- subset(summary, summary$fips %in% c("24510", "06037"))
	summary.baltimore.la <- mutate(summary.baltimore.la, 
		city = ifelse(fips == "24510", "Baltimore", "LA"))

	scc.mobile <- unlist(sqldf('Select "SCC" 
		from pmdf 
		where "SCC.Level.One" = "Mobile Sources" 
		order by "SCC"'))
	summary.mobile <- summary.baltimore.la[summary.baltimore.la$SCC %in% scc.mobile 
		& summary.baltimore.la$type=="ON-ROAD", ]

	mobile.by.year <- aggregate(summary.mobile$Emissions, 
		by = list(summary.mobile$year), 
		FUN = "sum")

	mobile.by.year <- dplyr::rename(mobile.by.year, 
		yr = Group.1, 
		pm25 = x)

	# Set bg color transparent
	par(bg = "transparent")

	# Start device
	png(file = "plot6.png", width=1200, height=800)

	# Draw plot 5
	print({
		qplot(yr, pm25, 
			data = mobile.by.year, 
			geom = c("point","smooth"), 
			method = "lm")

		g <- qplot(year, Emissions, data = summary.baltimore.la, geom = c("point","smooth"), method = "lm", facets = .~city)
		g + geom_point() + coord_cartesian(ylim = (c(0,150)))
		})

	# Close the device
	dev.off()

	#Answer, Clearly LA has diminished emissions much more than Baltimore, 
	#but I suspect it's correlated to the number of cars,
	#so to see which city has minimized the most per car on the road,
	#one would need to take the emissions changes as a 
	#function of the number of cars on the road
}
#Call the Function
plot6()