#Reference UDFs
source("./udf.R")

#Define function for building the plot png file
plot2 <- function(dframes=NULL){
	packages <- c("dplyr")
	packagechecks <- checkPackages(packages)

	if(is.null(dframes)){
		dframes <- loaddata()
	}

	pmdf <- data.frame(dframes[1])
	summary <- data.frame(dframes[2])

	summary.baltimore <- subset(summary, summary$fips == "24510")

#Begin Analysis
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
		plot(emissions.baltimore.by.year$yr, emissions.baltimore.by.year$pm25, 
			type = "l", 
			main = "PM25 Emissions in Baltimore By Year", 
			xlab="Year", 
			ylab="PM25 Emissions")
		)

	# Close the device
	dev.off()

	#Answer, YES, overall they have, but not steadily, there was a spike around 2005
}
#Call the Function
plot2()