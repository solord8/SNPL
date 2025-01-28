##GOGA Snowy Plover Trends
#Marin Conservation Collaborative
#Daniel Solorzano-Jones
#1/21/2025

#Setting my directory
setwd("~/MCC/SNPL/Data")

#Load required packages
library(tidyverse)

#Load the complete Ocean Beach dataset (unique records for each SurveyDate-Section)
OB <- read.csv("OBcomplete.csv", header=T, stringsAsFactors = F)
head(OB)


#HUMAN DOG Data

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
shorebird <- read.csv("Shorebirds_CLEAN.csv", header = TRUE, stringsAsFactors = F)
head(shorebird)

#Grouping mean counts by species
shore_annual_avgs <- shorebird %>%
  group_by(SurveyYear) %>%
  summarize(avg_WILL = mean(NumWillets), avg_SAND = mean(NumSanderlings),
            avg_MAGO = mean(NumGodwits), avg_HEER = mean(NumHeermanGulls),
            avg_RBGU = mean(NumRingbilledGulls), avg_WEGU = mean(NumWesternGulls))
view(shore_annual_avgs)

#Transform to long format
long_shore <- shore_annual_avgs %>%
  pivot_longer(
    cols = starts_with("avg"),
    names_to = "Species",
    values_to = "MeanCount"
  )
view(long_shore)

#Shorebird means by species per year
ggplot(long_shore, mapping = aes(x = SurveyYear, y = MeanCount, color = Species)) +
  geom_line()

#Lets look at birds that have a smaller abundance
rare_birds <- long_shore %>% 
  filter(!Species %in% c("avg_WEGU", "avg_HEER", "avg_SAND"))
ggplot(rare_birds, mapping = aes(x = SurveyYear, y = MeanCount, color = Species)) +
  geom_line()
