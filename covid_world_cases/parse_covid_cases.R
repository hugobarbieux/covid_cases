# You can either download the dataset at https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide
# Save it in a .csv
# The data are updated everyday, check the website every morning and repeat the operations

# Import dataset in a variable

covidworldcases <- read.csv("COVID-19-geographic-disbtribution-worldwide-2020-03-23.csv")

View(covidworldcases)

##### OR #####
# Script for downloading the Excel file into "R" software
# These libraries are necessary

library(readxl)

library(httr)

#create the URL where the dataset is stored with automatic updates every day

url <- paste("https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-",format(Sys.time(), "%Y-%m-%d"), ".xlsx", sep = "")

#download the dataset from the website to a local temporary file

GET(url, authenticate(":", ":", type="ntlm"), write_disk(tf <- tempfile(fileext = ".xlsx")))

#read the Dataset sheet into "R"

covidworldcases <- read_excel(tf)

View(covidworldcases)

# Optional - Examine the data

dim(covidworldcases)
names(covidworldcases)
nrow(covidworldcases)
ncol(covidworldcases)
head(covidworldcases)
tail(covidworldcases)
summary(covidworldcases)

##########

# Improve the dataset by importing list of country with region and ISO-2 code

countrieslist <- read.csv("countrieslist.csv")
View(countrieslist)

# Keep only useful columns

countrieslistsomecolumns <- countrieslist [c(2, 6)]
View(countrieslistsomecolumns)

# Join the two data frames by ISO-2 codes to correspond country names with the region

install.packages("dplyr")
library(dplyr)
covidworldcasesplusregion <- full_join(countrieslistsomecolumns, covidworldcases, by = "GeoId")
View(covidworldcasesplusregion)

# Keep only African countries

africa <- subset(covidworldcasesplusregion, covidworldcasesplusregion$"region" == "Africa")

# See what African countries are more impacted by the virus

deathsinafrica <- tapply(africa$Deaths, africa$"Countries and territories", sum)
deathsinafrica <- deathsinafrica[order(-deathsinafrica)]
View(deathsinafrica)

##########
# Generate a sort of pivot table, apply a sum to the Deaths column and aggregate it by the Countries column

tapply(covidworldcases$Deaths, covidworldcases$"Countries and territories", sum)

# Put the "pivot table" in a new variable

deathsbycountry <- tapply(covidworldcases$Deaths, covidworldcases$"GeoId", sum)
View(deathsbycountry)

# Order it

deathsbycountry <- deathsbycountry[order(-deathsbycountry)]
View(deathsbycountry)

# Select only the 50 first rows

deathsbycountry <- deathsbycountry[c(1:50)]

# Create a bar chart with "pivot" values

barplot(height = deathsbycountry)

# Export "pivot" to use it with any visualisation program

write.csv(casesbycountry, file='cases_by_country.csv')
write.csv(deathsbycountry, file = "deaths_by_country.csv")

##########
# Subset the dataset by country
# Keep useful columns
# Make cummulative count
# Keep only values greater than 0 (to begin the day the first death is recorded)

Egypt <- subset(covidworldcasesplusregion, covidworldcasesplusregion$"Countries and territories" == "Egypt")
Egypt <- Egypt [c(3,8,9)]
Egypt <- Egypt[order(Egypt$DateRep),]
Egypt <- cumsum(Egypt[, 2])
Egypt <- subset(Egypt, Egypt > 0)
View(Egypt)
write.csv(Egypt, file = "Egypt.csv")

China <- subset(covidworldcasesplusregion, covidworldcasesplusregion$"Countries and territories" == "China")
China <- China [c(3,8,9)]
China <- China[order(China$DateRep),]
China <- cumsum(China[, 2])
China <- subset(China, China > 0)
write.csv(China, file="China.csv")

Italy <- subset(covidworldcasesplusregion, covidworldcasesplusregion$"Countries and territories" == "Italy")
Italy <- Italy [c(3,8,9)]
Italy <- Italy[order(Italy$DateRep),]
Italy <- cumsum(Italy[, 2])
Italy <- subset(Italy, Italy > 0)
write.csv(Italy, file="Italy.csv")

France <- subset(covidworldcasesplusregion, covidworldcasesplusregion$"Countries and territories" == "France")
France <- France [c(3,8,9)]
France <- France[order(France$DateRep),]
France <- cumsum(France[, 2])
France <- subset(France, France > 0)
write.csv(France, file="France.csv")

United_Kingdom <- subset(covidworldcasesplusregion, covidworldcasesplusregion$"Countries and territories" == "United_Kingdom")
United_Kingdom <- United_Kingdom [c(3,8,9)]
United_Kingdom <- United_Kingdom[order(United_Kingdom$DateRep),]
United_Kingdom <- cumsum(United_Kingdom[, 2])
United_Kingdom <- subset(United_Kingdom, United_Kingdom > 0)
write.csv(United_Kingdom, file="United_Kingdom.csv")

United_States <- subset(covidworldcasesplusregion, covidworldcasesplusregion$"Countries and territories" == "United_States_of_America")
United_States <- United_States [c(3,8,9)]
United_States <- United_States[order(United_States$DateRep),]
United_States <- cumsum(United_States[, 2])
United_States <- subset(United_States, United_States > 0)
write.csv(United_States, file="United_States.csv")

##########
ThreeCountries <- rbind(Italy, France, United_Kingdom)
View(ThreeCountries)
write.csv(ThreeCountries, file="threecountries.csv")

# Create a bar chart

barplot(height = Italy$Deaths, xlab = "Day")

##########

