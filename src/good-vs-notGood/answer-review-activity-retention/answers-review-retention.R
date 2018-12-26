library("xtable")
source("../../Functions.R")
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

data = NULL

fileList = c( "chemistry-answers-review-retention.csv", "biology-answers-review-retention.csv")

for(f in fileList) {
  myData = read.csv(file = f, sep = ";", header = TRUE)
 
  dataGoodAnswer = subset(myData, trim(myData$good) == "yes")
  dataNotGoodAnswer = subset(myData, trim(myData$good) == "no")
  
  commLabel = as.character(unique(myData$community))
  dataFrame <- existsDiff(dataGoodAnswer$reviews, dataNotGoodAnswer$reviews, "Good", "Not Good", "Reviews", commLabel)
  
  if(is.null(data)) {
    data = dataFrame
  } else {
    data <- rbind(data, dataFrame) 
  }
  dataFrame <- existsDiff(dataGoodAnswer$retention, dataNotGoodAnswer$retention, "Good", "Not Good", "Retention", commLabel)
  data <- rbind(data, dataFrame) 
}

print(data)
print(xtable(data), type="html", file="answers-review-retention.html")