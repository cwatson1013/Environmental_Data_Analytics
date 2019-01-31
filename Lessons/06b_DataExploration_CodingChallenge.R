# Environmental Data Analytics Coding Challenge #1: Data Exploration

## The following code explores the EPA ECOTOX database entries for neonicotinoid mortality.
## The code contains numerous mistakes and errors, which you are tasked with fixing.
## Instructions listed in comments throughout the script.

#### Setup ----
setwd("/Users/carolinewatson/Documents/Spring 2019/Environmental Data Analytics/Env_Data_Analytics/Assignments")

library("tidyverse")

ecotox.neonic <- read.csv("./Data/Raw/ECOTOX_Neonicotinoids_Mortality_raw.csv")

#### Basic Data Summaries ----
head(ecotox.neonic)
summary(ecotox.neonic$Chemical.Name)
summary(ecotox.neonic$Pub..Year)

# Fix formatting of column names (spaces originally present were turned to periods upon import)
colnames(ecotox.neonic)[8:12] <- c("Duration", "Conc.Type", "Conc.Mean", "Conc.Units", "Pub.Year")

# Plot histogram of counts of publication years
ggplot(ecotox.neonic) +
  geom_histogram(aes(x = Pub.Year))

# Plot histogram of counts chemical names
# hint: what is the class of Chemical.Name? There are two options for a solution.
ecotox.neonic$Chemical.Name <- as.numeric(ecotox.neonic$Chemical.Name)
class(ecotox.neonic$Chemical.Name)

ggplot(ecotox.neonic) +
  geom_histogram(aes(x = Chemical.Name))

# Plot frequency polygon of publication years divided by chemical name
# Define colors as something other than ggplot default 
ggplot(ecotox.neonic) +
  geom_freqpoly(aes(x = Pub.Year, color = "red", bins = 20)) +
  geom_freqpoly(aes(x = Pub.Year, color = "purple", bins = 20)) +
  geom_freqpoly(aes(x = Pub.Year, color = "blue", bins = 20))
  theme(legend.position = "right")
  
  ggplot(ecotox.neonic) + 
  geom_freqpoly(aes(x = Pub.Year, color = "blue")) +
  geom_freqpoly(aes(x = Pub.Year, color = "purple"))
  theme(legend.position = "right")
  
  ##still don't understand how to do this
