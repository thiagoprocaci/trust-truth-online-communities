library("xtable")
source("Functions.R")
# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

data = NULL

fileList = c("biology-distance-answer-question.csv", "chemistry-distance-answer-question.csv")

for(f in fileList) {
  myData = read.csv(file = f, sep = ";", header = TRUE, dec = ".")
  myData$characters_count = gsub(",", "", myData$diff_characters_text )
  myData$characters_count = as.numeric(myData$diff_characters_text)
  
  dataGoodAnswer = subset(myData, trim(myData$good) == "yes")
  dataNotGoodAnswer = subset(myData, trim(myData$good) == "no")
  
  commLabel = as.character(unique(myData$comm_name))
  dataFrame <- existsDiff(dataGoodAnswer$levenshtein_text_first_255, dataNotGoodAnswer$levenshtein_text_first_255, "Good", "Not Good", "Levenshtein", commLabel)
  
  if(is.null(data)) {
    data = dataFrame
  } else {
    data <- rbind(data, dataFrame) 
  }  
  dataFrame <- existsDiff(dataGoodAnswer$diff_ari, dataNotGoodAnswer$diff_ari, "Good", "Not Good", "Diff ARI", commLabel)
  data <- rbind(data, dataFrame)
  
  dataFrame <- existsDiff(dataGoodAnswer$diff_characters_text, dataNotGoodAnswer$diff_characters_text, "Good", "Not Good", "Diff Characters", commLabel)
  data <- rbind(data, dataFrame)
 
  dataFrame <- existsDiff(dataGoodAnswer$diff_coleman_liau_text, dataNotGoodAnswer$diff_coleman_liau_text, "Good", "Not Good", "Diff Coleman Liau", commLabel)
  data <- rbind(data, dataFrame)
  
  dataFrame <- existsDiff(dataGoodAnswer$diff_complexwords_text, dataNotGoodAnswer$diff_complexwords_text, "Good", "Not Good", "Diff Complex Words", commLabel)
  data <- rbind(data, dataFrame)
  
  dataFrame <- existsDiff(dataGoodAnswer$diff_flesch_kincaid_text, dataNotGoodAnswer$diff_flesch_kincaid_text, "Good", "Not Good", "Diff Flesch Kincaid Text", commLabel)
  data <- rbind(data, dataFrame)
  
  dataFrame <- existsDiff(dataGoodAnswer$diff_flesch_reading_text, dataNotGoodAnswer$diff_flesch_reading_text, "Good", "Not Good", "Diff Flesch Reading Text", commLabel)
  data <- rbind(data, dataFrame)
  
  dataFrame <- existsDiff(dataGoodAnswer$diff_gunning_fog_text, dataNotGoodAnswer$diff_gunning_fog_text, "Good", "Not Good", "Diff Gunning Fog Text", commLabel)
  data <- rbind(data, dataFrame)
  
  dataFrame <- existsDiff(dataGoodAnswer$diff_sentences_text, dataNotGoodAnswer$diff_sentences_text, "Good", "Not Good", "Diff Sentences", commLabel)
  data <- rbind(data, dataFrame)
  
  dataFrame <- existsDiff(dataGoodAnswer$diff_smog_index_text, dataNotGoodAnswer$diff_smog_index_text, "Good", "Not Good", "Diff Smog Index", commLabel)
  data <- rbind(data, dataFrame)
  
  dataFrame <- existsDiff(dataGoodAnswer$diff_smog_text, dataNotGoodAnswer$diff_smog_text, "Good", "Not Good", "Diff Smog Text", commLabel)
  data <- rbind(data, dataFrame)  

  dataFrame <- existsDiff(dataGoodAnswer$diff_syllables_text, dataNotGoodAnswer$diff_syllables_text, "Good", "Not Good", "Diff Syllables", commLabel)
  data <- rbind(data, dataFrame)  
  
  dataFrame <- existsDiff(dataGoodAnswer$diff_words_text, dataNotGoodAnswer$diff_words_text, "Good", "Not Good", "Diff Words", commLabel)
  data <- rbind(data, dataFrame)  
  
  

}

print(data)
print(xtable(data), type="html", file="answer-question-similarity.html")
