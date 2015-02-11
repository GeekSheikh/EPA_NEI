#Reference UDFs
source("./udf.R")

#Define function for building the plot png file
plot1 <- function(dframes=NULL){
	packages <- c("dplyr")
	packagechecks <- checkPackages(packages)

#Get list of data elements
	if(is.null(dframes)){
		dframes <- loaddata()
	}

#extract data frames from list
	pmdf <- data.frame(dframes[1])
	summary <- data.frame(dframes[2])

#Begin Analysis
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

}

#Call the Function
plot1()
#Answer, YES, emissions have decreased