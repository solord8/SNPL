##GOGA Snowy Plover Trends
#Marin Conservation Collaborative
#Daniel Solorzano-Jones
#1/21/2025

#Setting my directory
setwd("~/MCC/SNPL")

#Load required packages
library(tidyverse)


##HUMAN DOG Data

#Import Human & Dog dataset
hum_dog <- read.csv("Humans_Dogs_CLEAN.csv", header = TRUE, stringsAsFactors = F)
view(hum_dog)

hum_dog_grouped <- hum_dog %>%
  group_by(SurveyYear, Section) %>%
  summarize(avg_hum = mean(NumHumans), avg_roam_dog = mean(NumDogsRoaming))
view(hum_dog_grouped)

#Plotting
ggplot(hum_dog_grouped, mapping = aes(x = SurveyYear, y = avg_hum)) + 
  geom_point(aes(color = Section))
ggplot(hum_dog_grouped, mapping = aes(x = SurveyYear, y = avg_hum, group = Section)) + 
  geom_boxplot()


##SHOREBIRD Data







       
