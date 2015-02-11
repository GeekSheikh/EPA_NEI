checkPackages <- function(packages){
  if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
    install.packages(setdiff(packages, rownames(installed.packages())))
  }
  lapply(packages, library, character.only=T)
}

getData <- function(path){
  if(!file.exists("data")){
    dir.create("data")
  }
  print(c("got to download; path=", paste(path)))
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile = path)
  unzipdata(path)
}

unzipdata <- function(path){
  unzip(path, exdir="./data", overwrite=T)
}

loaddata <- function(){

  sourcefile <- "./data/FNEI.zip"

  if (file.exists(sourcefile)){
    unzipdata(sourcefile)
  }else {
    getData(sourcefile)
    unzipdata(sourcefile)
  }

	pmdf <- readRDS("data/Source_Classification_Code.rds")
	summary <- readRDS("data/summarySCC_PM25.rds")
	tmpdflist <- list(pmdf,summary)
  return(tmpdflist)
}
