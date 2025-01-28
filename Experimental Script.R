##Experimental Script
##Daniel Solorzano-Jones

library(tidyverse)

#OBcomplete.csv currently contains SNPL, CORA & DogHum data.
OB_incomplete <- read.csv("OB_SnplHumDogCora.csv",header = TRUE, stringsAsFactors = F)
shore <- read.csv("Shorebirds_CLEAN.csv",header = TRUE, stringsAsFactors = F)

#I want to add the Shorebird data using a unique SurveyDate and Section columns.
shore_selection <- shore %>% 
  select(SurveyDate, Section, NumWillets, NumSanderlings, NumGodwits, NumHeermanGulls, NumWesternGulls, NumRingbilledGulls)
OB_complete <- left_join(OB_incomplete, shore_selection, by = c("SurveyDate", "Section"))
view(OB_complete)
#Lets turn NAs to 0s for surveys where shorebird data was not collected.
OB_complete[is.na(OB1)] <- 0
#Create a CSV with merged data
write.csv(OB_complete,"~/MCC/SNPL/Data/OBcomplete.csv")
