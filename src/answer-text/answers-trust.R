library("xtable")
source("../Functions.R")
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

data = NULL

fileList = c("biology-answers-ari-len.csv", "chemistry-answers-ari-len.csv")

for(f in fileList) {
  myData = read.csv(file = f, sep = ";", header = TRUE, dec = ".")
  myData$characters_count = gsub(",", "", myData$characters_count )
  myData$characters_count = as.numeric(myData$characters_count)
  
  dataGoodAnswer = subset(myData, trim(myData$good) == "yes")
  dataNotGoodAnswer = subset(myData, trim(myData$good) == "no")
  
  commLabel = as.character(unique(myData$comm_name))
  dataFrame <- existsDiff(dataGoodAnswer$ari_text, dataNotGoodAnswer$ari_text, "Good", "Not Good", "ARI", commLabel)
  
  


  if(is.null(data)) {
    data = dataFrame
  } else {
    data <- rbind(data, dataFrame) 
  }  
  dataFrame <- existsDiff(dataGoodAnswer$characters_count, dataNotGoodAnswer$characters_count, "Good", "Not Good", "Characters", commLabel)
  
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$complexwords_text, dataNotGoodAnswer$complexwords_text, "Good", "Not Good", "Complex Words", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$sentences_text, dataNotGoodAnswer$sentences_text, "Good", "Not Good", "Sentences", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$words_text, dataNotGoodAnswer$words_text, "Good", "Not Good", "Words", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$syllables_text, dataNotGoodAnswer$syllables_text, "Good", "Not Good", "Syllables", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$coleman_liau_text, dataNotGoodAnswer$coleman_liau_text, "Good", "Not Good", "Coleman Liau Text", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$flesch_kincaid_text, dataNotGoodAnswer$flesch_kincaid_text, "Good", "Not Good", "Flesch Kincaid Text", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$flesch_reading_text, dataNotGoodAnswer$flesch_reading_text, "Good", "Not Good", "Flesch Reading Text", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$gunning_fog_text, dataNotGoodAnswer$gunning_fog_text, "Good", "Not Good", "Gunning Fog Text", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$smog_index_text, dataNotGoodAnswer$smog_index_text, "Good", "Not Good", "Smog Index Text", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$smog_text, dataNotGoodAnswer$smog_text, "Good", "Not Good", "Smog Text", commLabel)
  data <- rbind(data, dataFrame)
  dataFrame <- existsDiff(dataGoodAnswer$total_links, dataNotGoodAnswer$total_links, "Good", "Not Good", "Links", commLabel)
  data <- rbind(data, dataFrame)
 
  dataFrame <- existsDiff(dataGoodAnswer$doicount, dataNotGoodAnswer$doicount, "Good", "Not Good", "doi.org ref", commLabel)
  data <- rbind(data, dataFrame)
  
  dataFrame <- existsDiff(dataGoodAnswer$wikipediacount, dataNotGoodAnswer$wikipediacount, "Good", "Not Good", "Wikipedia ref", commLabel)
  data <- rbind(data, dataFrame)

  dataFrame <- existsDiff(dataGoodAnswer$selfreferencecount, dataNotGoodAnswer$selfreferencecount, "Good", "Not Good", "Community self-ref", commLabel)
  data <- rbind(data, dataFrame)  
  
  dataFrame <- existsDiff(dataGoodAnswer$naturecount, dataNotGoodAnswer$naturecount, "Good", "Not Good", "Nature ref", commLabel)
  data <- rbind(data, dataFrame)  

  #,
}

print(data)
print(xtable(data), type="html", file="readability-answers.html")
